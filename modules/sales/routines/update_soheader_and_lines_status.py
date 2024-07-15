from modules.utilities.logger import logger

def update_soheader_and_lines_status(USER_ID, MODULE_NAME, mydb, header_id, transaction_status):
    try:
        cursor = mydb.cursor()

        # Update status of the specified header
        cursor.execute(
            "UPDATE sal.sales_order_headers SET status = %s WHERE header_id = %s",
            (transaction_status, header_id)
        )

        # Update status of all lines associated with the specified header
        cursor.execute(
            "UPDATE sal.sales_order_lines SET status = %s WHERE header_id = %s",
            (transaction_status, header_id)
        )

        cursor.close()
        mydb.commit()
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Successfully updated status for header_id {header_id} and associated lines")
        return True
    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Failed to update status for header_id {header_id}: {str(e)}")
        return False
