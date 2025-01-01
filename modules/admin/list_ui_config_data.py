from flask import Blueprint, jsonify, request
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.security.permission_required import permission_required  # Import the decorator
from config import READ_ACCESS_TYPE  # Import READ_ACCESS_TYPE
from modules.utilities.logger import logger  # Import the logger module

config_data_api = Blueprint('config_data_api', __name__)

@config_data_api.route('/list_ui_config_data', methods=['GET'])
@permission_required(READ_ACCESS_TYPE ,  __file__)  # Pass READ_ACCESS_TYPE as an argument
def list_ui_config_data():
    authorization_header = request.headers.get('Authorization')
    
    try:
        company, instance, dbuser, mydb, appuser, appuserid, user_info, employee_info = get_user_and_db_details(authorization_header)
    except ValueError as e:
        logger.error(f"Authorization failed for appuser {appuser} --> {__name__}: {str(e)}")
        return jsonify({"error": str(e)}), 401
    
    if not appuser:
        logger.error(f"Unauthorized access attempt for appuser {appuser} --> {__name__}: Application user not found")
        return jsonify({"error": f"Unauthorized. Application user {appuser} not found."}), 401
    
    config_key = request.args.get('config_key')  # Get the config_key query parameter

    try:
        mycursor = mydb.cursor()

        if config_key is not None:
            # If config_key is provided, search for a specific key
            query = "SELECT config_key, config_value FROM adm.ui_config_data WHERE config_key like %s"
            print(config_key)
            mycursor.execute(query, ('%' + config_key + '%',))
            ##mycursor.execute(query, (config_key,))
        else:
            # If no config_key is provided, fetch all data
            query = "SELECT config_key, config_value FROM adm.ui_config_data"
            mycursor.execute(query)

        config_data = mycursor.fetchall()

        # Convert the data into a list of dictionaries
        config_list = []
        for data in config_data:
            config_dict = {
                'config_key': data[0],
                'config_value': data[1]
            }
            config_list.append(config_dict)

        mycursor.close()
        mydb.close()

        # Return the list of key-value pairs as JSON response
        return jsonify(config_list)

    except Exception as e:
        return jsonify({'error': str(e)})
