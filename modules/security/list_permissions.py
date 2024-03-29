from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger  # Import the logger module

list_permissions_api = Blueprint('list_permissions_api', __name__)

@list_permissions_api.route('/list_module_permissions', methods=['GET'])
def list_permissions():
    authorization_header = request.headers.get('Authorization')
    token_results = ""
    USER_ID = ""
    MODULE_NAME = __name__
    if authorization_header:
        token_results = get_user_from_token(authorization_header)

    if token_results:
        USER_ID = token_results["username"]

    token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the list permissions data function")
    
    # Get user_id from the query parameter
    user_id = request.args.get('user_id')
    
    mydb = get_database_connection(USER_ID, MODULE_NAME)

    # Retrieve user module permissions based on user_id if provided
    if user_id:
        query = "SELECT * FROM adm.user_module_permissions WHERE user_id = %s"
        mycursor = mydb.cursor()
        mycursor.execute(query, (user_id,))
    else:
        # Retrieve all user module permissions from the database
        query = "SELECT * FROM adm.user_module_permissions"
        mycursor = mydb.cursor()
        mycursor.execute(query)

    user_module_permissions = mycursor.fetchall()

    # Convert the user module permissions data into a list of dictionaries
    user_module_permissions_list = []
    for data in user_module_permissions:
        user_module_permissions_dict = {
            'id': data[0],
            'user_id': data[1],
            'module': data[2],
            'read_permission': bool(data[3]),
            'write_permission': bool(data[4]),
            'update_permission': bool(data[5]),
            'delete_permission': bool(data[6])
        }
        user_module_permissions_list.append(user_module_permissions_dict)
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Retrieved user module permissions: {user_module_permissions_dict}")
        
    # Close the cursor and connection
    mycursor.close()
    mydb.close()
    
    # Return the list of user module permissions as JSON response
    return jsonify({'user_module_permissions': user_module_permissions_list})
