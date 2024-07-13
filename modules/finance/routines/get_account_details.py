from modules.utilities.logger import logger  # Ensure the logger is properly configured and accessible

def get_account_details(company_id, department_id, currency_id, account_type, mydb, USER_ID, MODULE_NAME):
    try:
        logger.info(f"{USER_ID} --> {MODULE_NAME}: Fetching account details for company_id={company_id}, department_id={department_id}, currency_id={currency_id}, account_type={account_type}")

        # Step 1: Try to get default_account_header_id from com.department table
        with mydb.cursor(dictionary=True) as mycursor:
            query1 = "SELECT default_account_header_id FROM com.department WHERE id = %s"
            mycursor.execute(query1, (department_id,))
            result1 = mycursor.fetchone()
            logger.info(f"{USER_ID} --> {MODULE_NAME}: select from department {result1}")
            logger.info(f"Executing query: {query1} with params: {(department_id,)}")
  
            if result1 and 'default_account_header_id' in result1:
                default_account_header_id = result1['default_account_header_id']
            else:
                # Step 2: If not found, get default_account_header_id from com.company table
                logger.info(f"Executing query: {query2} with params: {(company_id,)}")
                query2 = "SELECT default_account_header_id FROM com.company WHERE id = %s"
                mycursor.execute(query2, (company_id,))
                result2 = mycursor.fetchone()
                logger.info(f"{USER_ID} --> {MODULE_NAME}: select from company {result2}")            
                if result2 and 'default_account_header_id' in result2:
                    default_account_header_id = result2['default_account_header_id']
                else:
                    logger.error(f"{USER_ID} --> {MODULE_NAME}: No default_account_header_id found for company_id={company_id} and department_id={department_id}")
                    return None

        # Step 3: Get account_id from fin.default_accounts table using default_account_header_id and account_type
        with mydb.cursor(dictionary=True) as mycursor:
            logger.info(f"{USER_ID} --> {MODULE_NAME}: Run the below query with the account type --> account_type={account_type}")
            query3 = "SELECT account_id FROM fin.default_accounts WHERE header_id = %s AND account_type = %s"
            logger.info(f"Executing query: {query3} with params: {(default_account_header_id, account_type)}")
            
            mycursor.execute(query3, (default_account_header_id, account_type))
            
            # Fetch all results to ensure no unread results are left
            result3 = mycursor.fetchall()  # Use fetchall() to avoid unread results issue
            logger.info(f"{USER_ID} --> {MODULE_NAME}: Result of the query  --> results={result3}")
            
            if result3 and len(result3) > 0 and 'account_id' in result3[0]:
                logger.info(f"{USER_ID} --> {MODULE_NAME}: Inside If={result3[0]['account_id']}")
                account_id = int(result3[0]['account_id'])
                logger.info(f"{USER_ID} --> {MODULE_NAME}: Inside If= Account id is assigned {account_id}")
            else:
                logger.error(f"{USER_ID} --> {MODULE_NAME}: No account_id found for default_account_header_id={default_account_header_id} and account_type={account_type}")
                return None

        # Step 4: Fetch account details from fin.accounts table
        logger.info(f"{USER_ID} --> {MODULE_NAME}: Calling the fetch account function with account id and currency id {account_id}, {currency_id}") 
        
        # Call the fetch function using a new cursor
        account_details = fetch_account_details(account_id, currency_id, mydb, USER_ID, MODULE_NAME)
        logger.info(f"{USER_ID} --> {MODULE_NAME}: After fetch account details function is executed fetched account details are {account_details}")        
        
        if not account_details:
            logger.error(f"{USER_ID} --> {MODULE_NAME}: No active account details found for account_id={account_id} with matching currency_id={currency_id}")
            return None

        logger.info(f"{USER_ID} --> {MODULE_NAME}: Account details fetched successfully {account_details}")
        return account_details

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error occurred: {str(e)}")
        return None

def fetch_account_details(account_id, currency_id, mydb, USER_ID, MODULE_NAME):
    try:
        with mydb.cursor(dictionary=True) as mycursor:
            query = """
                SELECT account_id, account_number, account_name, currency_id 
                FROM fin.accounts 
                WHERE account_id = %s AND currency_id = %s AND is_active = 1
            """
            mycursor.execute(query, (account_id, currency_id))
            resultx = mycursor.fetchone()
            logger.info(f"{USER_ID} --> {MODULE_NAME}: The results from Fetch Account details are {resultx}") 
            return resultx
    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error occurred while fetching account details: {str(e)}")
        return None
