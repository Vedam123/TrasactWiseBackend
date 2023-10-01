from functools import wraps
from flask import request, jsonify
from modules.security.find_file_folder import find_file_folder
from modules.security.check_module_and_token import check_module_and_token

def permission_required(access_type, calling_file_name):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            module = find_file_folder(calling_file_name)
            if check_module_and_token(calling_file_name, module, access_type):
                return func(*args, **kwargs)
            else:
                return jsonify({'message': 'Permission denied'}), 403
        return wrapper
    return decorator
