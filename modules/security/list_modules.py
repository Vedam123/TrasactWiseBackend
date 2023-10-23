from flask import Blueprint, jsonify,request
from modules.admin.databases.mydb import get_database_connection
#from configure_logging import configure_logging
from modules.security.get_user_from_token import get_user_from_token

# Get a logger for this module
#logger = configure_logging()

list_modules_api = Blueprint('list_modules_api', __name__)

@list_modules_api.route('/list_modules', methods=['GET'])
def list_modules():
    
    #MODULE_NAME = __name__ 
    #token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None
    #USER_ID = token_results['username']
    #logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the list modules function")
    mydb = get_database_connection()

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
