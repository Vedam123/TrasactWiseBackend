from modules.utilities.logger import logger
from flask import jsonify, json
from decimal import Decimal
from modules.sales.routines.log_pick_release import log_pick_release
from modules.inventory.routines.insert_pick_and_ship_stage import insert_pick_and_ship_stage

def update_inventory(execution_id, inventory, allocated_quantity_in_base_uom, sales_header_id, 
                     sales_order_line_id, sales_line_status,shipping_method,
                     shipping_address,sales_item_id,ship_status,picker_id,pick_status,mydb, current_userid, MODULE_NAME):
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
            inventory['inventory_id'], allocated_quantity_in_base_uom,  pick_status, current_userid, mydb)
        
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