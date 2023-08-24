from flask import Blueprint, jsonify
from modules.admin.databases.mydb import get_database_connection

list_permissions_api = Blueprint('list_permissions_api', __name__)

@list_permissions_api.route('/list_module_permissions', methods=['GET'])
def list_permissions():
    mydb = get_database_connection()

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
        
    # Close the cursor and connection
    mycursor.close()
    mydb.close()
    # Return the list of user module permissions as JSON response
    return jsonify({'user_module_permissions': user_module_permissions_list})
