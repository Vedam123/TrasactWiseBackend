from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

distribute_sales_invoice_to_accounts_api = Blueprint('distribute_sales_invoice_to_accounts_api', __name__)

@distribute_sales_invoice_to_accounts_api.route('/distribute_sales_invoice_to_accounts', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def distribute_sales_invoice_to_accounts():
    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header) if authorization_header else None
        USER_ID = token_results["username"] if token_results else ""
        MODULE_NAME = __name__

        # Log entry point
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'distribute_sales_invoice_to_accounts' function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)

        current_userid = decode_token(authorization_header.replace('Bearer ', '')).get('Userid') if authorization_header.startswith('Bearer ') else None

        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        # Log the received data
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Received data: {data}")

        # Assuming your salesinvoiceaccounts table has columns like header_id, account_id, etc.
        insert_query = """
            INSERT INTO fin.salesinvoiceaccounts (header_id, line_number, account_id, debitamount, creditamount, created_by, updated_by)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
        """

        mycursor = mydb.cursor()

        try:
            response_accounts = []

            if isinstance(data, list):  # Check if data is a list
                for item in data:  # Iterate over each item in the list
                    # Assuming the item dictionary contains the necessary keys for each account
                    insert_values = (
                        item.get('header_id'),  
                        item.get('line_number'),                    
                        item.get('account_id'),
                        item.get('debitamount'),
                        item.get('creditamount'),
                        current_userid,  # created_by
                        current_userid   # updated_by
                    )

                    mycursor.execute(insert_query, insert_values)
                    mydb.commit()

                    line_number = mycursor.lastrowid  # Get the ID of the inserted row

                    response_accounts.append({
                        'line_id': line_number
                    })
            else:  # If data is not a list, handle it as a single dictionary
                # Assuming the data dictionary contains the necessary keys for each account
                insert_values = (
                    data.get('header_id'),  
                    data.get('line_number'),                    
                    data.get('account_id'),
                    data.get('debitamount'),
                    data.get('creditamount'),
                    current_userid,  # created_by
                    current_userid   # updated_by
                )

                mycursor.execute(insert_query, insert_values)
                mydb.commit()

                line_number = mycursor.lastrowid  # Get the ID of the inserted row

                response_accounts.append({
                    'line_id': line_number
                })

            # Log success and close the cursor and connection
            logger.info(f"{USER_ID} --> {MODULE_NAME}: Sales invoice account data created successfully")
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
            logger.error(f"{USER_ID} --> {MODULE_NAME}: Unable to create sales invoice account data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500

    except Exception as e:
        # Log any exceptions
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
