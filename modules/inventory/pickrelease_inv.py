from flask import jsonify, request, Blueprint
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from modules.admin.databases.mydb import get_database_connection
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

pickrelease_inv_api = Blueprint('pickrelease_inv_api', __name__)

@pickrelease_inv_api.route('/pickrelease_inv', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def pickrelease_inv():
    MODULE_NAME = __name__
    mydb = None
    mycursor = None

    try:
        logger.info(f"Received request: {request.method} {request.url}")

        authorization_header = request.headers.get('Authorization')
        logger.debug(f"Authorization Header: {authorization_header}")

        token_results = get_user_from_token(authorization_header)
        USER_ID = token_results["username"] if token_results else ""
        logger.debug(f"User ID from Token: {USER_ID}")

        data = request.get_json()
        logger.debug(f"Request Data: {data}")

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

        for sales_order in sales_orders:
            sales_header_id = sales_order.get('sales_header_id')
            full_qty_alloc_status = sales_order.get('full_qty_alloc_status')
            part_qty_alloc_status = sales_order.get('part_qty_alloc_status')
            sales_order_lines = sales_order.get('sales_order_lines')
            logger.debug(f"Processing Sales Header ID: {sales_header_id}")
            logger.debug(f"Sales Order Lines: {sales_order_lines}")

            for line in sales_order_lines:
                sales_order_line_id = line.get('sales_order_line_id')
                current_status = get_sales_order_line_status(sales_order_line_id, mydb)

                if current_status is None:
                    return jsonify(message='Error fetching sales order line status'), 500

                logger.debug(f"Fetched status for Sales Order Line ID: {sales_order_line_id} is {current_status}")

                if current_status == full_qty_alloc_status:
                    logger.debug(f"Skipping allocation for Sales Order Line ID: {sales_order_line_id} as it is fully allocated")
                    continue
                logger.debug(f"Processing Sales Order Line: {line}")
                result, status_code = allocate_inventory(line, sales_header_id, full_qty_alloc_status, part_qty_alloc_status, mydb, current_userid, MODULE_NAME, current_userid, current_userid)
                if status_code != 200:
                    logger.error(f"Processing failed for sales header ID and line: {sales_header_id}, {line}")
                    return jsonify(message=f"Processing failed for sales header ID: {sales_header_id}"), status_code

            #update_sales_order_lines_status(sales_header_id, full_qty_alloc_status, part_qty_alloc_status, mydb, current_userid, MODULE_NAME)
            #logger.debug(f"Updated Sales Order Lines status for Header ID: {sales_header_id}")
            logger.error(f"Now going to update Sales Order header: {sales_header_id}")
            update_sales_order_status(sales_header_id, full_qty_alloc_status, part_qty_alloc_status, mydb, current_userid, MODULE_NAME)
            logger.debug(f"Updated Sales Order Status for Header ID: {sales_header_id}")

        logger.info("All sales orders processed successfully")
        return result, 200

    except Exception as e:
        logger.error(f"Error occurred: {str(e)}")
        return jsonify(message='Processing failed'), 422

    finally:
        if mycursor:
            mycursor.close()
        if mydb:
            mydb.close()

def allocate_inventory(line, sales_header_id, full_qty_alloc_status,part_qty_alloc_status, mydb, current_userid, MODULE_NAME, created_by, updated_by):
    try:
        sales_order_line_id = line['sales_order_line_id']
        sales_item_id = line['sales_item_id']
        sales_uom_id = line['sales_uom_id']
        required_quantity = line['required_quantity']
        logger.debug(f"Allocating Inventory for Line ID: {sales_order_line_id}, Item ID: {sales_item_id}, UOM ID: {sales_uom_id}, Quantity: {required_quantity}")

        available_inventory = get_available_inventory(sales_item_id, mydb, current_userid, MODULE_NAME)
        logger.debug(f"Available Inventory: {available_inventory}")
        total_allocated = 0

        for inventory in available_inventory:
            logger.debug(f"Processing Inventory: {inventory}")
            if inventory['status'] == 'Yes':
                logger.debug("Inventory already allocated, skipping")
                continue

            inv_quantity = inventory['quantity']
            inv_uom_id = inventory['uom_id']
            logger.debug(f"Inventory UOM ID: {inv_uom_id}, Sales UOM ID: {sales_uom_id}")

            if int(inv_uom_id) == int(sales_uom_id):
                logger.debug(f"IF Part Inventory: {inventory}")
                conversion_factor = 1  # Default conversion factor when uom_id matches sales_uom_id
                convertible_quantity = inv_quantity
            else:
                logger.debug(f"Else Part Inventory: {inventory}")
                conversion_factor = get_conversion_factor(inv_uom_id, sales_uom_id, mydb, current_userid, MODULE_NAME)
                if conversion_factor is None:
                    logger.debug("No conversion factor found. Assuming UOMs are not convertible.")
                    continue
                convertible_quantity = inv_quantity * conversion_factor

            logger.debug(f"Convertible Quantity: {convertible_quantity}")

            if convertible_quantity <= (required_quantity - total_allocated):
                logger.debug(f"if condition entered as convertable quanity is less than sales line qty - total allocated: {convertible_quantity}")
                allocated_quantity = convertible_quantity
                
                logger.debug(f"Allocating Quantity: {allocated_quantity}")

                if int(inv_uom_id) == int(sales_uom_id):
                    allocated_quantity_in_base_uom = allocated_quantity
                    remaining_quantity = inv_quantity - allocated_quantity_in_base_uom
                    logger.debug(f"Same UOM section allocated quantity: {allocated_quantity}")
                    logger.debug(f"Same UOM section remaining quantity: {remaining_quantity}")
                else:
                    allocated_quantity_in_base_uom = allocated_quantity / conversion_factor
                    remaining_quantity = inv_quantity - allocated_quantity_in_base_uom
                    logger.debug(f"Different UOM section allocated quantity: {allocated_quantity}")
                    logger.debug(f"Different UOM section remaining quantity: {remaining_quantity}")

                # Update inventory for the allocated quantity
                update_inventory(inventory, allocated_quantity_in_base_uom, sales_header_id, sales_order_line_id, mydb, current_userid, MODULE_NAME, created_by, updated_by)

                # Create new inventory row if there is remaining quantity
                #if remaining_quantity > 0:
                #    if int(inv_uom_id) != int(sales_uom_id):
                #        create_new_inventory_row(inventory, remaining_quantity, sales_uom_id, sales_header_id, sales_order_line_id, mydb, current_userid, MODULE_NAME, created_by, updated_by)
                #        update_inventory_remaining(inventory, remaining_quantity, sales_uom_id, inv_uom_id, mydb, current_userid, MODULE_NAME, updated_by)

                total_allocated += allocated_quantity

                logger.debug(f"total_allocated Quantity before if break: {total_allocated}")
                logger.debug(f"allocated Quantity before if break: {allocated_quantity}")
                if required_quantity == total_allocated:
                    break

            else:
                # Allocate all convertible quantity
                allocated_quantity = required_quantity - total_allocated
                if int(inv_uom_id) == int(sales_uom_id):
                    allocated_quantity_in_base_uom = allocated_quantity
                    remaining_quantity = convertible_quantity - allocated_quantity
                else:
                    allocated_quantity_in_base_uom = allocated_quantity / conversion_factor
                    remaining_quantity = convertible_quantity - allocated_quantity

                # Update inventory for the allocated quantity
                if remaining_quantity > 0:
                    update_inventory_remaining(inventory, remaining_quantity, sales_uom_id, inv_uom_id, mydb, current_userid, MODULE_NAME, updated_by)
                else:
                    update_inventory(inventory, allocated_quantity_in_base_uom, sales_header_id, sales_order_line_id, mydb, current_userid, MODULE_NAME, created_by, updated_by)

                total_allocated += allocated_quantity

                logger.debug(f"total_allocated Quantity before else break: {total_allocated}")
                logger.debug(f"allocated Quantity before else break: {allocated_quantity}")
                if required_quantity == total_allocated:
                    break

        result, status_code = update_sales_order_lines_status(sales_order_line_id, full_qty_alloc_status,part_qty_alloc_status, total_allocated, mydb, current_userid, MODULE_NAME)
        logger.debug(f"sales order line status function is executed and came out for the line: {sales_order_line_id}")
        logger.debug(f"Result from Sales order lines status : {result}")
        logger.debug(f"Status from Sales order lines status :{status_code}")
        #if total_allocated == required_quantity:
        #    logger.debug(f"Total Allocated matches Sales Line Quantity for Line ID: {sales_order_line_id}")
        #    update_sales_order_lines_status(sales_order_line_id, full_qty_alloc_status, total_allocated, mydb, current_userid, MODULE_NAME)
        #    return 'Line allocated successfully', 200
        #else:
        #    logger.error(f"Insufficient quantity to allocate for Line ID: {sales_order_line_id}")
        #    update_sales_order_lines_status(sales_order_line_id, part_qty_alloc_status, total_allocated, mydb, current_userid, MODULE_NAME)
        #    return 'Insufficient quantity to allocate', 400
        return result, status_code
    except Exception as e:
        logger.error(f"{current_userid} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return 'Processing failed', 400
    
def get_sales_order_line_status(line_id, mydb):
    try:
        cursor = mydb.cursor(dictionary=True)
        query = """
            SELECT status
            FROM sal.sales_order_lines
            WHERE line_id = %s
        """
        cursor.execute(query, (line_id,))
        result = cursor.fetchone()
        return result['status'] if result else None
    except Exception as e:
        logger.error(f"Error fetching status for line ID {line_id}: {str(e)}")
        return None
    finally:
        cursor.close()

def update_inventory_status_subject(inventory, status, subject, mydb, current_userid, MODULE_NAME, updated_by):
    try:
        mycursor = mydb.cursor()
        logger.debug(f"Updating Inventory Status and Subject for Inventory ID: {inventory['inventory_id']}, Status: {status}, Subject: {subject}")

        update_query = """
            UPDATE inv.item_inventory
            SET status = %s, subject = %s, updated_at = NOW(), updated_by = %s
            WHERE inventory_id = %s
        """
        mycursor.execute(update_query, (
            status,
            subject,
            current_userid,
            inventory['inventory_id']
        ))
        mydb.commit()
        logger.debug(f"Inventory status and subject updated successfully for Inventory ID: {inventory['inventory_id']}")

    except Exception as e:
        logger.error(f"{current_userid} --> {MODULE_NAME}: Error in updating inventory status and subject: {str(e)}")
    finally:
        if mycursor:
            mycursor.close()

def create_new_inventory_row(inventory, remaining_quantity, sales_uom_id, sales_header_id, sales_order_line_id, mydb, current_userid, MODULE_NAME, created_by, updated_by):
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
            sales_uom_id,
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
        mydb.commit()
        logger.debug(f"New Inventory row created successfully for Inventory ID: {inventory['inventory_id']}")

    except Exception as e:
        logger.error(f"{current_userid} --> {MODULE_NAME}: Error in creating new inventory row: {str(e)}")
    finally:
        if mycursor:
            mycursor.close()

def update_inventory_remaining(inventory, remaining_quantity, sales_uom_id, inv_uom_id, mydb, current_userid, MODULE_NAME, updated_by):
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
            sales_uom_id,
            current_userid,
            inventory['inventory_id']
        ))
        mydb.commit()
        logger.debug(f"Inventory updated successfully for remaining quantity for Inventory ID: {inventory['inventory_id']}")

    except Exception as e:
        logger.error(f"{current_userid} --> {MODULE_NAME}: Error in updating inventory remaining quantity: {str(e)}")
    finally:
        if mycursor:
            mycursor.close()

