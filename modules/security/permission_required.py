from functools import wraps
from flask import jsonify, request
from modules.security.find_file_folder import find_file_folder
from modules.security.check_module_and_token import check_module_and_token
from modules.utilities.logger import logger  # Import the logger module
from modules.security.routines.get_user_and_db_details import get_user_and_db_details

def permission_required(access_type, calling_file_name):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):

            authorization_header = request.headers.get('Authorization')

            appuser = "Unknown User"  # Assign a default value to appuser

            try:
                company, instance, dbuser, connect_db, appuser, appuserid, user_info, employee_info = get_user_and_db_details(authorization_header)
                logger.debug(f"{appuser} --> {__name__}: Retrieved data from user {appuser} and userid {appuserid}")
            except ValueError as e:
                logger.error(f"{appuser} --> {__name__}: Authorization failed for {appuser} --> {__name__}: {str(e)}")
                return jsonify({"error": str(e)}), 401
            
            if not appuser:
                logger.error(f"{appuser} --> {__name__}: Unauthorized access attempt with missing appuser --> {__name__}: Username not found in the request")
                return jsonify({"error": "Unauthorized. Username not found."}), 401  
            
            
            module = find_file_folder(calling_file_name)
            logger.debug(f"{appuser} --> {__name__}: The file {calling_file_name} is in the Module --> {module}")
            logger.debug(f"{appuser} --> {__name__}: Checking if the user {appuser} has {access_type} access to the Module --> {module}")

            try:
                # Check if the module and token are valid
                if check_module_and_token(calling_file_name, module, access_type, connect_db,appuser, appuserid):
                    logger.debug(f"{appuser} --> {__name__}: Permission granted for {calling_file_name} to access {module} with access type {access_type}")
                    return func(*args, **kwargs)
                else:
                    logger.warning(f"{appuser} --> {__name__}: Permission denied for {calling_file_name} to access {module} with access type {access_type}")
                    return jsonify({'message': f'Permission denied for {calling_file_name} to access {module}'}), 403
            finally:
                # Ensure the database connection is closed after function execution
                if connect_db:
                    connect_db.close()
                    logger.debug(f"{appuser} --> {__name__}: Database connection closed after permission check")

        return wrapper
    return decorator
