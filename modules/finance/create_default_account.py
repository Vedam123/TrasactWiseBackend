from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from flask_jwt_extended import decode_token
from modules.utilities.logger import logger

default_accounts_api = Blueprint('default_accounts_api', __name__)

@default_accounts_api.route('/create_default_account', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_default_account():
    MODULE_NAME = __name__

    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'create_default_account' function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)
        mycursor = mydb.cursor()

        current_userid = None
        authorization_header = request.headers.get('Authorization', '')
        if authorization_header.startswith('Bearer '):
            token = authorization_header.replace('Bearer ', '')
            decoded_token = decode_token(token)
            current_userid = decoded_token.get('Userid')
            
        data = request.get_json()

        print("Received Data",data)

        if isinstance(data, list):
            for item in data:
                header_id = item.get('header_id')
                account_id = item.get('account_id')
                account_type = item.get('account_type')
                description = item.get('description', '')
                created_by = current_userid
                updated_by = current_userid

                if not header_id or not account_id or not account_type:
                    return jsonify({'error': 'Missing required fields'}), 400

                # Check if the record already exists
                check_query = """
                    SELECT COUNT(*) FROM fin.default_accounts
                    WHERE header_id = %s AND account_type = %s
                """
                mycursor.execute(check_query, (header_id, account_type))
                record_exists = mycursor.fetchone()[0]

                if record_exists:
                    logger.warning(f"{USER_ID} --> {MODULE_NAME}: Duplicate record found for header_id {header_id} and account_type {account_type}")
                    continue

                insert_query = """
                    INSERT INTO fin.default_accounts (header_id, account_id, account_type, description, created_by, updated_by)
                    VALUES (%s, %s, %s, %s, %s, %s)
                """
                insert_values = (header_id, account_id, account_type, description, created_by, updated_by)

                logger.debug(f"{USER_ID} --> {MODULE_NAME}: Executing query: {insert_query} with values: {insert_values}")
                mycursor.execute(insert_query, insert_values)
                mydb.commit()

                line_id = mycursor.lastrowid

            mycursor.close()
            mydb.close()

        logger.info(f"{USER_ID} --> {MODULE_NAME}: Default accounts created successfully")
        return jsonify({'message': 'Default accounts created successfully'}), 200
    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error creating default account - {str(e)}")
        import traceback
        traceback.print_exc()
        return jsonify({'error': 'Internal Server Error'}), 500
