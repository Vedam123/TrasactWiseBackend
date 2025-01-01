from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import READ_ACCESS_TYPE
from modules.utilities.logger import logger

default_accounts_api = Blueprint('default_accounts_api', __name__)

@default_accounts_api.route('/get_default_accounts', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_default_accounts():
    

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

        logger.debug(f"{appuser} --> {__name__}: Entered the 'get_default_accounts' function")

        mycursor = mydb.cursor()

        # Base query
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
            WHERE 1=1
        """

        # Check for optional query parameters and append them to the query
        header_id = request.args.get('header_id')
        company_id = request.args.get('company_id')
        currency_id = request.args.get('currency_id')

        if header_id:
            query += f" AND da.header_id = {int(header_id)}"
        if company_id:
            query += f" AND a.company_id = {int(company_id)}"
        if currency_id:
            query += f" AND a.currency_id = {int(currency_id)}"

        logger.debug(f"{appuser} --> {__name__}: Executing query: {query}")
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

        logger.debug(f"{appuser} --> {__name__}: Successfully retrieved default accounts data")

        return jsonify({'default_accounts_list': default_accounts_list})

    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Error retrieving default accounts data - {str(e)}")
        import traceback
        traceback.print_exc()  # Add this line to print the full stack trace
        return jsonify({'error': 'Internal Server Error'}), 500