def get_available_inventory(item_id, mydb, current_userid, MODULE_NAME):
    try:
        mycursor = mydb.cursor(dictionary=True)
        query = """
            SELECT inv.*, u.base_unit
            FROM inv.item_inventory inv
            JOIN com.uom u ON inv.uom_id = u.uom_id
            WHERE inv.item_id = %s AND (inv.status != 'Yes' OR inv.status IS NULL)
            ORDER BY inv.uom_id, inv.quantity, u.base_unit ASC, inv.created_at ASC
        """
        logger.debug(f"Executing Query: {query} with Item ID: {item_id}")
        mycursor.execute(query, (item_id,))
        result = mycursor.fetchall()
        logger.debug(f"Fetched Available Inventory: {result}")
        return result
    except Exception as e:
        logger.error(f"{current_userid} --> {MODULE_NAME}: Error in fetching inventory: {str(e)}")
        return []
    finally:
        mycursor.close()

def update_inventory(inventory, allocated_quantity_in_base_uom, sales_header_id, sales_order_line_id, mydb, current_userid, MODULE_NAME, created_by, updated_by):
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
        mydb.commit()
        logger.debug(f"Inventory updated successfully for Inventory ID: {inventory['inventory_id']}")

    except Exception as e:
        logger.error(f"{current_userid} --> {MODULE_NAME}: Error in updating inventory: {str(e)}")
    finally:
        if mycursor:
            mycursor.close()


