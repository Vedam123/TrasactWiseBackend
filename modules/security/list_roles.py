from flask import Blueprint, jsonify
from modules.admin.databases.mydb import get_database_connection

list_roles_api = Blueprint('list_roles_api', __name__)

@list_roles_api.route('/roles', methods=['GET'])
def list_roles():
    mydb = get_database_connection()

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
   
    # Close the cursor and connection
    mycursor.close()
    mydb.close()
    
    # Return the list of roles as JSON response
    return jsonify({'roles': role_list})
