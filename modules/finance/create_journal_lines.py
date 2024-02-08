from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

journal_api = Blueprint('journal_api', __name__)

@journal_api.route('/create_journal_line', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_journal_line():
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
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'create_journal_line' function")

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

        # Assuming your journal_lines table has columns like header_id, account_id, etc.
        insert_query = """
            INSERT INTO fin.journal_lines (line_number, header_id, account_id, debit, credit, status, created_by, updated_by)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        """

        if not isinstance(data, list):
            return jsonify({'error': 'Invalid JSON input. Expected a list of journal lines.'}), 400

        mycursor = mydb.cursor()

        try:
            response_lines = []

            for line_data in data:
                # Assuming the data dictionary contains the necessary keys
                insert_values = (
                    line_data.get('line_number'),
                    line_data.get('header_id'),
                    line_data.get('account_id'),
                    line_data.get('debit', 0.0),
                    line_data.get('credit', 0.0),
                    line_data.get('status'),
                    current_userid,  # created_by
                    current_userid   # updated_by
                )

                mycursor.execute(insert_query, insert_values)
                mydb.commit()

                response_lines.append({
                    'line_id': mycursor.lastrowid,
                    'header_id': line_data.get('header_id')
                })

            # Log success and close the cursor and connection
            logger.info(f"{USER_ID} --> {MODULE_NAME}: Journal line data created successfully")
            mycursor.close()
            mydb.close()

            return jsonify({'success': True, 'message': 'Journal Lines successfully created', 'journal_lines': response_lines}), 201

        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{USER_ID} --> {MODULE_NAME}: Unable to create journal line data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500

    except Exception as e:
        # Log any exceptions
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