def update_sales_order_lines_status(sales_order_line_id, full_qty_alloc_status, part_qty_alloc_status, total_allocated, mydb, current_userid, MODULE_NAME):
    try:
        mycursor = mydb.cursor(dictionary=True)  # Use dictionary cursor to fetch results as dictionaries
        logger.debug(f"Updating Sales Order Line Status and Picked Quantity for Line ID: {sales_order_line_id}")

        # Fetch current picked_quantity and quantity from sales_order_lines table
        select_query = """
            SELECT picked_quantity, quantity
            FROM sal.sales_order_lines
            WHERE line_id = %s
        """
        mycursor.execute(select_query, (sales_order_line_id,))
        result = mycursor.fetchone()

        if not result:
            logger.error(f"No sales order line found with ID: {sales_order_line_id}")
            return f"No Sales Order line found with {sales_order_line_id}", 400

        
        picked_quantity = result['picked_quantity'] or 0  # Access elements using string keys
        quantity = result['quantity']

        logger.debug(f"Current Picked Quantity: {picked_quantity}, Current Quantity: {quantity}")

        # Calculate new picked_quantity based on allocated quantities
        new_picked_quantity = picked_quantity + total_allocated

        logger.debug(f"New Picked Quantity after allocation: {new_picked_quantity}")
        logger.debug(f"Total Allocated : {total_allocated}")
        logger.debug(f"Sales Lines quantity : {quantity}")

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
        mydb.commit()

        logger.debug(f"Picked quantity updated successfully for Line ID: {sales_order_line_id}")

        # Determine status based on picked_quantity
        logger.debug(f"Before Assiging the status value to update in sales order lines new picked quanity : {new_picked_quantity}")
        logger.debug(f"Before Assiging the status value to update in sales order lines quantity : {quantity}")
        if new_picked_quantity == quantity:
            status = full_qty_alloc_status
        elif new_picked_quantity < quantity:
            status = part_qty_alloc_status
        else:
            logger.error(f"Picked quantity exceeds quantity in sales order line: {new_picked_quantity} > {quantity}")
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
        mydb.commit()

        logger.debug(f"Sales Order Line status updated to: {status} for Line ID: {sales_order_line_id}")

        return jsonify(message=f"Sales Order line {sales_order_line_id} is updated successfully with the status {status}"), 200

    except Exception as e:
        logger.error(f"{current_userid} --> {MODULE_NAME}: Error in updating sales order line status and picked quantity: {str(e)}")
    finally:
        if mycursor:
            mycursor.close()



