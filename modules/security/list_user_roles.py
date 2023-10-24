from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required  # Import the decorator
from config import READ_ACCESS_TYPE  # Import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger  # Import the logger module

list_user_roles_api = Blueprint('list_user_roles_api', __name__)

@list_user_roles_api.route('/user_roles', methods=['GET'])
@permission_required(READ_ACCESS_TYPE ,  __file__)  # Pass READ_ACCESS_TYPE as an argument
def list_user_roles():
    authorization_header = request.headers.get('Authorization')
    token_results = ""
    USER_ID = ""
    MODULE_NAME = __name__
    if authorization_header:
        token_results = get_user_from_token(authorization_header)

    if token_results:
        USER_ID = token_results["username"]   
    token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the list user roles function")    
    mydb = get_database_connection(USER_ID, MODULE_NAME)
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Latest User roles code is running")

    # Retrieve all user roles from the database
    query = """
    SELECT ur.id, ur.user_id, u.username, ur.role_id, r.name as role_name, ur.Assigned_At
    FROM adm.user_roles ur
    INNER JOIN adm.users u ON ur.user_id = u.id
    INNER JOIN adm.roles r ON ur.role_id = r.id
    """
    mycursor = mydb.cursor()
    mycursor.execute(query)
    user_roles = mycursor.fetchall()
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Retrieved user roles data: {user_roles}")

    # Convert the user role data into a list of dictionaries with all the fields
    user_role_list = []
    for user_role in user_roles:
        role_entry = {
            'id': user_role[0],
            'user_id': user_role[1],
            'username': user_role[2],
            'role_id': user_role[3],
            'role_name': user_role[4],
            'Assigned_At': user_role[5].strftime('%Y-%m-%d %H:%M:%S')
        }
        user_role_list.append(role_entry)

    # Close the cursor and connection
    mycursor.close()
    mydb.close()
    
    # Return the list of user roles as JSON response
    return jsonify({'user_roles': user_role_list})
