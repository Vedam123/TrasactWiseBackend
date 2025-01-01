from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import READ_ACCESS_TYPE
from modules.utilities.logger import logger

get_invoice_distributions_api = Blueprint('get_invoice_distributions_api', __name__)

@get_invoice_distributions_api.route('/get_sales_invoice_accounts', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_sales_invoice_accounts():
    

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

        logger.debug(f"{appuser} --> {__name__}: Entered the 'get_sales_invoice_accounts' function")

        # Fetching input parameters from the request
        line_id_str = request.args.get('line_id')
        line_id = int(line_id_str.strip('"')) if line_id_str is not None else None

        line_number = request.args.get('line_number')

        header_id_str = request.args.get('header_id')
        header_id = int(header_id_str.strip('"')) if header_id_str is not None else None

        account_id_str = request.args.get('account_id')
        account_id = int(account_id_str.strip('"')) if account_id_str is not None else None

        invoice_number = request.args.get('invoice_number')

        mycursor = mydb.cursor()

        # Constructing the SQL query
        query = """
            SELECT 
                sia.line_id, sia.line_number, sia.header_id, sia.account_id, sia.debitamount, sia.creditamount, 
                sia.created_at, sia.updated_at, sia.created_by, sia.updated_by,
                a.account_number, a.account_name, a.account_type,
                si.invoice_number, si.totalamount,
                cur.currencycode, cur.currencyname, cur.currencysymbol,a.account_category,a.account_type , sia.is_tax_line
            FROM fin.salesinvoiceaccounts sia
            LEFT JOIN fin.accounts a ON sia.account_id = a.account_id
            LEFT JOIN fin.salesinvoice si ON sia.header_id = si.header_id
            LEFT JOIN com.currency cur ON si.currency_id = cur.currency_id
            WHERE 1=1
        """

        # Adding conditions based on input parameters
        if line_id:
            query += f" AND sia.line_id = {line_id}"
        if line_number:
            query += f" AND sia.line_number = '{line_number}'"
        if header_id:
            query += f" AND sia.header_id = {header_id}"
        if account_id:
            query += f" AND sia.account_id = {account_id}"
        if invoice_number:
            query += f" AND si.invoice_number = '{invoice_number}'"

        mycursor.execute(query)

        result = mycursor.fetchall()
        sales_invoice_accounts = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        for row in result:
            sales_invoice_account_dict = {}

            for column in columns:
                sales_invoice_account_dict[column] = row[column_indices[column]]

            sales_invoice_accounts.append(sales_invoice_account_dict)

        mycursor.close()
        mydb.close()

        logger.debug(f"{appuser} --> {__name__}: Successfully retrieved sales invoice accounts data")

        return jsonify({'sales_invoice_accounts': sales_invoice_accounts})

    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Error retrieving sales invoice accounts data - {str(e)}")
        import traceback
        traceback.print_exc()  # Add this line to print the full stack trace
        return jsonify({'error': 'Internal Server Error'}), 500
