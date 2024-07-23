from modules.utilities.logger import logger

def update_poheader_and_lines_status(USER_ID, MODULE_NAME, mydb, header_id, transaction_status):
    try:

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the function to update the  {header_id} with the status {transaction_status} ")
        cursor = mydb.cursor()

        # Update status of the specified header
        cursor.execute(
            "UPDATE pur.purchase_order_header SET status = %s WHERE header_id = %s",
            (transaction_status, header_id)
        )

        logger.debug(f"{USER_ID} --> {MODULE_NAME}:Header cursor executed   {header_id} with the status {transaction_status} ")

        # Update status of all lines associated with the specified header
        cursor.execute(
            "UPDATE pur.purchase_order_line SET status = %s WHERE header_id = %s",
            (transaction_status, header_id)
        )
        logger.debug(f"{USER_ID} --> {MODULE_NAME}:Line cursor executed   {header_id} with the status {transaction_status} ")
        cursor.close()
        mydb.commit()
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Successfully updated status for header_id {header_id} and associated lines")
        return True
    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Failed to update status for header_id {header_id}: {str(e)}")
        return False
