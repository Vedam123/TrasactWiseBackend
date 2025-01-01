from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger
from modules.common.routines.update_company_account_header import update_company_account_header  # Import the function to update company

default_account_headers_api = Blueprint('default_account_headers_api', __name__)

@default_account_headers_api.route('/create_default_account_headers', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_default_account_headers():
    

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

        logger.debug(f"{appuser} --> {__name__}: Entered the 'create_default_account_headers' function")

        mycursor = mydb.cursor()

        # Assuming the input data is in JSON format
        data = request.get_json()

        header_name = data.get('header_name')
        company_id = int(data.get('company_id'))
        created_by = appuserid  # Assuming created_by is the current user
        updated_by = appuserid  # Assuming updated_by is the current user

        # Check if the required fields are provided
        if not header_name:
            return jsonify({'error': 'Missing required fields'}), 400

        # Insert query
        insert_query = """
            INSERT INTO fin.default_account_headers (header_name, created_by, updated_by)
            VALUES (%s, %s, %s)
        """
        insert_values = (header_name, created_by, updated_by)

        logger.debug(f"{appuser} --> {__name__}: Executing query: {insert_query} with values: {insert_values}")
        mycursor.execute(insert_query, insert_values)
        mydb.commit()

        # Fetch the inserted header_id
        header_id = mycursor.lastrowid

        # Now that the header_id is generated, call the function to update the company table
        update_result = update_company_account_header(company_id, header_id, mydb, appuserid, __name__)

        if update_result is None:
            # If the update failed, return an error response
            return jsonify({'error': 'Failed to update the company with the new default account header ID'}), 500

        mycursor.close()
        mydb.close()

        logger.info(f"{appuser} --> {__name__}: Default account header created successfully with header_id {header_id}")

        return jsonify({'message': 'Default account header created successfully and company updated', 'header_id': header_id}), 201

    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Error creating default account header - {str(e)}")
        import traceback
        traceback.print_exc()  # Add this line to print the full stack trace
        return jsonify({'error': 'Internal Server Error'}), 500
