from flask import Blueprint, jsonify, request
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.security.permission_required import permission_required  # Import the decorator
from config import WRITE_ACCESS_TYPE    # Import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger  # Import the logger module

create_ui_config_data_api = Blueprint('create_ui_config_data_api', __name__)

@create_ui_config_data_api.route('/create_ui_config_data', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE ,  __file__)  # Pass WRITE_ACCESS_TYPE as an argument
def create_ui_config_data():
    authorization_header = request.headers.get('Authorization')
    
    try:
        company, instance, dbuser, mydb, appuser, appuserid, user_info, employee_info = get_user_and_db_details(authorization_header)
    except ValueError as e:
        logger.error(f"Authorization failed for appuser {appuser} --> {__name__}: {str(e)}")
        return jsonify({"error": str(e)}), 401
    
    if not appuser:
        logger.error(f"Unauthorized access attempt for appuser {appuser} --> {__name__}: Application user not found")
        return jsonify({"error": f"Unauthorized. Application user {appuser} not found."}), 401

    if request.content_type == 'application/json':
        data = request.get_json()
    else:
        data = request.form

    try:
        config_key = data.get('config_key')
        config_value = data.get('config_value')

        if not config_key or not config_value:
            return jsonify({'error': 'Both config_key and config_value are required'}), 400

        mycursor = mydb.cursor()

        # Insert the UI configuration data into the database
        query = "INSERT INTO adm.ui_config_data (config_key, config_value) VALUES (%s, %s)"
        values = (config_key, config_value)

        mycursor.execute(query, values)
        mydb.commit()

        # Close the cursor and connection
        mycursor.close()
        mydb.close()

        return jsonify({'message': 'UI configuration data created successfully'})

    except Exception as e:
        # Close the cursor and connection
        mycursor.close()
        mydb.close()
        return jsonify({'error': str(e)}), 500
