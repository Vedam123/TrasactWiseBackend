import json
from flask import Blueprint, jsonify, request
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.security.permission_required import permission_required  # Import the decorator
from config import WRITE_ACCESS_TYPE    # Import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger  # Import the logger module

create_db_config_data_api = Blueprint('create_db_config_data_api', __name__)

@create_db_config_data_api.route('/create_db_config_data', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE ,  __file__)  # Pass READ_ACCESS_TYPE as an argument
def create_db_config_data():
    authorization_header = request.headers.get('Authorization')
    
    try:
        company, instance, dbuser, mydb, appuser, appuserid, user_info, employee_info = get_user_and_db_details(authorization_header)
    except ValueError as e:
        logger.error(f"Authorization failed for appuser {appuser} --> {__name__}: {str(e)}")
        return jsonify({"error": str(e)}), 401
    
    if not appuser:
        logger.error(f"Unauthorized access attempt for appuser {appuser} --> {__name__}: Application user not found")
        return jsonify({"error": f"Unauthorized. Application user {appuser} not found."}), 401
    
    try:
        # Log entry point
        logger.debug(f"{appuser} --> {__name__}: Entered in the create_db_config_data function")

        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        # Log the received data
        logger.debug(f"{appuser} --> {__name__}: Received data: {json.dumps(data)}")

        success = False  # Initialize a flag to track success
        success_user = False
        success_config = False

        # Check if all fields have values for adm.bk_super_user table
        if all(data.get(field) for field in ['username', 'name', 'password']):
            # Log that user data is available
            logger.debug(f"{appuser} --> {__name__}: All user values")

            username = data['username']
            name = data['name']
            password = data['password']

            mycursor = mydb.cursor()
            query = "INSERT INTO adm.bk_super_user (username, name, password) VALUES (%s, %s, %s)"
            values = (username, name, password)
            mycursor.execute(query, values)
            mydb.commit()
            mycursor.close()

            if mycursor.rowcount > 0:
                # Log that user data was successfully inserted
                logger.info(f"{appuser} --> {__name__}: Data successfully inserted in the users table")
                success_user = True  # Table 1 update is successful
            else:
                # Log that user data insertion failed
                logger.error(f"{appuser} --> {__name__}: Failed to insert data into the users table")
                success_user = False  # Table 1 update failed
        else:
            # Log that not all user data is present
            logger.warning(f"{appuser} --> {__name__}: Not all user values present to insert data into the users table")
            success_user = False  # Table 1 update failed

        # Check if all fields have values for adm.bk_configurations table
        if all(data.get(field) for field in ['config_key', 'config_value']):
            # Log that config data is available
            logger.debug(f"{appuser} --> {__name__}: All config values")

            config_key = data.get('config_key')
            config_value = data.get('config_value')

            mycursor = mydb.cursor()
            query = "INSERT INTO adm.bk_configurations (config_key, config_value) VALUES (%s, %s)"
            values = (config_key, config_value)
            mycursor.execute(query, values)
            mydb.commit()
            mycursor.close()

            if mycursor.rowcount > 0:
                # Log that config data was successfully inserted
                logger.info(f"{appuser} --> {__name__}: Data successfully inserted in the configuration table")
                success_config = True  # Table 2 update is successful
            else:
                # Log that config data insertion failed
                logger.error(f"{appuser} --> {__name__}: Failed to insert data into the configuration table")
                success_config = False  # Table 2 update failed
        else:
            # Log that not all config data is present
            logger.warning(f"{appuser} --> {__name__}: Not all config values present to insert data into the users table")
            success_config = False  # Table 1 update failed

        mydb.close()

        if success_user or success_config:
            success = True

        if success:
            # Log the success message
            logger.info(f"{appuser} --> {__name__}: Data inserted successfully into relevant table(s)")
            return jsonify({'message': 'Data inserted successfully into relevant table(s)'})
        else:
            # Log the error message
            logger.error(f"{appuser} --> {__name__}: No relevant data provided to insert into any table")
            return jsonify({'error': 'No relevant data provided to insert into any table'}), 400

    except Exception as e:
        mydb.close()
        # Log the error message
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
