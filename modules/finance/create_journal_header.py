from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

journal_api = Blueprint('journal_api', __name__)

@journal_api.route('/create_journal_header', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_journal_header():
    try:
        authorization_header = request.headers.get('Authorization')
        token_results = ""
        USER_ID = ""
        MODULE_NAME = __name__
        if authorization_header:
            token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
            token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None

        # Log entry point
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'create_journal_header' function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)

        current_userid = None
        authorization_header = request.headers.get('Authorization', '')
        if authorization_header.startswith('Bearer '):
            token = authorization_header.replace('Bearer ', '')
            decoded_token = decode_token(token)
            current_userid = decoded_token.get('Userid')

        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        # Log the received data
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Received data: {data}")

        # Assuming your journal_headers table has columns like company_id, department_id, etc.
        insert_query = """
            INSERT INTO fin.journal_headers (journal_number, company_id, department_id, journal_date, journal_type, source_number, description, currency_id, status, created_by, updated_by)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """

        # Assuming the data dictionary contains the necessary keys
        insert_values = (
            data.get('journal_number'),
            data.get('company_id'),
            data.get('department_id'),
            data.get('journal_date'),
            data.get('journal_type'),
            data.get('source_number'),
            data.get('description'),
            data.get('currency_id'),
            data.get('status'),
            current_userid,  # created_by
            current_userid   # updated_by
        )

        mycursor = mydb.cursor()

        try:
            mycursor.execute(insert_query, insert_values)
            mydb.commit()
            header_id = mycursor.lastrowid  # Get the ID of the inserted row
            journal_number = data.get('journal_number')  # Get the journal number from the request data
            currency_id = data.get('currency_id')  # Get the currency ID from the request data
            status = data.get('status')  # Get the status from the request data

            # Log success and close the cursor and connection
            logger.info(f"{USER_ID} --> {MODULE_NAME}: Journal header data created successfully")
            mycursor.close()
            mydb.close()
            
            # Construct response with additional data
            response = {
                'success': True,
                'message': 'Journal Header created successfully',
                'journal_number': journal_number,
                'header_id': header_id,
                'currency_id': currency_id,
                'status': status
            }
            
            return response, 200

        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{USER_ID} --> {MODULE_NAME}: Unable to create journal header data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500

    except Exception as e:
        # Log any exceptions
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
