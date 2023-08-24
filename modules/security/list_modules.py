from flask import Blueprint, jsonify
from modules.admin.databases.mydb import get_database_connection

list_modules_api = Blueprint('list_modules_api', __name__)

@list_modules_api.route('/list_modules', methods=['GET'])
def list_modules():
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
