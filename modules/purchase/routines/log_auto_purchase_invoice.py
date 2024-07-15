from modules.utilities.logger import logger  # Import your logger module

def log_auto_purchase_invoice(data, mydb):
    try:
        mycursor = mydb.cursor()

        # Prepare the INSERT query
        query = """
            INSERT INTO pur.auto_purchase_log (
                execution_id, purchase_header_id, purchase_invoice_id, po_header_prev_status, 
                po_header_update_status, purchase_invoice_status, auto_purchase_status, created_by, updated_by
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        """

        # Define the values to insert
        values = (
            data.get('execution_id'), data.get('purchase_header_id'), data.get('purchase_invoice_id'), 
            data.get('po_header_prev_status'), data.get('po_header_update_status'), data.get('purchase_invoice_status'), 
            data.get('auto_purchase_status'), data.get('created_by'), data.get('updated_by')
        )

        # Execute the query
        mycursor.execute(query, values)
        mydb.commit()  # Commit the transaction after execution

        # Log success
        logger.info(f"Auto purchase process logged for execution_id: {data.get('execution_id')}, purchase_header_id: {data.get('purchase_header_id')}")

    except Exception as e:
        # Log error
        logger.error(f"Error logging auto purchase process: {str(e)}")
        raise e
