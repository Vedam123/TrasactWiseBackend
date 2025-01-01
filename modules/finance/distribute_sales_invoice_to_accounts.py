from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger

distribute_sales_invoice_to_accounts_api = Blueprint('distribute_sales_invoice_to_accounts_api', __name__)

@distribute_sales_invoice_to_accounts_api.route('/distribute_sales_invoice_to_accounts', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def distribute_sales_invoice_to_accounts():
    try:
      	
        authorization_header = request.headers.get('Authorization')

        try:
            company, instance, dbuser, mydb, appuser, appuserid, user_info, employee_info = get_user_and_db_details(authorization_header)
            logger.debug(f"{appuser} --> {__name__}: Successfully retrieved user details from the token.")
        except ValueError as e:
            logger.error(f"Failed to retrieve user details from token. Error: {str(e)}")
            return jsonify({"error": str(e)}), 401
        
        if not appuser:
            logger.error(f"Unauthorized access attempt: {appuser} --> {__name__}: Application user not found.")
            return jsonify({"error": "Unauthorized. Username not found."}), 401
        

        # Log entry point
        logger.debug(f"{appuser} --> {__name__}: Entered the 'distribute_sales_invoice_to_accounts' function")

        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        # Log the received data
        logger.debug(f"{appuser} --> {__name__}: Received data: {data}")

        # Updated SQL query to include the is_tax_line field
        insert_query = """
            INSERT INTO fin.salesinvoiceaccounts (header_id, line_number, account_id, debitamount, creditamount, is_tax_line, created_by, updated_by)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        """

        mycursor = mydb.cursor()

        try:
            response_accounts = []

            if 'lines' in data:  # Check if 'lines' key exists in data
                for item in data['lines']:  # Iterate over each item in 'lines'
                    # Extract the is_tax_line value from the request data, defaulting to False if not provided
                    is_tax_line = item.get('is_tax_line', False)

                    # Prepare the values for the SQL statement
                    insert_values = (
                        data.get('header_id'),  
                        item.get('line_number'),  # Extract 'line_number' from item                 
                        item.get('account_id'),
                        item.get('debitamount'),
                        item.get('creditamount'),
                        is_tax_line,  # Include the is_tax_line value
                        appuserid,  # created_by
                        appuserid   # updated_by
                    )

                    mycursor.execute(insert_query, insert_values)
                    mydb.commit()

                    line_number = mycursor.lastrowid  # Get the ID of the inserted row

                    response_accounts.append({
                        'line_id': line_number
                    })
            else:
                raise ValueError("'lines' key not found in request data")

            # Log success and close the cursor and connection
            logger.info(f"{appuser} --> {__name__}: Sales invoice account data created successfully")
            mycursor.close()
            mydb.close()

            # Construct response with additional data
            response = {
                'success': True,
                'message': 'Sales Invoice Accounts created successfully',
                'accounts': response_accounts
            }

            return jsonify(response), 200

        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{appuser} --> {__name__}: Unable to create sales invoice account data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500

    except Exception as e:
        # Log any exceptions
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
