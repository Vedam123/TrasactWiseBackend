from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

accounts_api = Blueprint('accounts_api', __name__)

@accounts_api.route('/get_accounts', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_accounts():
    MODULE_NAME = __name__

    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'get accounts' function")

        invalid_params_present = any(param for param in request.args.keys() if param not in ['account_id', 'account_number', 'account_category', 'account_name', 'account_type', 'company_name', 'company_id', 'department_name', 'department_id','currency_id','default_account'])
        if invalid_params_present:
            return jsonify({'error': 'Invalid query parameter(s) detected'}), 400

        account_id = request.args.get('account_id', None)
        account_number = request.args.get('account_number', None)
        account_name = request.args.get('account_name', None)
        account_category = request.args.get('account_category', None)        
        account_type = request.args.get('account_type', None)
        company_name = request.args.get('company_name', None)
        company_id = request.args.get('company_id', None)
        department_name = request.args.get('department_name', None)
        department_id = request.args.get('department_id', None)
        currency_id = request.args.get('currency_id', None)
        default_account = request.args.get('default_account', None)

        mydb = get_database_connection(USER_ID, MODULE_NAME)
        mycursor = mydb.cursor()

        query = """
            SELECT 
                a.account_id, a.account_number, a.account_name, a.account_category, a.account_type, 
                a.opening_balance, a.current_balance, a.currency_id, a.bank_name, 
                a.branch_name, a.account_holder_name, a.contact_number, a.email, 
                a.address, a.is_active, a.department_id, a.company_id, 
                a.created_at, a.updated_at, a.created_by, a.updated_by,
                d.department_name,
                c.name AS company_name,
                cur.currencycode,
                cur.currencyname,
                cur.currencysymbol,
                a.default_account
            FROM fin.accounts a
            LEFT JOIN com.department d ON a.department_id = d.id
            LEFT JOIN com.company c ON a.company_id = c.id
            LEFT JOIN com.currency cur ON a.currency_id = cur.currency_id
            WHERE 1=1
        """
        if account_id:
            query += f" AND a.account_id = '{account_id}'"
        if account_number:
            query += f" AND a.account_number = '{account_number}'"
        if account_name:
            query += f" AND a.account_name REGEXP '{account_name}'"
        if account_category:
            query += f" AND a.account_category REGEXP '{account_category}'"            
        if account_type:
            query += f" AND a.account_type REGEXP '{account_type}'"
        if company_name:
            query += f" AND c.name REGEXP '{company_name}'"
        if company_id:
            query += f" AND a.company_id = '{company_id}'"
        if department_name:
            query += f" AND d.department_name REGEXP '{department_name}'"
        if department_id:
            query += f" AND a.department_id = '{department_id}'"
        if currency_id:
            query += f" AND a.currency_id = '{currency_id}'"   
        if default_account:
            query += f" AND a.default_account = '{default_account}'"                     

        mycursor.execute(query)

        result = mycursor.fetchall()
        accounts_list = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        for row in result:
            account_dict = {}

            for column in columns:
                account_dict[column] = row[column_indices[column]]

            accounts_list.append(account_dict)

        mycursor.close()
        mydb.close()

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Successfully retrieved accounts data")

        return jsonify({'accounts_list': accounts_list})

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error retrieving accounts data - {str(e)}")
        import traceback
        traceback.print_exc()  # Add this line to print the full stack trace
        return jsonify({'error': 'Internal Server Error'}), 500
