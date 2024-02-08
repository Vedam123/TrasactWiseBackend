from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

journal_api = Blueprint('journal_api', __name__)

@journal_api.route('/get_journal_lines', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_journal_lines():
    MODULE_NAME = __name__

    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'get journal lines' function")

        # Fetching input parameters from the request
        header_id_str = request.args.get('header_id')
        header_id = int(header_id_str.strip('"')) if header_id_str is not None else None

        account_id_str = request.args.get('account_id')
        account_id = int(account_id_str.strip('"')) if account_id_str is not None else None

        status = request.args.get('status')

        line_number_str = request.args.get('line_number')  # Added line_number parsing
        line_number = int(line_number_str.strip('"')) if line_number_str is not None else None  # Convert to int if not None

        # Establish database connection
        mydb = get_database_connection(USER_ID, MODULE_NAME)
        mycursor = mydb.cursor()

        # Constructing the SQL query
        query = """
            SELECT 
                jl.line_id, jl.header_id, jl.account_id, jl.debit, jl.credit, jl.status,
                jl.created_at, jl.updated_at, jl.created_by, jl.updated_by,
                jl.line_number,  -- Include line_number field in the select query
                jh.source_number, 
                a.account_number, a.account_name, a.account_type,
                cur.currencycode, cur.currencyname, cur.currencysymbol
            FROM fin.journal_lines jl
            LEFT JOIN fin.journal_headers jh ON jl.header_id = jh.header_id
            LEFT JOIN fin.accounts a ON jl.account_id = a.account_id
            LEFT JOIN com.currency cur ON jh.currency_id = cur.currency_id
            WHERE 1=1
        """

        # Adding conditions based on input parameters
        if header_id:
            query += f" AND jl.header_id = {header_id}"
        if account_id:
            query += f" AND jl.account_id = {account_id}"
        if status:
            query += f" AND jl.status = '{status}'"
        if line_number:  # Include line_number condition if provided
            query += f" AND jl.line_number = {line_number}"

        mycursor.execute(query)

        result = mycursor.fetchall()
        journal_lines_list = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        for row in result:
            journal_line_dict = {}

            for column in columns:
                journal_line_dict[column] = row[column_indices[column]]

            journal_lines_list.append(journal_line_dict)

        mycursor.close()
        mydb.close()

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Successfully retrieved journal lines data")

        return jsonify({'journal_lines_list': journal_lines_list})

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error retrieving journal lines data - {str(e)}")
        import traceback
        traceback.print_exc()  # Add this line to print the full stack trace
        return jsonify({'error': 'Internal Server Error'}), 500
