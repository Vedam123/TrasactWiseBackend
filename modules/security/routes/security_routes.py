from flask import Blueprint, jsonify, json
from modules.security.create_role import create_role
from modules.security.login_user import login, profile, generate_password_hash
from modules.security.refresh_token import refresh_token
from modules.security.get_new_token import get_new_token
from modules.security.logout_user import logout
from modules.security.register_user import register
from modules.security.create_user_role import create_user_role
from modules.security.list_users import list_users
from modules.security.list_permissions import list_permissions
from modules.security.create_permissions import create_permissions
from modules.security.delete_user_modules import delete_user_modules
from modules.security.list_roles import list_roles
from modules.security.list_user_roles import list_user_roles
from modules.security.list_modules import list_modules
from modules.security.load_application_modules import load_application_modules
from modules.security.load_application_modules import fetch_application_module
from modules.security.load_modules import fetch_module
from datetime import datetime, timedelta, timezone
from flask_jwt_extended import create_access_token, get_jwt, get_jwt_identity, unset_jwt_cookies, jwt_required, JWTManager
from modules.utilities.logger import logger  # Import the logger module

get_user_roles_routes = Blueprint('get_user_roles_routes', __name__)
post_user_roles_routes = Blueprint('post_user_roles_routes', __name__)
put_user_roles_routes = Blueprint('put_user_roles_routes', __name__)
delete_user_roles_routes = Blueprint('delete_user_roles_routes', __name__)

# POST methods ----------------------------------------------------
@post_user_roles_routes.route('/register_user', methods=['POST'])
def register_user():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the register_user route")
    return register()

@post_user_roles_routes.route('/create_role', methods=['POST'])
def create_role_data():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the create_role_data route")
    return create_role()

@post_user_roles_routes.route('/create_user_role', methods=['POST'])
def create_user_role_data():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the create_user_role_data route")
    return create_user_role()

@post_user_roles_routes.route('/login_user', methods=['POST'])
def login_user():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the login_user route")
    return login()

@post_user_roles_routes.route('/refresh_token', methods=['POST'])
def refresh_login_token():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the refresh_login_token route")
    return refresh_token()

@post_user_roles_routes.route('/get_new_token', methods=['GET'])
def get_new_access_token():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the refresh_login_token route")
    print("new access token creation function is called")
    return get_new_token()

@post_user_roles_routes.route('/generate_password_hash', methods=['POST'])
def generate_password_hash_user():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the generate_password_hash_user route")
    return generate_password_hash()

@post_user_roles_routes.route('/logout_user', methods=['POST'])
def logout_user():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the logout_user route")
    return logout()

@post_user_roles_routes.route('/create_permissions', methods=['POST'])
def create_user_permissions():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the create_user_permissions route")
    return create_permissions()

@post_user_roles_routes.route('/load_application_modules', methods=['POST'])
def load_appl_modules():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the load_appl_modules route")
    return load_application_modules()

# GET methods ----------------------------------------------------
@get_user_roles_routes.route('/my_profile', methods=['GET'])
def my_profile():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the my_profile route")
    return profile()

@get_user_roles_routes.route('/list_users', methods=['GET'])
def list_users_data():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the list_users_data route")
    return list_users()

@get_user_roles_routes.route('/list_roles', methods=['GET'])
def list_roles_data():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the list_roles_data route")
    return list_roles()

@get_user_roles_routes.route('/list_user_roles', methods=['GET'])
def list_user_roles_data():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the list_user_roles_data route")
    return list_user_roles()

@get_user_roles_routes.route('/list_user_permissions', methods=['GET'])
def list_user_permissions():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the list_user_permissions route")
    return list_permissions()

@get_user_roles_routes.route('/list_modules', methods=['GET'])
def list_modules_data():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the list_modules_data route")
    return list_modules()

@get_user_roles_routes.route('/fetch_folder', methods=['GET'])
def fetch_backend_folders():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the fetch_backend_folders route")
    return fetch_module()

@get_user_roles_routes.route('/fetch_application_modules', methods=['GET'])
def fetch_frontend_folders():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the fetch_frontend_folders route")
    return fetch_application_module()

# DELETE methods ----------------------------------------------------
@delete_user_roles_routes.route('/delete_user_modules', methods=['DELETE'])
def delete_user_module():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the delete_user_module route")
    return delete_user_modules()

def register_security_routes(app):
    app.register_blueprint(get_user_roles_routes)
    app.register_blueprint(post_user_roles_routes)
    app.register_blueprint(put_user_roles_routes)
    app.register_blueprint(delete_user_roles_routes)

