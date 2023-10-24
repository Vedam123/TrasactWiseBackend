from flask import request, jsonify
from flask_jwt_extended import decode_token
from modules.security.check_user_permissions import check_user_permissions
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger  # Import the logger module

def check_module_and_token(current_file_name, module, access_type):
    authorization_header = request.headers.get('Authorization')
    token_results = ""
    USER_ID = ""
    current_user_id = ""
    MODULE_NAME = __name__
    if authorization_header:
        token_results = get_user_from_token(authorization_header)

    if token_results:
        current_user_id = token_results["current_user_id"]
        USER_ID = token_results["username"]

    if module:
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: The file '{current_file_name}' is in the module '{module}' and requested access is '{access_type}'.")
    else:
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: The file '{current_file_name}' was not found in any module and requested access is '{access_type}'.")

    authorization_header = request.headers.get('Authorization')   
   
    
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the Check module token function")
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: TOKEN user and current user IN MODULE TOKEN: {USER_ID}, {current_user_id}")

    has_permission = check_user_permissions(current_user_id, USER_ID, module, access_type)
    
    if has_permission:
        return has_permission

    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Seems the user doesn't have permissions")
    return False
