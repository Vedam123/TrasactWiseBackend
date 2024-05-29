from modules.utilities.logger import logger

def update_so_statuses(USER_ID, MODULE_NAME, mydb, line_id, transaction_header_number, transaction_status):
    try:
        cursor = mydb.cursor()

        # Fetch header_id using line_id
        cursor.execute("SELECT header_id FROM sal.sales_order_lines WHERE line_id = %s", (line_id,))
        result = cursor.fetchone()
        if not result:
            raise ValueError(f"No sales order line found with line_id {line_id}")
        
        header_id = result[0]

        # Check if so_num matches transaction_header_number
        cursor.execute("SELECT so_num FROM sal.sales_order_headers WHERE header_id = %s", (header_id,))
        result = cursor.fetchone()
        if not result or result[0] != transaction_header_number:
            raise ValueError(f"Invalid transaction_header_number for sales order line with line_id {line_id}")

        # Update status of the specified line
        cursor.execute(
            "UPDATE sal.sales_order_lines SET status = %s WHERE line_id = %s",
            (transaction_status, line_id)
        )

        # Check if all lines of the header have status either Received or Inspected
        cursor.execute(
            "SELECT COUNT(*) FROM sal.sales_order_lines WHERE header_id = %s AND status NOT IN ('Shipped', 'Inspected')",
            (header_id,)
        )
        result = cursor.fetchone()
        if result and result[0] == 0:
            # If all lines have status Received or Inspected, update header status to Received
            cursor.execute(
                "UPDATE sal.sales_order_headers SET status = 'Shipped' WHERE header_id = %s",
                (header_id,)
            )

        cursor.close()
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Successfully updated status for line_id {line_id}")
        return True
    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Failed to update status for line_id {line_id}: {str(e)}")
        return False
