from modules.utilities.logger import logger  # Ensure the logger is properly configured and accessible

def get_next_free_number_function(sequence_name, mydb, USER_ID, MODULE_NAME):
    """
    Retrieves the next value from a sequence in the database.
    
    Args:
    - sequence_name (str): The name of the sequence to get the next value for.
    - mydb: The database connection object.
    - USER_ID (str): The ID of the user performing the operation.
    - MODULE_NAME (str): The name of the module performing the operation.
    
    Returns:
    - int: The next sequence value if successful.
    
    Raises:
    - Exception: If the sequence value could not be retrieved.
    """
    try:
        with mydb.cursor(dictionary=True) as cursor:
            # Step 1: Update the sequence value in the sequence_table
            update_query = """
                UPDATE sequence_table
                SET current_value = LAST_INSERT_ID(current_value + increment_value)
                WHERE sequence_name = %s
            """
            cursor.execute(update_query, (sequence_name,))
            
            # Step 2: Retrieve the next sequence value
            cursor.execute('SELECT LAST_INSERT_ID() AS next_val')
            result = cursor.fetchone()
            
            # Log the result for debugging
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: Sequence result for {sequence_name}: {result}")
            
            # Check if the result is valid
            if result is None or result['next_val'] is None:
                error_message = f"Failed to retrieve next sequence value for sequence '{sequence_name}'."
                logger.error(f"{USER_ID} --> {MODULE_NAME}: {error_message}")
                raise Exception(error_message)
            
            # Return the sequence value as an integer
            if int(result['next_val']) > 0 : mydb.commit()

            return int(result['next_val'])
    
    except Exception as e:
        # Log the error and re-raise the exception
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error occurred while fetching next sequence value for {sequence_name}: {str(e)}")
        raise e
