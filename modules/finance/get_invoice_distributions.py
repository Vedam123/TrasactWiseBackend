from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

get_invoice_distributions_api = Blueprint('get_invoice_distributions_api', __name__)

@get_invoice_distributions_api.route('/get_purchase_invoice_accounts', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_invoice_distributions():
    MODULE_NAME = __name__

    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'get_purchase_invoice_accounts' function")

        # Fetching input parameters from the request
        line_id_str = request.args.get('line_id')
        line_id = int(line_id_str.strip('"')) if line_id_str is not None else None

        line_number = request.args.get('line_number')

        header_id_str = request.args.get('header_id')
        header_id = int(header_id_str.strip('"')) if header_id_str is not None else None

        account_id_str = request.args.get('account_id')
        account_id = int(account_id_str.strip('"')) if account_id_str is not None else None

        invoice_number = request.args.get('invoice_number')

        # Establish database connection
        mydb = get_database_connection(USER_ID, MODULE_NAME)
        mycursor = mydb.cursor()

        # Constructing the SQL query
        query = """
            SELECT 
                pia.line_id, pia.line_number, pia.header_id, pia.account_id, pia.debitamount, pia.creditamount, 
                pia.created_at, pia.updated_at, pia.created_by, pia.updated_by,
                a.account_number, a.account_name, a.account_type,
                pi.invoice_number, pi.totalamount,a.account_category
            FROM fin.purchaseinvoiceaccounts pia
            LEFT JOIN fin.accounts a ON pia.account_id = a.account_id
            LEFT JOIN fin.purchaseinvoice pi ON pia.header_id = pi.header_id
            WHERE 1=1
        """

        # Adding conditions based on input parameters
        if line_id:
            query += f" AND pia.line_id = {line_id}"
        if line_number:
            query += f" AND pia.line_number = '{line_number}'"
        if header_id:
            query += f" AND pia.header_id = {header_id}"
        if account_id:
            query += f" AND pia.account_id = {account_id}"
        if invoice_number:
            query += f" AND pi.invoice_number = '{invoice_number}'"

        mycursor.execute(query)

        result = mycursor.fetchall()
        purchase_invoice_accounts = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        for row in result:
            purchase_invoice_account_dict = {}

            for column in columns:
                purchase_invoice_account_dict[column] = row[column_indices[column]]

            purchase_invoice_accounts.append(purchase_invoice_account_dict)

        mycursor.close()
        mydb.close()

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Successfully retrieved purchase invoice accounts data")

        return jsonify({'purchase_invoice_accounts': purchase_invoice_accounts})

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error retrieving purchase invoice accounts data - {str(e)}")
        import traceback
        traceback.print_exc()  # Add this line to print the full stack trace
        return jsonify({'error': 'Internal Server Error'}), 500
