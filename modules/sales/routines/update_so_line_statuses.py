from modules.utilities.logger import logger

def update_so_line_statuses(USER_ID, MODULE_NAME, mydb, header_id, transaction_status):
    try:
        cursor = mydb.cursor()

        # Check if header_id exists in sales_order_lines
        print("In the so line status function ",header_id, transaction_status)
        cursor.execute("SELECT COUNT(*) FROM sal.sales_order_lines WHERE header_id = %s", (header_id,))
        result = cursor.fetchone()
        if not result or result[0] == 0:
            raise ValueError(f"No sales order lines found with header_id {header_id}")

        # Update status of all lines with the specified header_id
        cursor.execute(
            "UPDATE sal.sales_order_lines SET status = %s WHERE header_id = %s",
            (transaction_status, header_id)
        )

        mydb.commit()
        cursor.close()
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Successfully updated status for all lines with header_id {header_id}")
        return True
    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Failed to update status for lines with header_id {header_id}: {str(e)}")
        return False
