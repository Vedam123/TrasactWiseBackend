from modules.utilities.logger import logger

def update_po_statuses(USER_ID, MODULE_NAME, mydb, transaction_number, transaction_header_number, transaction_status):
    try:
        cursor = mydb.cursor()

        # Fetch header_id using transaction_number
        cursor.execute("SELECT header_id FROM pur.purchase_order_line WHERE line_id = %s", (transaction_number,))
        result = cursor.fetchone()
        if not result:
            raise ValueError(f"No purchase order line found with line_id {transaction_number}")
        
        header_id = result[0]

        # Check if po_num matches transaction_header_number
        cursor.execute("SELECT po_num FROM pur.purchase_order_header WHERE header_id = %s", (header_id,))
        result = cursor.fetchone()
        if not result or result[0] != transaction_header_number:
            raise ValueError(f"Invalid transaction_header_number for purchase order line with line_id {transaction_number}")

        # Update status of the specified line
        cursor.execute(
            "UPDATE pur.purchase_order_line SET status = %s WHERE line_id = %s",
            (transaction_status, transaction_number)
        )

        # Check if all lines of the header have status either Received or Inspected
        cursor.execute(
            "SELECT COUNT(*) FROM pur.purchase_order_line WHERE header_id = %s AND status NOT IN ('Received', 'Inspected')",
            (header_id,)
        )
        result = cursor.fetchone()
        if result and result[0] == 0:
            # If all lines have status Received or Inspected, update header status to Received
            cursor.execute(
                "UPDATE pur.purchase_order_header SET status = 'Received' WHERE header_id = %s",
                (header_id,)
            )

        cursor.close()
        return True
    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Failed to update status for transaction_number {transaction_number}: {str(e)}")
        return False
