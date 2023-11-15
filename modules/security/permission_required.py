from functools import wraps
from flask import request, jsonify
from modules.security.find_file_folder import find_file_folder
from modules.security.check_module_and_token import check_module_and_token
from modules.utilities.logger import logger  # Import the logger module

def permission_required(access_type, calling_file_name):
    def decorator(func):
        @wraps(func)
        def wrapper(*args, **kwargs):
            module = find_file_folder(calling_file_name)
            MODULE_NAME = __name__
            logger.debug(f"{MODULE_NAME}: Calling {calling_file_name} from module {MODULE_NAME} with access type {access_type}")
            print("Inside permisison required function ",access_type,calling_file_name)
            if check_module_and_token(calling_file_name, module, access_type):
                return func(*args, **kwargs)
            else:
                logger.warning(f"{MODULE_NAME}: Permission denied for {func.__name__} from module {MODULE_NAME}")
                return jsonify({'message': 'Permission denied'}), 403
        return wrapper
    return decorator
