from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

distribute_invoice_to_accounts_api = Blueprint('distribute_invoice_to_accounts_api', __name__)

@distribute_invoice_to_accounts_api.route('/distribute_invoice_to_accounts', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def distribute_invoice_to_accounts():
    try:
        authorization_header = request.headers.get('Authorization')
        token_results = ""
        USER_ID = ""
        MODULE_NAME = __name__
        if authorization_header:
            token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
            token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None

        # Log entry point
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'create_purchase_invoice_accounts' function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)

        current_userid = None
        authorization_header = request.headers.get('Authorization', '')
        if authorization_header.startswith('Bearer '):
            token = authorization_header.replace('Bearer ', '')
            decoded_token = decode_token(token)
            current_userid = decoded_token.get('Userid')

        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        # Log the received data
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Received data: {data}")

        # Assuming your purchaseinvoiceaccounts table has columns like header_id, account_id, etc.
        insert_query = """
            INSERT INTO fin.purchaseinvoiceaccounts (header_id, line_number, account_id, debitamount, creditamount, created_by, updated_by)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
        """

        mycursor = mydb.cursor()

        try:
            response_accounts = []

            for account_data in data:
                # Assuming the data dictionary contains the necessary keys for each account
                insert_values = (
                    account_data.get('header_id'),
                    account_data.get('line_number'),                    
                    account_data.get('account_id'),
                    account_data.get('debitamount'),
                    account_data.get('creditamount'),
                    current_userid,  # created_by
                    current_userid   # updated_by
                )

                mycursor.execute(insert_query, insert_values)
                mydb.commit()

                line_number = mycursor.lastrowid  # Get the ID of the inserted row

                response_accounts.append({
                    'line_number': line_number
                })

            # Log success and close the cursor and connection
            logger.info(f"{USER_ID} --> {MODULE_NAME}: Purchase invoice account data created successfully")
            mycursor.close()
            mydb.close()

            # Construct response with additional data
            response = {
                'success': True,
                'message': 'Purchase Invoice Accounts created successfully',
                'accounts': response_accounts
            }

            return response, 200

        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{USER_ID} --> {MODULE_NAME}: Unable to create purchase invoice account data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500

    except Exception as e:
        # Log any exceptions
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
