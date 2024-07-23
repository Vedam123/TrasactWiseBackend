from modules.utilities.logger import logger

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