from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

# Define the Blueprint
delete_journal_line_api = Blueprint('delete_journal_line_api', __name__)

# Define the route
@delete_journal_line_api.route('/delete_journal_line', methods=['DELETE'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def delete_journal_line():
    try:
        # Get the user ID from the token
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header) if authorization_header else None
        USER_ID = token_results["username"] if token_results else ""
        MODULE_NAME = __name__
        message = ""

        # Log entry point
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'delete_journal_line' function")

        # Get the database connection
        mydb = get_database_connection(USER_ID, MODULE_NAME)

        # Get the current user ID from the token
        current_userid = decode_token(authorization_header.replace('Bearer ', '')).get('Userid') if authorization_header.startswith('Bearer ') else None

        # Get the request data
        data = request.get_json()

        header_id = int(data.get('header_id'))
        line_id = int(data.get('line_id'))

        # Log the received data
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Received data: {data}")

        # Check if both header and line data exist
        if not record_exists_in_database(mydb, header_id, line_id):
            return jsonify({'error': 'No such line exists in the journal lines.'}), 404

        # Delete the line
        delete_line_from_database(mydb, header_id, line_id)

        # Log success
        logger.info(f"{USER_ID} --> {MODULE_NAME}: Deleted journal line")

        # Close the database connection
        mydb.close()

        return jsonify({'success': True, 'message': 'Journal line deleted successfully.'}), 200

    except Exception as e:
        # Log any exceptions
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500

def record_exists_in_database(mydb, header_id, line_id):
    try:
        # Query to check if a record exists with the given parameters
        select_query = """
            SELECT COUNT(*) 
            FROM fin.journal_lines 
            WHERE header_id = %s AND line_id = %s
        """

        # Initialize the cursor
        mycursor = mydb.cursor()

        # Execute the select query
        mycursor.execute(select_query, (header_id, line_id))
        result = mycursor.fetchone()

        # Check if any record exists
        return result[0] > 0

    except Exception as e:
        raise e

    finally:
        # Close the cursor
        mycursor.close()

def delete_line_from_database(mydb, header_id, line_id):
    try:
        # Delete query
        delete_query = """
            DELETE FROM fin.journal_lines
            WHERE header_id = %s AND line_id = %s
        """

        # Initialize the cursor
        mycursor = mydb.cursor()

        # Execute the delete query
        mycursor.execute(delete_query, (header_id, line_id))
        mydb.commit()

    except Exception as e:
        raise e

    finally:
        # Close the cursor
        mycursor.close()
