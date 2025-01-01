from mysql.connector import Error
from modules.utilities.logger import logger  # Assuming your logger is set up similarly

def update_sales_invoice_status(header_id, to_status, mydb, module_name, appuser,appuserid):
    try:
        cursor = mydb.cursor(dictionary=True)

        # Fetch the sales invoice based on the header_id
        fetch_query = """
            SELECT * FROM fin.salesinvoice
            WHERE header_id = %s
        """
        cursor.execute(fetch_query, (header_id,))
        sales_invoice = cursor.fetchone()

        if not sales_invoice:
            logger.debug(f"{appuser} --> {module_name}:No sales invoice found with header_id: {header_id}")
            return {'error': 'Sales invoice not found'}, 404

        # Update the status of the sales invoice
        update_query = """
            UPDATE fin.salesinvoice
            SET status = %s, updated_at = NOW()
            WHERE header_id = %s
        """
        cursor.execute(update_query, (to_status, header_id))
        mydb.commit()

        logger.debug(f"{appuser} --> {module_name}:Sales invoice status updated successfully for header_id: {header_id}")
        return {'message': 'Status updated successfully'}, 200

    except Error as e:
        logger.debug(f"Error updating sales invoice status: {e}")
        return {'error': str(e)}, 500

    finally:
        cursor.close()