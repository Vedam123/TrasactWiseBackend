import json
from flask import Blueprint, jsonify, request
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.security.permission_required import permission_required  # Import the decorator
from config import READ_ACCESS_TYPE  # Adjust according to your needs
from modules.utilities.logger import logger  # Import the logger module
from modules.admin.routines.get_next_free_number_function import get_next_free_number_function

# Create a new blueprint for the API
get_next_free_number_api = Blueprint('get_next_free_number_api', __name__)

@get_next_free_number_api.route('/get_next_free_number', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)  # Adjust permission type as needed
def get_next_free_number():
    
    authorization_header = request.headers.get('Authorization')

    print("Authorization header ",authorization_header)
    
    try:
        company, instance, dbuser, mydb, appuser, appuserid, user_info, employee_info = get_user_and_db_details(authorization_header)
    except ValueError as e:
        logger.error(f"Authorization failed for appuser {appuser} --> {__name__}: {str(e)}")
        return jsonify({"error": str(e)}), 401
    
    if not appuser:
        logger.error(f"Unauthorized access attempt for appuser {appuser} --> {__name__}: Application user not found")
        return jsonify({"error": f"Unauthorized. Application user {appuser} not found."}), 401

    logger.debug(f"{appuser} --> {__name__}: Entered in the get_next_free_number function")

    try:
        # Log entry point
        logger.debug(f"{appuser} --> {__name__}: Entered in the get_next_free_number function")

        # Retrieve query parameters
        sequence_name = request.args.get('sequence_name')
        if not sequence_name:
            logger.error(f"{appuser} --> {__name__}: sequence_name parameter is missing")
            return jsonify({'error': 'sequence_name parameter is required'}), 400

        # Call the function to get the next sequence value
        next_value = get_next_free_number_function(sequence_name, mydb, appuser, __name__)
        
        mydb.close()

        logger.info(f"{appuser} --> {__name__}: Successfully retrieved next sequence value: {next_value}")
        return jsonify({'next_value': next_value})

    except Exception as e:
        mydb.close()
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
