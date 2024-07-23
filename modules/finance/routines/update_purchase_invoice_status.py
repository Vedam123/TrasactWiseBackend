from modules.utilities.logger import logger  # Assuming your logger is set up similarly

def update_purchase_invoice_status(header_id, to_status, mydb,MODULE_NAME,USER_ID):
    try:
        logger.info(f"{USER_ID} --> {MODULE_NAME}: Entered Purchase Invoice update to the header {header_id} with the status {to_status}")

        cursor = mydb.cursor(dictionary=True)

        logger.info(f"{USER_ID} --> {MODULE_NAME}: Entered Purchase Invoice update to the header After cursor {header_id} with the status {to_status}")

        # Fetch the purchase invoice based on the header_id
        fetch_query = """
            SELECT * FROM fin.purchaseinvoice
            WHERE header_id = %s
        """
        cursor.execute(fetch_query, (header_id,))
        purchase_invoice = cursor.fetchone()

        if not purchase_invoice:
            logger.debug(f"No purchase invoice found with header_id: {header_id}")
            return {'error': 'Purchase invoice not found'}, 404

        # Update the status of the purchase invoice
        update_query = """
            UPDATE fin.purchaseinvoice
            SET status = %s, updated_at = NOW()
            WHERE header_id = %s
        """
        cursor.execute(update_query, (to_status, header_id))
        mydb.commit()

        logger.debug(f"Purchase invoice status updated successfully for header_id: {header_id}")
        return {'message': 'Status updated successfully'}, 200

    except  Exception  as e:
        logger.debug(f"Error updating purchase invoice status: {e}")
        return {'error': str(e)}, 500

    finally:
        cursor.close()