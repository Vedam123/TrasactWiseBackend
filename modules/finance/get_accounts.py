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

        invalid_params_present = any(param for param in request.args.keys() if param not in ['account_id', 'account_number', 'account_category', 'account_name', 'account_type', 'company_name', 'company_id', 'department_name', 'department_id', 'currency_id', 'default_account'])
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

        # Query with all three parameters
        query_all_params = """
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

        if company_id:
            query_all_params += " AND a.company_id = %s"
        if department_id:
            query_all_params += " AND a.department_id = %s"
        if currency_id:
            query_all_params += " AND a.currency_id = %s"
        
        # Additional optional filters
        if account_id:
            query_all_params += " AND a.account_id = %s"
        if account_number:
            query_all_params += " AND a.account_number = %s"
        if account_name:
            query_all_params += " AND a.account_name REGEXP %s"
        if account_category:
            query_all_params += " AND a.account_category REGEXP %s"
        if account_type:
            query_all_params += " AND a.account_type REGEXP %s"
        if company_name:
            query_all_params += " AND c.name REGEXP %s"
        if department_name:
            query_all_params += " AND d.department_name REGEXP %s"
        if default_account:
            query_all_params += " AND a.default_account = %s"

        # Query with only company_id and currency_id if no results are found
        query_fallback = """
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
        
        if company_id:
            query_fallback += " AND a.company_id = %s"
        if currency_id:
            query_fallback += " AND a.currency_id = %s"
        
        # Additional optional filters for fallback query
        if account_id:
            query_fallback += " AND a.account_id = %s"
        if account_number:
            query_fallback += " AND a.account_number = %s"
        if account_name:
            query_fallback += " AND a.account_name REGEXP %s"
        if account_category:
            query_fallback += " AND a.account_category REGEXP %s"
        if account_type:
            query_fallback += " AND a.account_type REGEXP %s"
        if company_name:
            query_fallback += " AND c.name REGEXP %s"
        if department_name:
            query_fallback += " AND d.department_name REGEXP %s"
        if default_account:
            query_fallback += " AND a.default_account = %s"

        # First try with all parameters
        params_all = []
        if company_id:
            params_all.append(company_id)
        if department_id:
            params_all.append(department_id)
        if currency_id:
            params_all.append(currency_id)
        if account_id:
            params_all.append(account_id)
        if account_number:
            params_all.append(account_number)
        if account_name:
            params_all.append(account_name)
        if account_category:
            params_all.append(account_category)
        if account_type:
            params_all.append(account_type)
        if company_name:
            params_all.append(company_name)
        if department_name:
            params_all.append(department_name)
        if default_account:
            params_all.append(default_account)

        mycursor.execute(query_all_params, params_all)
        result = mycursor.fetchall()
        accounts_list = []

        if not result:
            # If no results, try fallback query with company_id and currency_id
            params_fallback = []
            if company_id:
                params_fallback.append(company_id)
            if currency_id:
                params_fallback.append(currency_id)
            if account_id:
                params_fallback.append(account_id)
            if account_number:
                params_fallback.append(account_number)
            if account_name:
                params_fallback.append(account_name)
            if account_category:
                params_fallback.append(account_category)
            if account_type:
                params_fallback.append(account_type)
            if company_name:
                params_fallback.append(company_name)
            if department_name:
                params_fallback.append(department_name)
            if default_account:
                params_fallback.append(default_account)

            mycursor.execute(query_fallback, params_fallback)
            result = mycursor.fetchall()

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
