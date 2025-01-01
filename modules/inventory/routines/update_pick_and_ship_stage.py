from modules.utilities.logger import logger

def update_pick_and_ship_stage_status(appuser, MODULE_NAME, mydb, reverse_pick_release_status, execution_id=None, order_id=None, line_id=None):
    try:
        mycursor = mydb.cursor()
        #status = 'REVERSED' if reverse_pick_release else 'NOT_REVERSED'
        logger.debug(f"Updating status to '{reverse_pick_release_status}' in pick_and_ship_stage - Execution ID: {execution_id}, Order ID: {order_id}, Line ID: {line_id}")

        update_query = "UPDATE inv.pick_and_ship_stage SET status = %s WHERE 1=1"
        update_params = [reverse_pick_release_status]

        if execution_id is not None:
            update_query += " AND execution_id = %s"
            update_params.append(execution_id)

        if order_id is not None:
            update_query += " AND order_id = %s"
            update_params.append(order_id)

        if line_id is not None:
            update_query += " AND line_id = %s"
            update_params.append(line_id)

        mycursor.execute(update_query, update_params)
        mydb.commit()

        logger.debug(f"{appuser} --> {MODULE_NAME}: Successfully updated status to '{reverse_pick_release_status}' in pick_and_ship_stage")

        # Return success
        return True

    except Exception as e:
        logger.error(f"{appuser} --> {MODULE_NAME}: Error updating status to '{reverse_pick_release_status}' in pick_and_ship_stage - {str(e)}")
        return False

    finally:
        mycursor.close()

