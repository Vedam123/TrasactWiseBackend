from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import READ_ACCESS_TYPE
from modules.utilities.logger import logger

journal_api = Blueprint('journal_api', __name__)

@journal_api.route('/get_journal_headers', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_journal_headers():
    

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

        logger.debug(f"{appuser} --> {__name__}: Entered the 'get journal headers' function")

        invalid_params_present = any(param for param in request.args.keys() if param not in ['company_id', 'department_id', 'journal_date', 'journal_type', 'description', 'currency_id', 'status', 'source_number', 'journal_number'])
        if invalid_params_present:
            return jsonify({'error': 'Invalid query parameter(s) detected'}), 400

        company_id_str = request.args.get('company_id')
        company_id = int(company_id_str.strip('"')) if company_id_str is not None else None
        department_id_str = request.args.get('department_id')
        department_id = int(department_id_str.strip('"')) if department_id_str is not None else None
        journal_date = request.args.get('journal_date')
        journal_type = request.args.get('journal_type')
        description = request.args.get('description')
        currency_id_str = request.args.get('currency_id')
        currency_id = int(currency_id_str.strip('"')) if currency_id_str is not None else None
        status = request.args.get('status')
        source_number_str = request.args.get('source_number')
        source_number = int(source_number_str.strip('"')) if source_number_str is not None else None
        journal_number_str = request.args.get('journal_number')  # Added journal_number parsing
        journal_number = int(journal_number_str.strip('"')) if journal_number_str is not None else None  # Convert to int if not None

        mycursor = mydb.cursor()

        query = """
            SELECT 
                j.header_id, j.company_id, j.department_id, j.journal_date, j.journal_type, 
                j.description, j.currency_id, j.status, j.journal_number, j.source_number,  -- Include journal_number field in the select query
                j.created_at, j.updated_at, j.created_by, j.updated_by,
                c.name AS company_name,
                c.description AS company_description,
                d.department_name,
                d.description AS department_description,
                cur.currencycode,
                cur.currencyname,
                cur.currencysymbol
            FROM fin.journal_headers j
            LEFT JOIN com.company c ON j.company_id = c.id
            LEFT JOIN com.currency cur ON j.currency_id = cur.currency_id
            LEFT JOIN com.department d ON j.department_id = d.id
            WHERE 1=1
        """

        if company_id:
            query += f" AND j.company_id = {company_id}"
        if department_id:
            query += f" AND j.department_id = {department_id}"
        if journal_date:
            query += f" AND j.journal_date = '{journal_date}'"
        if journal_type:
            query += f" AND j.journal_type = '{journal_type}'"
        if description:
            query += f" AND j.description = '{description}'"
        if currency_id:
            query += f" AND j.currency_id = {currency_id}"
        if status:
            query += f" AND j.status = '{status}'"
        if source_number:
            query += f" AND j.source_number = {source_number}"
        if journal_number:  # Include journal_number condition if provided
            query += f" AND j.journal_number = {journal_number}"

        mycursor.execute(query)

        result = mycursor.fetchall()
        journal_headers_list = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        for row in result:
            journal_header_dict = {}

            for column in columns:
                journal_header_dict[column] = row[column_indices[column]]

            journal_headers_list.append(journal_header_dict)

        mycursor.close()
        mydb.close()

        logger.debug(f"{appuser} --> {__name__}: Successfully retrieved journal headers data")

        return jsonify({'journal_headers_list': journal_headers_list})

    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Error retrieving journal headers data - {str(e)}")
        import traceback
        traceback.print_exc()  # Add this line to print the full stack trace
        return jsonify({'error': 'Internal Server Error'}), 500
