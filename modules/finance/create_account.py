from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

accounts_api = Blueprint('accounts_api', __name__)

@accounts_api.route('/create_account', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_account():
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
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'create_account' function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)

        current_userid = None
        authorization_header = request.headers.get('Authorization', '')
        if authorization_header.startswith('Bearer '):
            token = authorization_header.replace('Bearer ', '')
            decoded_token = decode_token(token)
            current_userid = decoded_token.get('Userid')

        if request.content_type == 'application/json':
            data = request.get_json()
            print(data)
        else:
            data = request.form


        department_id = data.get('department_id')
        if department_id == '':
            department_id = None

        # Log the received data
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Received data: {data}")

        # Assuming your accounts table has columns like account_number, account_name, etc.
        insert_query = """
            INSERT INTO fin.accounts (account_number, account_name, account_category, account_type, opening_balance, currency_id, bank_name, branch_name, account_holder_name, contact_number, email, address, is_active, department_id, company_id, created_by, updated_by,default_account)
            VALUES (%s, %s, %s,%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s,%s)
        """

        # Assuming the account_data dictionary contains the necessary keys
        insert_values = (
            data.get('account_number'),
            data.get('account_name'),
            data.get('account_category'),
            data.get('account_type'),
            data.get('opening_balance'),
            int(data.get('currency_id')),
            data.get('bank_name'),
            data.get('branch_name'),
            data.get('account_holder_name'),
            data.get('contact_number'),
            data.get('email'),
            data.get('address'),
            data.get('is_active'),
            department_id,
            data.get('company_id'),
            current_userid,  # created_by
            current_userid,   # updated_by
            data.get('default_account')
        )

        mycursor = mydb.cursor()

        try:
            mycursor.execute(insert_query, insert_values)
            mydb.commit()

            # Log success and close the cursor and connection
            logger.info(f"{USER_ID} --> {MODULE_NAME}: Account data created successfully")
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Account created successfully'}), 200

        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{USER_ID} --> {MODULE_NAME}: Unable to create account data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500

    except Exception as e:
        # Log any exceptions
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
