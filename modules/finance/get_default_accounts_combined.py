from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

get_default_accounts_combined_api = Blueprint('combined_accounts_api', __name__)

@get_default_accounts_combined_api.route('/get_default_accounts_combined', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_default_accounts_combined():
    MODULE_NAME = __name__

    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'get_combined_accounts' function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)
        mycursor = mydb.cursor()

        header_id = request.args.get('header_id')

        query = """
            SELECT
                da.line_id,
                da.header_id,
                da.account_id,
                da.description AS account_description,
                da.created_at AS account_created_at,
                da.updated_at AS account_updated_at,
                da.created_by AS account_created_by,
                da.updated_by AS account_updated_by,
                dh.header_name,
                da.account_type,
                dh.created_at AS header_created_at,
                dh.updated_at AS header_updated_at,
                dh.created_by AS header_created_by,
                dh.updated_by AS header_updated_by,
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
                a.company_id,
                a.created_at AS account_created_at,
                a.updated_at AS account_updated_at,
                a.created_by AS account_created_by,
                a.updated_by AS account_updated_by,
                a.default_account
            FROM fin.default_accounts da
            JOIN fin.default_account_headers dh ON da.header_id = dh.header_id
            JOIN fin.accounts a ON da.account_id = a.account_id
        """

        if header_id:
            query += " WHERE da.header_id = %s"
            params = (header_id,)
        else:
            params = None

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Executing query: {query} with params: {params}")
        mycursor.execute(query, params)

        result = mycursor.fetchall()
        combined_accounts_list = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        for row in result:
            combined_account_dict = {}

            for column in columns:
                combined_account_dict[column] = row[column_indices[column]]

            combined_accounts_list.append(combined_account_dict)

        mycursor.close()
        mydb.close()

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Successfully retrieved combined accounts data")

        return jsonify({'combined_accounts_list': combined_accounts_list})

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error retrieving combined accounts data - {str(e)}")
        import traceback
        traceback.print_exc()  # Add this line to print the full stack trace
        return jsonify({'error': 'Internal Server Error'}), 500
