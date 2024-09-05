import json
from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required  # Import the decorator
from config import READ_ACCESS_TYPE  # Adjust according to your needs
from modules.utilities.logger import logger  # Import the logger module
from modules.security.get_user_from_token import get_user_from_token
from modules.admin.routines.get_next_free_number_function import get_next_free_number_function

# Create a new blueprint for the API
get_next_free_number_api = Blueprint('get_next_free_number_api', __name__)

@get_next_free_number_api.route('/get_next_free_number', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)  # Adjust permission type as needed
def get_next_free_number():
    authorization_header = request.headers.get('Authorization')
    token_results = ""
    USER_ID = ""
    MODULE_NAME = __name__

    if authorization_header:
        token_results = get_user_from_token(authorization_header) if authorization_header else None

    if token_results:
        USER_ID = token_results["username"]

    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the get_next_free_number function")

    try:
        # Log entry point
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the get_next_free_number function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)

        # Retrieve query parameters
        sequence_name = request.args.get('sequence_name')
        if not sequence_name:
            logger.error(f"{USER_ID} --> {MODULE_NAME}: sequence_name parameter is missing")
            return jsonify({'error': 'sequence_name parameter is required'}), 400

        # Call the function to get the next sequence value
        next_value = get_next_free_number_function(sequence_name, mydb, USER_ID, MODULE_NAME)
        
        mydb.close()

        logger.info(f"{USER_ID} --> {MODULE_NAME}: Successfully retrieved next sequence value: {next_value}")
        return jsonify({'next_value': next_value})

    except Exception as e:
        mydb.close()
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
