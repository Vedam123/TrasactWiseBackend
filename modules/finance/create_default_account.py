from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
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

        # Assuming the input data is in JSON format
        data = request.get_json()

        header_id = data.get('header_id')
        account_id = data.get('account_id')
        account_type = data.get('account_type')
        description = data.get('description', '')
        created_by = USER_ID  # Assuming created_by is the current user
        updated_by = USER_ID  # Assuming updated_by is the current user

        # Check if the required fields are provided
        if not header_id or not account_id or not account_type:
            return jsonify({'error': 'Missing required fields'}), 400

        # Insert query with account_type included
        insert_query = """
            INSERT INTO fin.default_accounts (header_id, account_id, account_type, description, created_by, updated_by)
            VALUES (%s, %s, %s, %s, %s, %s)
        """
        insert_values = (header_id, account_id, account_type, description, created_by, updated_by)

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Executing query: {insert_query} with values: {insert_values}")
        mycursor.execute(insert_query, insert_values)
        mydb.commit()

        # Fetch the inserted line_id
        line_id = mycursor.lastrowid

        mycursor.close()
        mydb.close()

        logger.info(f"{USER_ID} --> {MODULE_NAME}: Default account created successfully with line_id {line_id}")

        return jsonify({'message': 'Default account created successfully', 'line_id': line_id}), 201

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error creating default account - {str(e)}")
        import traceback
        traceback.print_exc()  # Add this line to print the full stack trace
        return jsonify({'error': 'Internal Server Error'}), 500
