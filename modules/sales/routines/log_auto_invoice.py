from modules.utilities.logger import logger  # Import your logger module

def log_auto_invoice(data, mydb):
    try:
        mycursor = mydb.cursor()

        # Prepare the INSERT query
        query = """
            INSERT INTO sal.auto_invoice_log (
                execution_id, sales_header_id, invoice_header_id, so_header_prev_status, 
                so_header_update_status, sales_invoice_status, auto_inv_status, created_by, updated_by
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        """

        # Define the values to insert
        values = (
            data.get('execution_id'), data.get('sales_header_id'), data.get('invoice_header_id'), 
            data.get('so_header_prev_status'), data.get('so_header_update_status'), data.get('sales_invoice_status'), 
            data.get('auto_inv_status'), data.get('created_by'), data.get('updated_by')
        )

        # Execute the query
        mycursor.execute(query, values)
        mydb.commit()  # Commit the transaction after execution

        # Log success
        logger.info(f"Auto invoice process logged for execution_id: {data.get('execution_id')}, sales_header_id: {data.get('sales_header_id')}")

    except Exception as e:
        # Log error
        logger.error(f"Error logging auto invoice process: {str(e)}")
        raise e
