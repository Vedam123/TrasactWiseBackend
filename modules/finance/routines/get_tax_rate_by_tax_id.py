from modules.utilities.logger import logger  # Ensure the logger is properly configured and accessible

def get_tax_rate(tax_id, mydb, USER_ID, MODULE_NAME):
    try:
        logger.info(f"{USER_ID} --> {MODULE_NAME}: Fetching tax rate for tax_id={tax_id}")

        mycursor = mydb.cursor(dictionary=True)

        # Query to get tax_rate for the given tax_id from com.tax table
        query = """
            SELECT tax_id, tax_rate, tax_type
            FROM com.tax 
            WHERE tax_id = %s AND status = 1
        """
        mycursor.execute(query, (tax_id,))
        result = mycursor.fetchone()

        if result and result['tax_rate'] is not None:
            tax_rate_details = {
                'tax_id': result['tax_id'],
                'tax_rate': result['tax_rate'],
                'tax_type': result['tax_type']
            }
            logger.info(f"{USER_ID} --> {MODULE_NAME}: Tax rate fetched successfully")
            return tax_rate_details, 'Tax rate fetched successfully'
        else:
            logger.warning(f"{USER_ID} --> {MODULE_NAME}: No active tax_rate found for tax_id={tax_id}")
            return None, 'No active tax rate found'

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error occurred: {str(e)}")
        return None, 'Error occurred in database operation'
    finally:
        if mycursor:
            mycursor.close()

# Example usage assuming you have a database connection `mydb` already established
# Replace `tax_id` with the actual tax ID you want to use
# Replace `USER_ID` and `MODULE_NAME` with actual values
# result_tax_rate, result_msg = get_tax_rate(tax_id, mydb, USER_ID, MODULE_NAME)
# print("Resulting tax rate:", result_tax_rate)
# print("Result message:", result_msg)
