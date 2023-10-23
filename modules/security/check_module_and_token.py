# module_token_checker.py
from flask import request,jsonify
from flask_jwt_extended import decode_token
from modules.security.check_user_permissions import check_user_permissions  # Import the check_permission function
##from configure_logging import configure_logging
from modules.security.get_user_from_token import get_user_from_token

# Get a logger for this module
##logger = configure_logging()

def check_module_and_token(current_file_name, module,access_type):
    if module:
        print(f"The file '{current_file_name}' is in the module  '{module}' and requested access is '{access_type}'.")
    else:
        print(f"The file '{current_file_name}' was not found in any module and requested access is '{access_type}'.")

    authorization_header = request.headers.get('Authorization')
    token_results = ""
    USER_ID = ""
    current_user_id = ""
    if authorization_header:
        token_results=get_user_from_token(authorization_header)

    if token_results:
        current_user_id = token_results["current_user_id"]
        USER_ID = token_results["username"]
    
  ##  logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the Check module token function")
    print(USER_ID,current_user_id,"--> TOKEN user and current user IN MODULE TOKEN ")
    has_permission = check_user_permissions(current_user_id, USER_ID, module, access_type)
    if has_permission:
        return has_permission

    print("Seems user don't have permissions ")
    return False
