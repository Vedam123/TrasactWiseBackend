from modules.utilities.logger import logger
from flask import jsonify, json
from decimal import Decimal
from modules.inventory.routines.update_inventory import update_inventory
from modules.inventory.routines.update_inventory_remaining import update_inventory_remaining
from modules.inventory.routines.create_new_inventory_row import create_new_inventory_row
from modules.inventory.routines.get_available_inventory import get_available_inventory
from modules.common.routines.get_conversion_factor import get_conversion_factor
from modules.inventory.routines.update_sales_order_lines_status import update_sales_order_lines_status

def allocate_inventory(line, execution_id,sales_header_id, look_only_inventory_ids,
                       full_qty_alloc_status,part_qty_alloc_status, shipping_method,shipping_address, 
                       ship_status,picker_id,pick_status,mydb, current_userid, MODULE_NAME):
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
        logger.debug(f"Searched Available inventory for the item : {sales_item_id}")
        total_allocated = 0

        for inventory in available_inventory:
            logger.debug(f"Processing Found Inventory")
            if inventory['status'] == 'Yes':
                logger.debug("Inventory already allocated, skipping")
                continue
            new_inventory_id = 0
            inv_quantity = inventory['quantity']
            inv_uom_id = inventory['uom_id']
            logger.debug(f"Inventory UOM ID: {inv_uom_id}, Sales UOM ID: {sales_base_uom_id}")

            if int(inv_uom_id) == int(sales_base_uom_id):
                logger.debug(f"Processing Inventory if UOM id is matched")
                conversion_factor = 1  # Default conversion factor when uom_id matches sales_base_uom_id
                #result = find_lowest_uom_and_cf(inv_uom_id, mydb, current_userid, MODULE_NAME)
                result = get_conversion_factor(inv_uom_id, inv_uom_id, mydb, current_userid, MODULE_NAME)
                conversion_factor = result['conversion_factor']
                lowest_base_unit = result['lowest_base_unit']
                convertible_quantity = inv_quantity
                convertable_quantity_lb = convertible_quantity
                lowest_base_unit_conv_factor = result['lowest_conversion_factor']                
            else:
                logger.debug(f"Processing Inventory where uom id is not matches ")
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

            logger.debug(f"Required Quantity : {required_quantity}")

            logger.debug(f"Total Allocated : {total_allocated}")

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
                                                             sales_item_id,ship_status,picker_id,pick_status,mydb, current_userid, MODULE_NAME)
                
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
                logger.debug(f"Entered in Else Statement as : {convertable_quantity_lb}  is more")
                allocated_quantity = required_quantity - total_allocated
                logger.debug(f"Equation is executed Inventory UOM ID  ALLOCATED QUANTITY {allocated_quantity} : {inv_uom_id}  {sales_base_uom_id}")

                if int(inv_uom_id) == int(sales_base_uom_id):
                    logger.debug(f" Inside if UOM comparision  : is more")
                    allocated_quantity_in_base_uom = Decimal(allocated_quantity)
                    remaining_quantity = Decimal(convertable_quantity_lb) - allocated_quantity_in_base_uom
                else:
                    logger.debug(f" Inside else  : is more")
                    allocated_quantity_in_base_uom = Decimal(allocated_quantity) 
                    remaining_quantity = Decimal(convertable_quantity_lb) - allocated_quantity_in_base_uom
            
                logger.debug(f" Check if remaining quantity is more than 0 : is more")
                if remaining_quantity > 0:
                    logger.debug(f"Yes, Remaining quantity is greater than 0: {remaining_quantity}")
                    response_json, status_code = create_new_inventory_row(execution_id,inventory, allocated_quantity_in_base_uom, lowest_base_unit, 
                                                                          sales_header_id,sales_order_line_id, sales_line_status,shipping_method,shipping_address,
                                                                          sales_item_id,ship_status,picker_id,pick_status,mydb, current_userid, MODULE_NAME)
                    
                    response_data = json.loads(response_json)
                    logger.debug(f"As the remaining quanity is greather than 0 so create_new_inventory row called and its status code is : {status_code} ")
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
                    logger.debug(f"Yes, Remaining quantity less than  0 so calling update_inventory function : {remaining_quantity}")
                    response_json, status_code =update_inventory(execution_id, inventory, allocated_quantity_in_base_uom, sales_header_id, 
                                                                 sales_order_line_id, sales_line_status,shipping_method,shipping_address,
                                                                 sales_item_id,ship_status,picker_id,pick_status,mydb, current_userid, MODULE_NAME)
                    
                    response_data = json.loads(response_json)
                    logger.debug(f"Yes, Remaining quantity less than  0 so calling update_inventory function and its response is : {status_code}")
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
        logger.debug(f"Now out of available inventory loop , the total allocated is : {total_allocated}")
        if total_allocated > 0 : 
            result, status_code = update_sales_order_lines_status(execution_id,sales_header_id,sales_order_line_id,full_qty_alloc_status,
                                                                  part_qty_alloc_status, total_allocated, shipping_method,shipping_address,
                                                                  sales_item_id,ship_status,picker_id,pick_status,mydb, current_userid, MODULE_NAME)
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
            logger.debug(f"As no inventory allocated  : {total_allocated}")
            result = jsonify(message=f"No Inventory is allocated to Sales order/s")
            status_code = 201
        
        logger.debug(f"Result from Sales order lines status : {result}")
        logger.debug(f"Status from Sales order lines status :{status_code}")

        return result, status_code
    except Exception as e:
        logger.error(f"{current_userid} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return jsonify(message=f"Processing failed "),400