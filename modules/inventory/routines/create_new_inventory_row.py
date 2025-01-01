from modules.utilities.logger import logger
from flask import  json
from modules.sales.routines.log_pick_release import log_pick_release
from modules.inventory.routines.insert_pick_and_ship_stage import insert_pick_and_ship_stage


def create_new_inventory_row(execution_id, inventory, remaining_quantity, sales_base_uom_id, sales_header_id, 
                             sales_order_line_id, sales_line_status,shipping_method,shipping_address,sales_item_id,
                             ship_status,picker_id,pick_status,mydb, appuserid, MODULE_NAME):
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
            appuserid,
            appuserid
        ))
        #mydb.commit()
        logger.debug(f"New Inventory row created successfully for Inventory ID: {inventory['inventory_id']}")

        # Retrieve the newly generated inventory_id
        inventory_id = mycursor.lastrowid
     
        log_pick_release(execution_id, sales_header_id, sales_order_line_id, sales_line_status, 
            inventory_id, remaining_quantity, pick_status, appuserid, mydb)
        
        insert_pick_and_ship_stage(appuserid, MODULE_NAME, mydb, execution_id, sales_header_id, sales_order_line_id, sales_item_id, 
                inventory['inventory_id'], remaining_quantity, picker_id, 
                ship_status, shipping_method, shipping_address) 

        # Return JSON response with inventory_id and success status code
        return json.dumps({"inventory_id": inventory_id}), 200

    except Exception as e:
        logger.error(f"{appuserid} --> {MODULE_NAME}: Error in creating new inventory row: {str(e)}")
        return json.dumps({"error": str(e)}), 500  # Return error response in case of exception

    finally:
        if mycursor:
            mycursor.close()