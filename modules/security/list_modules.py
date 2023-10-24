from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger  # Import the logger module

list_modules_api = Blueprint('list_modules_api', __name__)

@list_modules_api.route('/list_modules', methods=['GET'])
def list_modules():
    authorization_header = request.headers.get('Authorization')
    token_results = ""
    USER_ID = ""
    MODULE_NAME = __name__
    if authorization_header:
        token_results = get_user_from_token(authorization_header)

    if token_results:
        USER_ID = token_results["username"]
    token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None
    
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the list modules function")
    mydb = get_database_connection(USER_ID, MODULE_NAME)

    # Retrieve all modules from the database
    query = "SELECT * FROM adm.modules"
    mycursor = mydb.cursor()
    mycursor.execute(query)
    modules = mycursor.fetchall()

    # Convert the module data into a list of dictionaries
    modules_list = []
    for data in modules:
        module_dict = {
            'id': data[0],
            'folder_name': data[1]
        }
        modules_list.append(module_dict)

    # Close the cursor and connection
    mycursor.close()
    mydb.close()

    # Return the list of modules as JSON response
    return jsonify({'modules': modules_list})
