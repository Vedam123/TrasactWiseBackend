from flask import Blueprint, jsonify, current_app, request
import os
from modules.security.permission_required import permission_required  # Import the decorator
from config import READ_ACCESS_TYPE,BACKEND_APP_ROOT_PATH  # Import READ_ACCESS_TYPE
from modules.utilities.logger import logger  # Import the logger module
from modules.security.routines.get_user_and_db_details import get_user_and_db_details

fetch_module_data_api = Blueprint('fetch_module_data_api', __name__)

# Function to fetch folder names
# Function to fetch folder names
def get_module_names(appuser, __name__):
    try:
        folder_names = []
        modules_path = os.path.join(BACKEND_APP_ROOT_PATH, 'modules')  # Use BACKEND_APP_ROOT_PATH

        logger.debug(f"{appuser} --> {__name__}: Fetching folder names from path: {modules_path}")

        if not os.path.exists(modules_path):
            logger.warning(f"{appuser} --> {__name__}: Modules directory does not exist: {modules_path}")
            return []

        for folder in os.listdir(modules_path):
            if os.path.isdir(os.path.join(modules_path, folder)):
                folder_names.append(folder)

        logger.debug(f"{appuser} --> {__name__}: Retrieved folder names: {folder_names}")
        return folder_names
    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Error fetching module names: {e}")
        return []


# Function to store folder names in the database
def store_module_names(folder_names, appuserid, __name__, mydb, appuser):
    try:
        logger.debug(f"{appuser} --> {__name__}: Connecting to DB to store folder names: {folder_names}")
        mycursor = mydb.cursor()

        # Drop the adm.modules table if it exists
        mycursor.execute("DROP TABLE IF EXISTS adm.modules")
        logger.debug(f"{appuser} --> {__name__}: Dropped 'adm.modules' table if it existed.")

        # Create the adm.modules table again
        mycursor.execute("""
            CREATE TABLE adm.modules (
            id INT PRIMARY KEY AUTO_INCREMENT,
            folder_name VARCHAR(100) NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            created_by INT,
            updated_by INT
        ) AUTO_INCREMENT = 10;
        """)
        logger.debug(f"{appuser} --> {__name__}: Created 'adm.modules' table successfully.")

        for folder_name in folder_names:
            sql = "INSERT INTO adm.modules (folder_name, created_by, updated_by) VALUES (%s, %s, %s)"
            values = (folder_name, appuserid, appuserid)
            mycursor.execute(sql, values)
            logger.debug(f"{appuser} --> {__name__}: Inserted folder '{folder_name}' into 'adm.modules' table.")

        mydb.commit()
        mycursor.close()
        logger.debug(f"{appuser} --> {__name__}: All folder names inserted successfully into 'adm.modules' table.")
        return True
    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Error storing module names: {e}")
        return False

@fetch_module_data_api.route('/fetch_module', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)  # Pass READ_ACCESS_TYPE as an argument
def fetch_module():
    authorization_header = request.headers.get('Authorization')
    try:
        company, instance, dbuser, mydb, appuser, appuserid, user_info, employee_info = get_user_and_db_details(authorization_header)
    except ValueError as e:
        logger.error(f"Failed to get user details for authorization header: {e}")
        return jsonify({"error": str(e)}), 401
        
    if not appuser:
        logger.error(f"{appuser} --> {__name__}: Unauthorized access attempt: Username not found.")
        return jsonify({"error": "Unauthorized. Username not found."}), 401
    
    logger.debug(f"{appuser} --> {__name__}: Entered the fetch module names data function")

    try:
        folders = get_module_names(appuser, __name__)
        if store_module_names(folders, appuserid, __name__, mydb, appuser):
            logger.debug(f"{appuser} --> {__name__}: Successfully inserted modules into the database.")
            return jsonify({'message': f'{appuser} --> {__name__}: The modules were inserted in DB successfully.'}), 200
        else:
            logger.error(f"{appuser} --> {__name__}: Failed to insert modules into DB.")
            return jsonify({'message': f'{appuser} --> {__name__}: Failed to insert modules in DB.'}), 500
    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: An error occurred while processing the request: {e}")
        return jsonify({'message': f'{appuser} --> {__name__}: An error occurred while processing the request.'}), 500
    finally:
        mydb.close()
        logger.debug(f"{appuser} --> {__name__}: Closed the database connection.")
