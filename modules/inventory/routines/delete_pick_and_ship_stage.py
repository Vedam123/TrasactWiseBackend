from modules.utilities.logger import logger

def delete_pick_and_ship_stage(USER_ID, MODULE_NAME, mydb, execution_id=None, order_id=None, line_id=None):
    try:
        mycursor = mydb.cursor()
        logger.debug(f"Deleting data from pick_and_ship_stage - Execution ID: {execution_id}, Order ID: {order_id}, Line ID: {line_id}")

        delete_query = "DELETE FROM inv.pick_and_ship_stage WHERE 1=1"
        delete_params = []

        if execution_id is not None:
            delete_query += " AND execution_id = %s"
            delete_params.append(execution_id)

        if order_id is not None:
            delete_query += " AND order_id = %s"
            delete_params.append(order_id)

        if line_id is not None:
            delete_query += " AND line_id = %s"
            delete_params.append(line_id)

        mycursor.execute(delete_query, delete_params)
        mydb.commit()

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Successfully deleted data from pick_and_ship_stage")

        # Return success
        return True

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error deleting data from pick_and_ship_stage - {str(e)}")
        return False

    finally:
        mycursor.close()
