from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

default_accounts_api = Blueprint('default_accounts_api', __name__)

@default_accounts_api.route('/get_default_accounts', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_default_accounts():
    MODULE_NAME = __name__

    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'get_default_accounts' function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)
        mycursor = mydb.cursor()

        query = """
            SELECT
                da.line_id,
                da.header_id,
                da.account_id,
                da.account_type,                
                da.description,
                da.created_at,
                da.updated_at,
                da.created_by,
                da.updated_by,
                a.account_number,
                a.account_name,
                a.account_category,
                a.opening_balance,
                a.current_balance,
                a.currency_id,
                a.bank_name,
                a.branch_name,
                a.account_holder_name,
                a.contact_number,
                a.email,
                a.address,
                a.is_active,
                a.department_id,
                a.company_id
            FROM fin.default_accounts da
            JOIN fin.accounts a ON da.account_id = a.account_id
        """

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Executing query: {query}")
        mycursor.execute(query)

        result = mycursor.fetchall()
        default_accounts_list = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        for row in result:
            default_accounts_dict = {}

            for column in columns:
                default_accounts_dict[column] = row[column_indices[column]]

            default_accounts_list.append(default_accounts_dict)

        mycursor.close()
        mydb.close()

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Successfully retrieved default accounts data")

        return jsonify({'default_accounts_list': default_accounts_list})

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error retrieving default accounts data - {str(e)}")
        import traceback
        traceback.print_exc()  # Add this line to print the full stack trace
        return jsonify({'error': 'Internal Server Error'}), 500
