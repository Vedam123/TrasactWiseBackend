from flask import request, jsonify
from modules.security.check_user_permissions import check_user_permissions
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger  # Import the logger module

def check_module_and_token(current_file_name, module, access_type, connect_db, appuser, appuserid):
    # No need to call get_user_and_db_details here, as appuser, appuserid, and connect_db are passed as arguments
    
    if not appuser:
        logger.error(f"{appuser} --> {__name__}: The user {appuser} is Unauthorized to access the file  --> {current_file_name}: from the module {module}")
        return jsonify({"error": f"The user {appuser} is Unauthorized to access the file --> {current_file_name}: from the module {module}"}), 401  

    logger.debug(f"{appuser} --> {__name__}: The App user {appuser} is not empty , now try to find if he has access to the module {module} ")

    has_permission = check_user_permissions(current_file_name,appuserid, appuser, module, access_type, connect_db)
    
    if has_permission:
        logger.debug(f"{appuser} --> {__name__}: The user {appuser} is authorized to access the file  --> {current_file_name}: from the module {module}")
        return has_permission

    logger.error(f"{appuser} --> {__name__}: The user {appuser} is Unauthorized to access the file  --> {current_file_name}: from the module {module}")
    return False

