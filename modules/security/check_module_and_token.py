# module_token_checker.py
from flask import request,jsonify
from flask_jwt_extended import decode_token
from modules.security.check_user_permissions import check_user_permissions  # Import the check_permission function

def check_module_and_token(current_file_name, module,access_type):
    if module:
        print(f"The file '{current_file_name}' is in the module  '{module}' and requested access is '{access_type}'.")
    else:
        print(f"The file '{current_file_name}' was not found in any module and requested access is '{access_type}'.")

    token = request.headers.get('Authorization')
    token_data = ""
    token_user = ""
    print("Received Token --> ", token)
    if token:
        token = token.replace('Bearer ', '')  # Remove 'Bearer ' prefix
        try:
            token_data = decode_token(token)
            print("Decoded Token Data -- full--> ", token_data)
            token_user = token_data.get('sub')
            current_user_id = token_data.get('Userid')
            print("Decoded User id-->", current_user_id)
        except Exception as e:
            print("Error decoding token:", str(e))
    has_permission = check_user_permissions(current_user_id, token_user, module, access_type)
    if has_permission:
        return has_permission

    print("Seems user don't have permissions ")
    return False