def update_sales_order_lines_status2(sales_header_id, status, mydb, current_userid, MODULE_NAME):
    try:
        mycursor = mydb.cursor()
        logger.debug(f"Updating Sales Order Lines Status for Header ID: {sales_header_id}, Full Status: {status}")

        update_query = """
            UPDATE sal.sales_order_lines
            SET status = %s,
                updated_at = NOW(),
                updated_by = %s
            WHERE header_id = %s
        """
        mycursor.execute(update_query, (
            status,
            current_userid,
            sales_header_id
        ))
        mydb.commit()
        logger.debug(f"Sales Order Lines status updated successfully for Header ID: {sales_header_id}")

    except Exception as e:
        logger.error(f"{current_userid} --> {MODULE_NAME}: Error in updating sales order lines status: {str(e)}")
    finally:
        if mycursor:
            mycursor.close()

def update_sales_order_status(sales_header_id, full_qty_alloc_status, part_qty_alloc_status, mydb, current_userid, MODULE_NAME):
    try:
        mycursor = mydb.cursor()
        logger.debug(f"Updating Sales Order Status for Header ID: {sales_header_id}")

        update_query = """
            UPDATE sal.sales_order_headers
            SET status = CASE
                WHEN EXISTS (
                    SELECT 1
                    FROM sal.sales_order_lines
                    WHERE header_id = %s AND status = %s
                ) AND NOT EXISTS (
                    SELECT 1
                    FROM sal.sales_order_lines
                    WHERE header_id = %s AND status = %s
                ) THEN %s
                WHEN EXISTS (
                    SELECT 1
                    FROM sal.sales_order_lines
                    WHERE header_id = %s AND status = %s
                ) THEN %s
                ELSE status
                END,
                updated_at = NOW(),
                updated_by = %s
            WHERE header_id = %s
        """
        
        # Parameters for the execute method
        params = (
            sales_header_id, full_qty_alloc_status,
            sales_header_id, part_qty_alloc_status, full_qty_alloc_status,
            sales_header_id, part_qty_alloc_status, part_qty_alloc_status,
            current_userid, sales_header_id
        )

        mycursor.execute(update_query, params)
        mydb.commit()
        logger.debug(f"Sales Order status updated successfully for Header ID: {sales_header_id}")

    except Exception as e:
        logger.error(f"{current_userid} --> {MODULE_NAME}: Error in updating sales order status: {str(e)}")
    finally:
        if mycursor:
            mycursor.close()


def get_conversion_factor(inv_uom_id, sales_uom_id, mydb, current_userid, MODULE_NAME):
    try:
        mycursor = mydb.cursor(dictionary=True)
        query = """
            SELECT conversion_factor FROM com.uom
            WHERE uom_id = %s AND base_unit = %s
        """
        logger.debug(f"Executing Query: {query} with Inventory UOM ID: {inv_uom_id}, Sales UOM ID: {sales_uom_id}")
        mycursor.execute(query, (inv_uom_id, sales_uom_id))
        result = mycursor.fetchone()
        logger.debug(f"Fetched Conversion Factor: {result}")
        
        if result:
            conversion_factor = result['conversion_factor']
        else:
            logger.debug(f"No conversion factor found. Assuming UOMs are not convertible.")
            conversion_factor = None
        
        return conversion_factor

    except Exception as e:
        logger.error(f"{current_userid} --> {MODULE_NAME}: Error in fetching conversion factor: {str(e)}")
        return None
    finally:
        if mycursor:
            mycursor.close()

