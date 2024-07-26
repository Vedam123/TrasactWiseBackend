from modules.utilities.logger import logger

def get_tax_rate_by_tax_id(tax_id, USER_ID, MODULE_NAME, mydb):
    try:
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Successfully entered the function get_tax_rate_by_tax_id with tax_id {tax_id}")
        cursor = mydb.cursor()

        # Query to fetch the tax rate and tax type based on tax_id
        cursor.execute("SELECT tax_rate, tax_type FROM com.tax WHERE tax_id = %s", (tax_id,))
        result = cursor.fetchone()

        # If no record is found, log and return None
        if result is None:
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: No tax found with tax_id {tax_id}")
            return None, None

        tax_rate, tax_type = result

        # Close the cursor
        cursor.close()

        # Log the successful retrieval of the tax rate and tax type
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Successfully fetched tax rate {tax_rate} and tax type {tax_type} for tax_id {tax_id}")
        return tax_rate, tax_type

    except Exception as e:
        # Log any errors that occur
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Failed to fetch tax rate and tax type for tax_id {tax_id}: {str(e)}")
        return None, None
