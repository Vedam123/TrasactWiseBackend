from modules.utilities.logger import logger  # Ensure the logger is properly configured and accessible

def update_company_account_header(company_id, default_account_header_id, mydb, USER_ID, MODULE_NAME):
    try:
        # Log the input parameters
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parameter value for company_id: {company_id}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parameter value for default_account_header_id: {default_account_header_id}")

        # Create a cursor to execute queries
        mycursor = mydb.cursor()

        # Step 1: Check the current value of default_account_header_id in the company table
        select_query = """
            SELECT default_account_header_id 
            FROM com.company 
            WHERE id = %s
        """
        mycursor.execute(select_query, (company_id,))
        result = mycursor.fetchone()

        # If no result found, log and return
        if not result:
            logger.warning(f"{USER_ID} --> {MODULE_NAME}: Company with id {company_id} does not exist.")
            return None

        current_default_account_header_id = result[0]  # Get the current default_account_header_id

        # Step 2: Check if default_account_header_id is NULL
        if current_default_account_header_id is not None:
            # Log the current value and do not update
            logger.info(f"{USER_ID} --> {MODULE_NAME}: Company id {company_id} already has a default_account_header_id: {current_default_account_header_id}. This will be replaced with {default_account_header_id}.")
        
        # Step 3: Proceed with the update
        update_query = """
            UPDATE com.company 
            SET default_account_header_id = %s, updated_at = NOW(), updated_by = %s 
            WHERE id = %s
        """
        
        # Log the query and the values that will be used
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Executing Query: {update_query} with values: {default_account_header_id}, {USER_ID}, {company_id}")
        
        # Execute the update query
        mycursor.execute(update_query, (default_account_header_id, USER_ID, company_id))
        
        # Commit the transaction
        mydb.commit()
        
        # Log the successful update
        if mycursor.rowcount > 0:
            logger.info(f"{USER_ID} --> {MODULE_NAME}: Successfully updated company with id {company_id}: set default_account_header_id to {default_account_header_id}")
        else:
            logger.warning(f"{USER_ID} --> {MODULE_NAME}: No rows affected. Company with id {company_id} may not exist.")
        
        return default_account_header_id

    except Exception as e:
        # Log any error that occurs
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error updating default_account_header_id for company_id {company_id}: {str(e)}")
        return None

    finally:
        # Ensure the cursor is closed after the operation
        if mycursor:
            mycursor.close()
