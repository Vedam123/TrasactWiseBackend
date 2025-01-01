from modules.utilities.logger import logger

def insert_pick_and_ship_stage(appuser, MODULE_NAME, mydb, execution_id, order_id, line_id, item_id, 
                               inventory_id, picked_quantity, picker_id, shipping_status, shipping_method, destination):
    try:
        mycursor = mydb.cursor()
        logger.debug(f"Inserting data into pick_and_ship_stage - Order ID: {order_id}, Line ID: {line_id}, Execution ID: {execution_id}")

        insert_query = """
        INSERT INTO inv.pick_and_ship_stage (
            execution_id, order_id, line_id, item_id, inventory_id, picked_quantity, pick_date, picker_id, shipping_location_id, status, shipping_method, destination
        ) VALUES (%s, %s, %s, %s, %s, %s, NOW(), %s, NULL, %s, %s, %s)
        """

        insert_data = (execution_id, order_id, line_id, item_id, inventory_id, picked_quantity, picker_id, shipping_status, shipping_method, destination)

        mycursor.execute(insert_query, insert_data)
        mydb.commit()

        logger.debug(f"{appuser} --> {MODULE_NAME}: Successfully inserted data into pick_and_ship_stage")

        # Return success
        return True

    except Exception as e:
        logger.error(f"{appuser} --> {MODULE_NAME}: Error inserting data into pick_and_ship_stage - {str(e)}")
        return False

    finally:
        mycursor.close()
