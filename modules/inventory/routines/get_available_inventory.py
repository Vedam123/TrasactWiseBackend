
from modules.utilities.logger import logger  

def get_available_inventory(item_id, look_only_inventory_ids, mydb, appuserid, MODULE_NAME):
    try:
        mycursor = mydb.cursor(dictionary=True)

        if look_only_inventory_ids:
            # Prepare the placeholders for the IN clause
            placeholders = ', '.join(['%s'] * len(look_only_inventory_ids))
            query = f"""
                SELECT inv.*, u.base_unit
                FROM inv.item_inventory inv
                JOIN com.uom u ON inv.uom_id = u.uom_id
                WHERE inv.item_id = %s AND inv.inventory_id IN ({placeholders}) AND (inv.status != 'Yes' OR inv.status IS NULL)
                ORDER BY inv.uom_id, inv.quantity, u.base_unit ASC, inv.created_at ASC
            """
            logger.debug(f"Executing Query with inventory_ids filter: {query} with Item ID: {item_id} and look_only_inventory_ids: {look_only_inventory_ids}")
            mycursor.execute(query, (item_id, *look_only_inventory_ids))
            logger.debug("Executing query with inventory_ids filter.")
        else:
            query = """
                SELECT inv.*, u.base_unit
                FROM inv.item_inventory inv
                JOIN com.uom u ON inv.uom_id = u.uom_id
                WHERE inv.item_id = %s AND (inv.status != 'Yes' OR inv.status IS NULL)
                ORDER BY inv.uom_id, inv.quantity, u.base_unit ASC, inv.created_at ASC
            """
            logger.debug(f"Executing Base Query: {query} with Item ID: {item_id}")
            mycursor.execute(query, (item_id,))
            logger.debug("Executing base query.")

        result = mycursor.fetchall()
        logger.debug(f"Fetched Available Inventory")
        return result
    except Exception as e:
        logger.error(f"{appuserid} --> {MODULE_NAME}: Error in fetching inventory: {str(e)}")
        return []
    finally:
        mycursor.close()