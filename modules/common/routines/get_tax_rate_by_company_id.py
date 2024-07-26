from modules.utilities.logger import logger

def get_tax_rate_by_company_id(company_id, tax_type,USER_ID, MODULE_NAME, mydb):
    try:
        cursor = mydb.cursor()

        # Query to join the necessary tables and get the tax_rate and tax_id
        query = """
            SELECT t.tax_id, t.tax_rate
            FROM com.company c
            JOIN com.default_tax_config dtc ON c.default_tax_code_id = dtc.header_id
            JOIN com.default_tax_codes dt ON dt.header_id = dtc.header_id
            JOIN com.tax t ON dt.tax_id = t.tax_id
            WHERE c.id = %s AND dt.tax_type = %s
        """
        cursor.execute(query, (company_id, tax_type))
        result = cursor.fetchone()

        # If no record is found or multiple records are found, log and return None
        if not result:
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: No tax rate found for company_id {company_id} and tax_type {tax_type}")
            return None, None

        tax_id, tax_rate = result

        # Close the cursor
        cursor.close()

        # Log the successful retrieval of the tax rate and tax id
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Successfully fetched tax_id {tax_id} and tax rate {tax_rate} for company_id {company_id} and tax_type {tax_type}")
        return tax_id, tax_rate

    except Exception as e:
        # Log any errors that occur
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Failed to fetch tax rate for company_id {company_id} and tax_type {tax_type}: {str(e)}")
        return None, None
