from flask import Blueprint, jsonify, request, current_app,request
import os
from modules.security.permission_required import permission_required  # Import the decorator
from config import READ_ACCESS_TYPE
from modules.utilities.logger import logger  # Import the logger module
from modules.security.routines.get_user_and_db_details import get_user_and_db_details

fetch_appl_modules_api = Blueprint('fetch_appl_modules_api', __name__)
load_appl_modules_api =  Blueprint('load_appl_modules_api', __name__)

@fetch_appl_modules_api.route('/fetch_application_modules', methods=['GET'])
@permission_required(READ_ACCESS_TYPE ,  __file__)  # Pass READ_ACCESS_TYPE as an argument
def fetch_application_module():
    authorization_header = request.headers.get('Authorization')
    try:
        company, instance, dbuser, mydb, appuser, appuserid, user_info, employee_info = get_user_and_db_details(authorization_header)
    except ValueError as e:
        return jsonify({"error": str(e)}), 401
        
    if not appuser:
        return jsonify({"error": "Unauthorized. Username not found."}), 401
    
    logger.debug(f"{appuser} --> {__name__}: Entered in the fetch application module data function")    
    print("Inside fetch_application_module")
    module_names = get_module_names_from_react_app(__name__,appuser)
    response = {
        "modules": module_names
    }
    mydb.close()
    return jsonify(response)

@load_appl_modules_api.route('/load_application_modules', methods=['POST'])
def load_application_modules():
    authorization_header = request.headers.get('Authorization')
    try:
        company, instance, dbuser, mydb, appuser, appuserid, user_info, employee_info = get_user_and_db_details(authorization_header)
    except ValueError as e:
        return jsonify({"error": str(e)}), 401
        
    if not appuser:
        return jsonify({"error": "Unauthorized. Username not found."}), 401
    
    logger.debug(f"{appuser} --> {__name__}: Entered in the load application modules function")     
    try:
        modules = request.json.get('modules')
        drop_and_create_table(__name__,mydb)  # Drop and create table if needed
        store_modules_in_db(modules,__name__,mydb)
        return jsonify({'message': 'Modules inserted successfully.'})
    except Exception as e:
        return jsonify({'error': 'An error occurred while inserting modules.'}), 500
    finally:
        mydb.close()

def get_module_names_from_react_app(__name__,appuser):
    root_directory = current_app.root_path
    logger.debug(f"{appuser} --> {__name__}: Inside get mdoule names fuction current APP", {current_app})
    logger.debug(f"{appuser} --> {__name__}: inside get module and root directory ", {root_directory})      
    # modules_path = os.path.join(root_directory, 'src', 'modules')
    modules_path = os.path.join(root_directory)
    module_names = []
    logger.debug(f"{appuser} --> {__name__}: Module Path ", {modules_path})
    logger.debug(f"{appuser} --> {__name__}: Current working directory: ", {os.getcwd()})    

    if os.path.exists(modules_path):
        for module_name in os.listdir(modules_path):
            module_names.append(module_name)
    else:
        logger.debug(f"{appuser} --> {__name__}: Module Path doesn't exists ", {modules_path})

    logger.debug(f"{appuser} --> {__name__}: Module Names ", {module_names})    

    return module_names

def drop_and_create_table(__name__, mydb):
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

def store_modules_in_db(modules,__name__,mydb):
    mycursor = mydb.cursor()

    for module_name in modules:
        sql = "INSERT INTO adm.views (fe_module) VALUES (%s)"
        values = (module_name,)
        mycursor.execute(sql, values)

    mydb.commit()
    mycursor.close()
