from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required  # Import the decorator
from config import READ_ACCESS_TYPE  # Import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger  # Import the logger module

list_roles_api = Blueprint('list_roles_api', __name__)

@list_roles_api.route('/roles', methods=['GET'])
@permission_required(READ_ACCESS_TYPE ,  __file__)  # Pass READ_ACCESS_TYPE as an argument
def list_roles():
    authorization_header = request.headers.get('Authorization')
    token_results = ""
    USER_ID = ""
    MODULE_NAME = __name__
    if authorization_header:
        token_results = get_user_from_token(authorization_header)

    if token_results:
        USER_ID = token_results["username"]    
    token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the list roles data function")    
    mydb = get_database_connection(USER_ID, MODULE_NAME)

    # Retrieve all roles from the database
    query = "SELECT * FROM adm.roles"
    mycursor = mydb.cursor()
    mycursor.execute(query)
    roles = mycursor.fetchall()

    # Convert the role data into a list of dictionaries
    role_list = []
    for data in roles:
        role_dict = {
            'id': data[0],
            'name': data[1],
            'description': data[2],
            'created_at': data[3].strftime('%Y-%m-%d %H:%M:%S'),
            'updated_at': data[4].strftime('%Y-%m-%d %H:%M:%S')
        }
        role_list.append(role_dict)
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Retrieved role data: {role_dict}")

    # Close the cursor and connection
    mycursor.close()
    mydb.close()
    
    # Return the list of roles as JSON response
    return jsonify({'roles': role_list})
