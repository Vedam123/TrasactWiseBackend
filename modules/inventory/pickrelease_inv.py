from flask import jsonify, json, request, Blueprint
from modules.security.permission_required import permission_required
from decimal import Decimal
import uuid
from config import WRITE_ACCESS_TYPE
from modules.admin.databases.mydb import get_database_connection
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.inventory.routines.insert_pick_and_ship_stage import insert_pick_and_ship_stage
from modules.inventory.routines.get_available_inventory import get_available_inventory
from modules.sales.routines.fetch_sales_order_details import fetch_sales_order_details
from modules.common.routines.get_conversion_factor import get_conversion_factor
from modules.sales.routines.log_pick_release import log_pick_release
from modules.employee.routines.fetch_employee_details import fetch_employee_details
from modules.utilities.logger import logger

pickrelease_inv_api = Blueprint('pickrelease_inv_api', __name__)

@pickrelease_inv_api.route('/pickrelease_inv', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def pickrelease_inv():
    MODULE_NAME = __name__
    mydb = None
    mycursor = None
    execution_id = generate_execution_id()

    try:
        logger.info(f"Received request: {request.method} {request.url}")

        authorization_header = request.headers.get('Authorization')
        logger.debug(f"Authorization Header: {authorization_header}")

        token_results = get_user_from_token(authorization_header)
        USER_ID = token_results["username"] if token_results else ""
        logger.debug(f"User ID from Token: {USER_ID}")

        data = request.get_json()
        logger.debug(f"Request Data: {data}")

        full_picking = data.get('full_picking')
        logger.debug(f"Full Picking: {full_picking}")

        full_qty_alloc_status = data.get('full_qty_alloc_status')
        part_qty_alloc_status = data.get('part_qty_alloc_status')
        ship_status  = data.get('ship_status')
        look_only_inventory_ids = data.get("look_only_inventory_ids", [])

        if full_picking != "Yes":
            logger.warning("Full picking is not enabled")
            return jsonify(message='Full picking is not enabled'), 400

        current_userid = None
        if authorization_header.startswith('Bearer '):
            token = authorization_header.replace('Bearer ', '')
            decoded_token = decode_token(token)
            current_userid = decoded_token.get('Userid')
        logger.debug(f"Current User ID from Token: {current_userid}")

        sales_orders = data.get('sales_orders')
        logger.debug(f"Sales Orders: {sales_orders}")

       
        if not sales_orders:
            logger.error("No sales orders provided")
            return 'No sales orders provided', 400

        mydb = get_database_connection(USER_ID, MODULE_NAME)
        logger.debug(f"Database Connection established for User ID: {USER_ID}")

     
        details_by_id = fetch_employee_details(USER_ID, MODULE_NAME, mydb, user_id=current_userid)

        if details_by_id:
            empid = details_by_id["empid"]
            name = details_by_id["name"]
            print(f"Employee ID: {empid}, Name: {name}")
        else:
            print("No details found by user ID")

        picker_id = details_by_id["empid"]

        updated_headers = set()

        for sales_order in sales_orders:
            sales_header_id = sales_order.get('sales_header_id')
            shipping_method = ""
            shipping_address = ""
            details = fetch_sales_order_details(USER_ID, MODULE_NAME, mydb, sales_header_id)
            if details:
                logger.debug("Sales Order Details:")
                shipping_method = details.get("shipping_method")
                shipping_address = details.get("shipping_address")
                logger.debug(f"Shipping Method: {shipping_method}")
                logger.debug(f"Shipping Address: {shipping_address}")
            else:
                logger.debug(f"No details found for Header ID {sales_header_id}")
            sales_order_lines = sales_order.get('sales_order_lines')
            logger.debug(f"Processing Sales Header ID: {sales_header_id}")
            logger.debug(f"Sales Order Lines: {sales_order_lines}")

            for line in sales_order_lines:
                result = None
                status_code = None
                sales_order_line_id = line.get('sales_order_line_id')
                #current_status = get_sales_order_line_status(sales_order_line_id, mydb)
                current_status = line.get('sales_line_status')
                if current_status is None:
                    result = jsonify(message=f"Fetched status for Sales Order Line ID: {sales_order_line_id} is NULL : {current_status}")
                    status_code = 200
                    logger.debug(f"Fetched status for Sales Order Line ID: {sales_order_line_id} is NULL : {current_status}")
                    continue

                logger.debug(f"Fetched status for Sales Order Line ID: {sales_order_line_id} is {current_status}")

                if current_status == full_qty_alloc_status:
                    result = jsonify(message=f"The Sales order line: {sales_order_line_id} is already fully Picked and its status is  : {current_status}")
                    logger.debug(f"Skipping allocation for Sales Order Line ID: {sales_order_line_id} as it is fully allocated")
                    continue
                logger.debug(f"Processing Sales Order Line: {line}")
                result, status_code = allocate_inventory(line, execution_id,sales_header_id, look_only_inventory_ids,
                                                         full_qty_alloc_status, part_qty_alloc_status, shipping_method,shipping_address,ship_status,
                                                         picker_id,mydb, current_userid, MODULE_NAME)
                if status_code == 200:
                    updated_headers.add(sales_header_id)
                    mydb.commit()
                elif status_code != 200:
                    logger.warning(f"Processing failed for sales header ID and line: {sales_header_id}, {line}")
                    mydb.rollback()
                    continue
                    ##return jsonify(message=f"Processing failed for sales header ID: {sales_header_id}"), status_code

            for sales_header_id in updated_headers:
                result, status_code = update_sales_order_status(sales_header_id, full_qty_alloc_status, part_qty_alloc_status, mydb, current_userid, MODULE_NAME)
                logger.debug(f"Updated Sales Order Status for Header ID: {sales_header_id}")

        mydb.commit()
        logger.info("Process is completed")
        return result, status_code

    except Exception as e:
        logger.error(f"Error occurred: {str(e)}")
        if mydb:
            mydb.rollback()
        return jsonify(message='Processing failed'), 422

    finally:
        if mycursor:
            mycursor.close()
        if mydb:
            mydb.close()

def allocate_inventory(line, execution_id,sales_header_id, look_only_inventory_ids,
                       full_qty_alloc_status,part_qty_alloc_status, shipping_method,shipping_address, 
                       ship_status,picker_id,mydb, current_userid, MODULE_NAME):
    try:
        sales_order_line_id = line['sales_order_line_id']
        sales_item_id = line['sales_item_id']
        sales_uom_id = line['sales_uom_id']
        sales_uom_id_quantity = line['sales_uom_id_quantity']        
        sales_base_uom_id = line['sales_base_uom_id']
        sales_base_uom_quantity = line['sales_base_uom_quantity']
        already_picked_quantity = line.get('already_picked_quantity')
        sales_line_status = line.get('sales_line_status')
        if (already_picked_quantity is None) or (already_picked_quantity == "") :
            already_picked_quantity = 0
        required_quantity = sales_base_uom_quantity - already_picked_quantity

        logger.debug(f"Allocating Inventory for Line ID: {sales_order_line_id}, Item ID: {sales_item_id}, UOM ID: {sales_base_uom_id}, Quantity: {required_quantity}")

        available_inventory = get_available_inventory(sales_item_id, look_only_inventory_ids,mydb, current_userid, MODULE_NAME)
        logger.debug(f"Available Inventory: {available_inventory}")
        total_allocated = 0

        for inventory in available_inventory:
            logger.debug(f"Processing Inventory: {inventory}")
            if inventory['status'] == 'Yes':
                logger.debug("Inventory already allocated, skipping")
                continue
            new_inventory_id = 0
            inv_quantity = inventory['quantity']
            inv_uom_id = inventory['uom_id']
            logger.debug(f"Inventory UOM ID: {inv_uom_id}, Sales UOM ID: {sales_base_uom_id}")

            if int(inv_uom_id) == int(sales_base_uom_id):
                logger.debug(f"IF Part Inventory: {inventory}")
                conversion_factor = 1  # Default conversion factor when uom_id matches sales_base_uom_id
                #result = find_lowest_uom_and_cf(inv_uom_id, mydb, current_userid, MODULE_NAME)
                result = get_conversion_factor(inv_uom_id, inv_uom_id, mydb, current_userid, MODULE_NAME)
                conversion_factor = result['conversion_factor']
                lowest_base_unit = result['lowest_base_unit']
                convertible_quantity = inv_quantity
                convertable_quantity_lb = convertible_quantity
                lowest_base_unit_conv_factor = result['lowest_conversion_factor']                
            else:
                logger.debug(f"Else Part Inventory: {inventory}")
                result = get_conversion_factor(inv_uom_id, sales_base_uom_id, mydb, current_userid, MODULE_NAME)
                conversion_factor = result['conversion_factor']
                lowest_base_unit = result['lowest_base_unit']
                lowest_base_unit_conv_factor = result['lowest_conversion_factor']

                if lowest_base_unit_conv_factor is None:
                    logger.debug("There is no Lowest base unit for the given UOM id.")
                    continue

                if conversion_factor is None:
                    logger.debug("No conversion factor found. Assuming UOMs are not convertible.")
                    continue
                
                convertible_quantity = inv_quantity * conversion_factor

                convertable_quantity_lb = inv_quantity * lowest_base_unit_conv_factor

            logger.debug(f"Convertible Quantity: {convertible_quantity}")

            logger.debug(f"Lowest based unit Convertible Quantity: {convertable_quantity_lb}")

            if convertable_quantity_lb <= (required_quantity - total_allocated):
                logger.debug(f"if condition entered as convertable quanity is less than sales line qty - total allocated: {convertable_quantity_lb}")
                allocated_quantity = convertable_quantity_lb
                
                logger.debug(f"Allocating Quantity: {allocated_quantity}")

                if int(inv_uom_id) == int(sales_base_uom_id):
                    allocated_quantity_in_base_uom = allocated_quantity
                    remaining_quantity = inv_quantity - allocated_quantity_in_base_uom
                    logger.debug(f"Same UOM section allocated quantity: {allocated_quantity}")
                    logger.debug(f"Same UOM section remaining quantity: {remaining_quantity}")
                else:
                    allocated_quantity_in_base_uom = allocated_quantity / lowest_base_unit_conv_factor
                    remaining_quantity = inv_quantity - allocated_quantity_in_base_uom
                    logger.debug(f"Different UOM section allocated quantity: {allocated_quantity}")
                    logger.debug(f"Different UOM section remaining quantity: {remaining_quantity}")

                # Update inventory for the allocated quantity
                response_json, status_code =update_inventory(execution_id,inventory, allocated_quantity_in_base_uom, sales_header_id, 
                                                             sales_order_line_id, sales_line_status,shipping_method,shipping_address,
                                                             sales_item_id,ship_status,picker_id,mydb, current_userid, MODULE_NAME)
                
                response_data = json.loads(response_json)
                if status_code == 200:
                    # Success: Extract inventory_id from response_data
                    new_inventory_id = response_data.get('inventory_id')
                    logger.info(f"Inventory updated successfully with Inventory ID: {new_inventory_id}")
                else:
                    # Error: Handle the error case
                    error_message = response_data.get('error')
                    logger.error(f"Error updating inventory: {error_message}")
                #total_allocated += allocated_quantity
                total_allocated += allocated_quantity_in_base_uom

                logger.debug(f"total_allocated Quantity before if break: {total_allocated}")
                logger.debug(f"allocated Quantity before if break: {allocated_quantity_in_base_uom}")
                if required_quantity == total_allocated:
                    break

            else:
                # Allocate all convertible quantity
                allocated_quantity = required_quantity - total_allocated

                if int(inv_uom_id) == int(sales_base_uom_id):
                    allocated_quantity_in_base_uom = allocated_quantity
                    remaining_quantity = convertable_quantity_lb - allocated_quantity_in_base_uom
                else:
                    allocated_quantity_in_base_uom = allocated_quantity 
                    remaining_quantity = convertable_quantity_lb - allocated_quantity_in_base_uom

                if remaining_quantity > 0:
                    logger.debug(f"Yes, Remaining quantity is greater than 0: {remaining_quantity}")
                    response_json, status_code = create_new_inventory_row(execution_id,inventory, allocated_quantity_in_base_uom, lowest_base_unit, 
                                                                          sales_header_id,sales_order_line_id, sales_line_status,shipping_method,shipping_address,
                                                                          sales_item_id,ship_status,picker_id,mydb, current_userid, MODULE_NAME)
                    
                    response_data = json.loads(response_json)
                    if status_code == 200:
                        # Success: Extract inventory_id from response_data
                        new_inventory_id = response_data.get('inventory_id')
                        logger.info(f"New Inventory Row created successfully with Inventory ID: {new_inventory_id}")
                    else:
                        # Error: Handle the error case
                        error_message = response_data.get('error')
                        logger.error(f"Error creating new inventory row: {error_message}")

                    #update_inventory_remaining(inventory, remaining_quantity, lowest_base_unit, inv_uom_id, mydb, current_userid, MODULE_NAME, updated_by)
                    update_inventory_remaining(inventory, remaining_quantity, lowest_base_unit,
                                               mydb, current_userid, MODULE_NAME)
                else:
                    response_json, status_code =update_inventory(execution_id, inventory, allocated_quantity_in_base_uom, sales_header_id, 
                                                                 sales_order_line_id, sales_line_status,shipping_method,shipping_address,
                                                                 sales_item_id,ship_status,picker_id,mydb, current_userid, MODULE_NAME)
                    
                    response_data = json.loads(response_json)
                    if status_code == 200:
                        # Success: Extract inventory_id from response_data
                        new_inventory_id = response_data.get('inventory_id')
                        logger.info(f"Inventory updated successfully with Inventory ID: {new_inventory_id}")
                    else:
                        # Error: Handle the error case
                        error_message = response_data.get('error')
                        logger.error(f"Error updating inventory: {error_message}")

                total_allocated += allocated_quantity_in_base_uom

                logger.debug(f"total_allocated Quantity before else break: {total_allocated}")
                logger.debug(f"allocated Quantity before else break: {allocated_quantity_in_base_uom}")
                if required_quantity == total_allocated:
                    break
        
        if total_allocated > 0 : 
            result, status_code = update_sales_order_lines_status(execution_id,sales_header_id,sales_order_line_id,full_qty_alloc_status,
                                                                  part_qty_alloc_status, total_allocated, shipping_method,shipping_address,
                                                                  sales_item_id,ship_status,picker_id,mydb, current_userid, MODULE_NAME)
            logger.debug(f"sales order line status function is executed and came out for the line: {sales_order_line_id}")
            logger.debug(f"sales order line status update after result: {result}")
            if status_code == 200:
                response_data = json.loads(result.get_data(as_text=True))  # Assuming result is a Flask Response object
                status = response_data.get('status')

                logger.debug(f"Extracted status after sales order line update is done: {status}")

                logger.info(f"Sales Order Line {sales_order_line_id} updated successfully with status: {status}")
            else:
                # Error: Handle the error case
                error_message = response_data.get('error')
                logger.error(f"Error updating sales order line: {error_message}")     
        else:
            result = jsonify(message=f"No Inventory is allocated to Sales order line {sales_order_line_id}")
            status_code = 201
        
        logger.debug(f"Result from Sales order lines status : {result}")
        logger.debug(f"Status from Sales order lines status :{status_code}")

        return result, status_code
    except Exception as e:
        logger.error(f"{current_userid} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return jsonify(message=f"Processing failed "),400

def create_new_inventory_row(execution_id, inventory, remaining_quantity, sales_base_uom_id, sales_header_id, 
                             sales_order_line_id, sales_line_status,shipping_method,shipping_address,sales_item_id,
                             ship_status,picker_id,mydb, current_userid, MODULE_NAME):
    try:
        mycursor = mydb.cursor()
        logger.debug(f"Creating New Inventory Row for Inventory ID: {inventory['inventory_id']}, Remaining Quantity: {remaining_quantity}")

        insert_query = """
            INSERT INTO inv.item_inventory (transaction_id, transaction_type, item_id, uom_id, quantity, bin_id, rack_id, row_id, aisle_id, zone_id, location_id, warehouse_id, status, subject, additional_info, created_at, updated_at, created_by, updated_by)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, NOW(), NOW(), %s, %s)
        """
        mycursor.execute(insert_query, (
            inventory['transaction_id'],
            inventory['transaction_type'],
            inventory['item_id'],
            sales_base_uom_id,
            remaining_quantity,
            inventory['bin_id'],
            inventory['rack_id'],
            inventory['row_id'],
            inventory['aisle_id'],
            inventory['zone_id'],
            inventory['location_id'],
            inventory['warehouse_id'],
            'Yes',
            f'Sales Order ID: {sales_header_id}, Sales Order Line ID: {sales_order_line_id}',
            inventory['additional_info'],
            current_userid,
            current_userid
        ))
        #mydb.commit()
        logger.debug(f"New Inventory row created successfully for Inventory ID: {inventory['inventory_id']}")

        # Retrieve the newly generated inventory_id
        inventory_id = mycursor.lastrowid
     
        log_pick_release(execution_id, sales_header_id, sales_order_line_id, sales_line_status, 
            inventory_id, remaining_quantity,  current_userid, mydb)
        
        insert_pick_and_ship_stage(current_userid, MODULE_NAME, mydb, execution_id, sales_header_id, sales_order_line_id, sales_item_id, 
                inventory['inventory_id'], remaining_quantity, picker_id, 
                ship_status, shipping_method, shipping_address) 

        # Return JSON response with inventory_id and success status code
        return json.dumps({"inventory_id": inventory_id}), 200

    except Exception as e:
        logger.error(f"{current_userid} --> {MODULE_NAME}: Error in creating new inventory row: {str(e)}")
        return json.dumps({"error": str(e)}), 500  # Return error response in case of exception

    finally:
        if mycursor:
            mycursor.close()

def update_inventory_remaining(inventory, remaining_quantity, 
                               sales_base_uom_id,mydb, current_userid, MODULE_NAME):
    try:
        mycursor = mydb.cursor()
        logger.debug(f"Updating Inventory Remaining Quantity for Inventory ID: {inventory['inventory_id']}, Remaining Quantity: {remaining_quantity}")

        update_query = """
            UPDATE inv.item_inventory
            SET quantity = %s, uom_id = %s ,  updated_at = NOW(), updated_by = %s
            WHERE inventory_id = %s
        """
        mycursor.execute(update_query, (
            remaining_quantity,
            sales_base_uom_id,
            current_userid,
            inventory['inventory_id']
        ))
        #mydb.commit()
        logger.debug(f"Inventory updated successfully for remaining quantity for Inventory ID: {inventory['inventory_id']}")

    except Exception as e:
        logger.error(f"{current_userid} --> {MODULE_NAME}: Error in updating inventory remaining quantity: {str(e)}")
    finally:
        if mycursor:
            mycursor.close()


def update_inventory(execution_id, inventory, allocated_quantity_in_base_uom, sales_header_id, 
                     sales_order_line_id, sales_line_status,shipping_method,
                     shipping_address,sales_item_id,ship_status,picker_id,mydb, current_userid, MODULE_NAME):
    try:
        mycursor = mydb.cursor()
        logger.debug(f"Updating Inventory for Inventory ID: {inventory['inventory_id']}, Allocated Quantity: {allocated_quantity_in_base_uom}")

        update_query = """
            UPDATE inv.item_inventory
            SET quantity = %s, status = 'Yes', subject = %s, updated_at = NOW(), updated_by = %s
            WHERE inventory_id = %s
        """
        mycursor.execute(update_query, (
            allocated_quantity_in_base_uom,
            f'Sales Order ID: {sales_header_id}, Sales Order Line ID: {sales_order_line_id}',
            current_userid,
            inventory['inventory_id']
        ))
        #mydb.commit()
        logger.debug(f"Inventory updated successfully for Inventory ID: {inventory['inventory_id']}")

        log_pick_release(execution_id, sales_header_id, sales_order_line_id, sales_line_status, 
            inventory['inventory_id'], allocated_quantity_in_base_uom,  current_userid, mydb)
        
        insert_pick_and_ship_stage(current_userid, MODULE_NAME, mydb, execution_id, sales_header_id, sales_order_line_id, sales_item_id, 
                              inventory['inventory_id'], allocated_quantity_in_base_uom, picker_id, 
                               ship_status, shipping_method, shipping_address)    


        # Return JSON response with inventory_id and success status code
        return json.dumps({"inventory_id": inventory['inventory_id']}), 200

    except Exception as e:
        logger.error(f"{current_userid} --> {MODULE_NAME}: Error in updating inventory: {str(e)}")
        return json.dumps({"error": str(e)}), 500  # Return error response in case of exception

    finally:
        if mycursor:
            mycursor.close()


def update_sales_order_lines_status(execution_id, sales_header_id, sales_order_line_id, full_qty_alloc_status, 
                                    part_qty_alloc_status, total_allocated, shipping_method,shipping_address,sales_item_id,
                                    ship_status,picker_id,mydb, current_userid, MODULE_NAME):
    try:
        mycursor = mydb.cursor(dictionary=True)  # Use dictionary cursor to fetch results as dictionaries
        logger.debug(f"Updating Sales Order Line Status and Picked Quantity for Line ID: {sales_order_line_id}")

        # Fetch current picked_quantity and quantity from sales_order_lines table
        select_query = """
            SELECT picked_quantity, quantity, base_uom_id, base_quantity,status
            FROM sal.sales_order_lines
            WHERE header_id = %s and line_id = %s
        """
        mycursor.execute(select_query, (sales_header_id,sales_order_line_id))
        result = mycursor.fetchone()

        if not result:
            logger.error(f"No sales order line found with header id , line id: {sales_header_id} {sales_order_line_id}")
            return f"No Sales Order line found with {sales_header_id} {sales_order_line_id}", 400

        
        picked_quantity = Decimal(result['picked_quantity'] or 0)  # Access elements using string keys
        quantity = Decimal(result['quantity'])
        base_uom_id = int(result['base_uom_id'])
        base_quantity = Decimal(result['base_quantity'])
        current_sales_line_status = result['status']
        total_allocated = Decimal(total_allocated)

        logger.debug(f"Current Picked Quantity: {picked_quantity}, Current Quantity: {quantity}")

        # Calculate new picked_quantity based on allocated quantities
        new_picked_quantity = picked_quantity + total_allocated

        logger.debug(f"New Picked Quantity after allocation: {new_picked_quantity}")
        logger.debug(f"Total Allocated : {total_allocated}")
        logger.debug(f"Sales Lines quantity : {quantity}")
        logger.debug(f"Sales Lines base quantity : {base_quantity}")
        logger.debug(f"Sales Lines base uom id : {base_uom_id}")

        # Update picked_quantity in sales_order_lines table

        logger.debug(f"Before updating sales order lines picked quanity : {new_picked_quantity}")
        update_query = """
            UPDATE sal.sales_order_lines
            SET picked_quantity = %s,
                updated_at = NOW(),
                updated_by = %s
            WHERE line_id = %s
        """
        mycursor.execute(update_query, (new_picked_quantity, current_userid, sales_order_line_id))
        #mydb.commit()

        logger.debug(f"Picked quantity updated successfully for Line ID: {sales_order_line_id}")

        # Determine status based on picked_quantity
        logger.debug(f"Before Assiging the status value to update in sales order lines new picked quanity : {new_picked_quantity}")
        logger.debug(f"Before Assiging the status value to update in sales order lines quantity : {quantity}")
        if round(new_picked_quantity,0) == round(base_quantity,0):
            status = full_qty_alloc_status
        elif new_picked_quantity < base_quantity:
            status = part_qty_alloc_status
        else:
            logger.error(f"Picked quantity exceeds quantity in sales order line: {new_picked_quantity} > {base_quantity}")
            raise Exception("Picked quantity exceeds quantity in sales order line")

        # Update status in sales_order_lines table
        logger.debug(f"Status to update in sales order lines: {status}")
        update_status_query = """
            UPDATE sal.sales_order_lines
            SET status = %s,
                updated_at = NOW(),
                updated_by = %s
            WHERE line_id = %s
        """
        mycursor.execute(update_status_query, (status, current_userid, sales_order_line_id))
        #mydb.commit()

        logger.debug(f"Sales Order Line status updated to: {status} for Line ID: {sales_order_line_id}")

        log_pick_release(execution_id, sales_header_id, sales_order_line_id, current_sales_line_status, 
                     None, new_picked_quantity,  current_userid, mydb)
              
        response = {
            "message": f"Sales Order line {sales_order_line_id} is updated successfully with the status {status}",
            "status": status  # Optionally return the status itself in the JSON response
        }
        return jsonify(response), 200

    except Exception as e:
        logger.error(f"{current_userid} --> {MODULE_NAME}: Error in updating sales order line status and picked quantity: {str(e)}")
    finally:
        if mycursor:
            mycursor.close()


def update_sales_order_status(sales_header_id, full_qty_alloc_status, part_qty_alloc_status, mydb, current_userid, MODULE_NAME):
    try:
        logger.debug(f"Updating Sales Order Status for Header ID: {sales_header_id}")
        query = """
        SELECT status
        FROM sal.sales_order_lines
        WHERE header_id = %s;
        """
        mycursor = mydb.cursor()
        mycursor.execute(query, (sales_header_id,))
        sales_line_statuses = mycursor.fetchall()

        new_status = None

        logger.debug(f"{current_userid} --> {MODULE_NAME}:Sales Line Statuses: {sales_line_statuses}")

        if all(status[0] == full_qty_alloc_status for status in sales_line_statuses):
            new_status = full_qty_alloc_status
        elif any(status[0] == full_qty_alloc_status for status in sales_line_statuses):
            new_status = part_qty_alloc_status
        elif any(status[0] == part_qty_alloc_status for status in sales_line_statuses):
            new_status = part_qty_alloc_status
        else:
            new_status = None  # Default if no statuses match

        logger.debug(f"New Status for Sales Header ID {sales_header_id}: {new_status}")

        if new_status is not None:  # Execute update only if new_status is not None
            update_query = """
            UPDATE sal.sales_order_headers
            SET status = %s, updated_by = %s, updated_at = CURRENT_TIMESTAMP
            WHERE header_id = %s;
            """
            mycursor.execute(update_query, (new_status, current_userid, sales_header_id))
            mydb.commit()
            logger.debug(f"Updated Sales Order Header ID {sales_header_id} with Status {new_status}")
            return jsonify(message='Process completed Sales Order, Lines statuses are updated and available inventory allocated'), 200
        else:
            logger.debug(f"No status update needed for Sales Header ID {sales_header_id} as new_status is None")
            return jsonify(message='Process completed Some of the Sales Order headers are not processed'), 200

    except Exception as e:
        logger.error(f"Error occurred during sales order status update: {str(e)}")
        return jsonify(message='Process completed With Error '), 500
    finally:
        mycursor.close()


def generate_execution_id():
    return str(uuid.uuid4())