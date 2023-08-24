from flask import jsonify, Blueprint,json
from modules.security.create_role import create_role
#from modules.security.login_user import login, profile,refresh_expiring_jwts
from modules.security.login_user import login, profile,generate_password_hash
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
from modules.security.load_modules import fetch_module
from datetime import datetime, timedelta, timezone
from flask_jwt_extended import create_access_token,get_jwt,get_jwt_identity, \
                               unset_jwt_cookies, jwt_required, JWTManager
from modules.security.load_application_modules import fetch_application_module, load_application_modules

get_user_roles_routes= Blueprint('get_user_roles_routes', __name__)
post_user_roles_routes= Blueprint('post_user_roles_routes', __name__)
put_user_roles_routes= Blueprint('put_user_roles_routes', __name__)
delete_user_roles_routes= Blueprint('delete_user_roles_routes', __name__)


# POST methods ----------------------------------------------------
@post_user_roles_routes.route('/register_user', methods=['POST'])
def register_user():
    print("User is going to be registered")
    return register()

@post_user_roles_routes.route('/create_role', methods=['POST'])
def create_role_data():
    print("Role is going to be registered")
    return create_role()

@post_user_roles_routes.route('/create_user_role', methods=['POST'])
def create_user_role_data():
    print("User Role is  going to be Created")
    return create_user_role()

@post_user_roles_routes.route('/login_user', methods=['POST'])
def login_user():
    print("User is going to be Logged in")
    return login()

@post_user_roles_routes.route('/generate_password_hash', methods=['POST'])
def generate_password_hash_user():
    print("Password Hash is going to be Generated in")
    return generate_password_hash()

@post_user_roles_routes.route('/logout_user', methods=['POST'])
def logout_user():
    print("User is going to be Logged out")
    return logout()

@post_user_roles_routes.route('/create_permissions', methods=['POST'])
def create_user_permissions():
    print("User Permissions are going to be updated")
    return create_permissions()

@post_user_roles_routes.route('/load_application_modules', methods=['POST'])
def load_appl_modules():
    print("Load application Modules to DB")
    return load_application_modules()

# GET methods ----------------------------------------------------

@get_user_roles_routes.route('/my_profile', methods=['GET'])
def my_profile():
    print("User Profile is going to be retrieved")
    return profile()

@get_user_roles_routes.route('/list_users', methods=['GET'])
def list_users_data():
    print("Users are going to be retrieved")
    return list_users()

@get_user_roles_routes.route('/list_roles', methods=['GET'])
def list_roles_data():
    print("Roles are going to be retrieved")
    return list_roles()

@get_user_roles_routes.route('/list_user_roles', methods=['GET'])
def list_user_roles_data():
    print("User Roles are going to be retrieved")
    return list_user_roles()

@get_user_roles_routes.route('/list_user_permissions', methods=['GET'])
def list_user_permissions():
    print("User Permissions are going to be listed")
    return list_permissions()

@get_user_roles_routes.route('/list_modules', methods=['GET'])
def list_modules_data():
    print("Modules  are going to be retrieved")
    return list_modules()

@get_user_roles_routes.route('/fetch_folder', methods=['GET'])
def fetch_backend_folders():
    print("Fetch folders from python application and store them")
    return fetch_module()

@get_user_roles_routes.route('/fetch_application_modules', methods=['GET'])
def fetch_frontend_folders():
    print("Fetch folders from react JS application")
    return fetch_application_module()


# DELETE methods ----------------------------------------------------

@delete_user_roles_routes.route('/delete_user_modules', methods=['DELETE'])
def delete_user_module():
    print("User Modules are going to be deleted from the perimissions table")
    return delete_user_modules()

#@login_user_route.after_request
def refresh_expiring_jwts(response):
    try:
        exp_timestamp = get_jwt()["exp"]
        now = datetime.now(timezone.utc)
        target_timestamp = datetime.timestamp(now + timedelta(seconds=30))
        print("refresh_expiring_jwts called", response)
        if target_timestamp > exp_timestamp:
            print("New target time is going to be set REFRESH is called")
            access_token = create_access_token(identity=get_jwt_identity())
            data = response.get_json()
            if type(data) is dict:
                data["access_token"] = access_token 
                response.data = json.dumps(data)
        return response
    except (RuntimeError, KeyError):
        # Case where there is not a valid JWT. Just return the original respone
        return response

def register_security_routes(app):
    app.register_blueprint(get_user_roles_routes)
    app.register_blueprint(post_user_roles_routes)
    app.register_blueprint(put_user_roles_routes)
    app.register_blueprint(delete_user_roles_routes)
    
    app.after_request(refresh_expiring_jwts)


