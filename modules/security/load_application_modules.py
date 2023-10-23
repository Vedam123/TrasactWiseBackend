from flask import Blueprint, jsonify, request, current_app,request
import os
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required  # Import the decorator
from config import READ_ACCESS_TYPE  # Import READ_ACCESS_TYPE
#from configure_logging import configure_logging
from modules.security.get_user_from_token import get_user_from_token

# Get a logger for this module
#logger = configure_logging()

fetch_appl_modules_api = Blueprint('fetch_appl_modules_api', __name__)
load_appl_modules_api =  Blueprint('load_appl_modules_api', __name__)

@fetch_appl_modules_api.route('/fetch_application_modules', methods=['GET'])
@permission_required(READ_ACCESS_TYPE ,  __file__)  # Pass READ_ACCESS_TYPE as an argument
def fetch_application_module():
    # MODULE_NAME = __name__ 
    # token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None
    # USER_ID = token_results['username']
    # logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the fetch application module data function")    
    print("Inside fetch_application_module")
    module_names = get_module_names_from_react_app()
    response = {
        "modules": module_names
    }
    return jsonify(response)

@load_appl_modules_api.route('/load_application_modules', methods=['POST'])
def load_application_modules():
    try:
        modules = request.json.get('modules')
        drop_and_create_table()  # Drop and create table if needed
        store_modules_in_db(modules)
        return jsonify({'message': 'Modules inserted successfully.'})
    except Exception as e:
        return jsonify({'error': 'An error occurred while inserting modules.'}), 500

def get_module_names_from_react_app():
    root_directory = current_app.root_path
    print("Inside get mdoule names fuction current APP", current_app, )
    print("inside get module and root directory ",root_directory)
   # modules_path = os.path.join(root_directory, 'src', 'modules')
    modules_path = os.path.join(root_directory)
    module_names = []
    print("Module path ", modules_path)
    print("Current working directory:", os.getcwd())


    if os.path.exists(modules_path):
        for module_name in os.listdir(modules_path):
            module_names.append(module_name)
    else:
        print("Path does not exist:", modules_path)


    print("mdoule names ", module_names)

    return module_names

def drop_and_create_table():
    mydb = get_database_connection()  # Assuming you have a function to get the database connection
    mycursor = mydb.cursor()

    # Drop the table if it exists
    mycursor.execute("DROP TABLE IF EXISTS adm.views")

    # Create the table again
    mycursor.execute("""
        CREATE TABLE adm.views (
            id INT PRIMARY KEY AUTO_INCREMENT,
            fe_module VARCHAR(100) NOT NULL UNIQUE
        ) AUTO_INCREMENT = 20;
    """)

    mydb.commit()
    mycursor.close()
    mydb.close()

def store_modules_in_db(modules):
    mydb = get_database_connection()  # Assuming you have a function to get the database connection
    mycursor = mydb.cursor()

    for module_name in modules:
        sql = "INSERT INTO adm.views (fe_module) VALUES (%s)"
        values = (module_name,)
        mycursor.execute(sql, values)

    mydb.commit()
    mycursor.close()
    mydb.close()
