from modules.utilities.logger import logger
from modules.purchase.routines.update_po_statuses import update_po_statuses

def update_receipt_and_po(appuser, MODULE_NAME, mydb, transaction_number, transaction_header_number, transaction_status, transaction_type,accepted_quantity):
    try:
        cursor = mydb.cursor()

        # Update status of the receipts table
        cursor.execute(
            "UPDATE inv.receipts SET status = %s, quantity = %s WHERE transaction_number = %s AND transaction_header_number = %s",
            (transaction_status, accepted_quantity, transaction_number, transaction_header_number)
        )

        # Check if any rows were affected
        if cursor.rowcount == 0:
            raise ValueError("No rows were affected in the inv.receipts table")
        print("Trasnsction type ",transaction_type)
        # Call update_po_statuses function
        if transaction_type == "PO":
            if not update_po_statuses(appuser, MODULE_NAME, mydb, transaction_number, transaction_header_number, transaction_status):
                raise ValueError("Failed to update po statuses")

        cursor.close()
        mydb.commit()
        return True
    except Exception as e:
        mydb.rollback()  # Rollback changes if any error occurs
        logger.error(f"{appuser} --> {MODULE_NAME}: Failed to update receipt and po status: {str(e)}")
        return False
