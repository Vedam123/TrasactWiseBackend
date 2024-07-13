from modules.utilities.logger import logger  # Ensure the logger is properly configured and accessible

def get_default_tax_rates(company_id, tax_types, mydb, USER_ID, MODULE_NAME):
    try:
        logger.info(f"{USER_ID} --> {MODULE_NAME}: Fetching tax rates for company_id={company_id} and tax_types={tax_types}")

        mycursor = mydb.cursor(dictionary=True)

        # Query to get default_tax_code_id for the given company_id
        query1 = "SELECT default_tax_code_id FROM com.company WHERE id = %s"
        mycursor.execute(query1, (company_id,))
        result1 = mycursor.fetchone()
        if not result1 or result1['default_tax_code_id'] is None:
            logger.error(f"{USER_ID} --> {MODULE_NAME}: No default_tax_code_id found for company_id={company_id}")
            return None, 'No default_tax_code_id found for the given company_id'

        default_tax_code_id = result1['default_tax_code_id']

        # Query to get tax_id and tax_type for the given default_tax_code_id
        query2 = "SELECT tax_id, tax_type FROM com.default_tax_codes WHERE header_id = %s"
        mycursor.execute(query2, (default_tax_code_id,))
        default_tax_codes = mycursor.fetchall()
        if not default_tax_codes:
            logger.error(f"{USER_ID} --> {MODULE_NAME}: No tax codes found for default_tax_code_id={default_tax_code_id}")
            return None, 'No tax codes found for the given default_tax_code_id'

        tax_id_map = {code['tax_type']: code['tax_id'] for code in default_tax_codes}

        # Prepare to store the tax rates
        tax_rates = {}

        for tax_type in tax_types:
            if tax_type in tax_id_map:
                tax_id = tax_id_map[tax_type]

                # Query to get tax_rate for the given tax_id and tax_type from com.tax table
                query3 = """
                    SELECT tax_id, tax_rate, tax_type
                    FROM com.tax 
                    WHERE tax_id = %s AND tax_type = %s AND status = 1
                """
                mycursor.execute(query3, (tax_id, tax_type))
                result3 = mycursor.fetchone()
                if result3 and result3['tax_rate'] is not None:
                    tax_rates[tax_type] = {
                        'tax_id': result3['tax_id'],
                        'tax_rate': result3['tax_rate'],
                        'tax_type': result3['tax_type']
                    }
                else:
                    logger.warning(f"{USER_ID} --> {MODULE_NAME}: No active tax_rate found for tax_id={tax_id} and tax_type={tax_type}")
                    tax_rates[tax_type] = {
                        'tax_id': 'No active tax_id found',
                        'tax_rate': 'No active tax_rate found',
                        'tax_type': tax_type
                    }

        if not tax_rates:
            logger.error(f"{USER_ID} --> {MODULE_NAME}: No tax rates found for the given tax types")
            return None, 'No tax rates found for the given tax types'

        logger.info(f"{USER_ID} --> {MODULE_NAME}: Tax rates fetched successfully")
        return tax_rates, 'Tax rates fetched successfully'

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error occurred: {str(e)}")
        return None, 'Error occurred in database operation'
    finally:
        if mycursor:
            mycursor.close()

# Example usage assuming you have a database connection `mydb` already established
# Replace `company_id` with the actual company ID you want to use
# Replace `USER_ID` and `MODULE_NAME` with actual values
# result_tax_rates, result_msg = get_tax_rates(company_id, ['GST', 'VAT'], mydb, USER_ID, MODULE_NAME)
# print("Resulting tax rates:", result_tax_rates)
# print("Result message:", result_msg)
