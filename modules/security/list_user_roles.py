from flask import Blueprint, jsonify
from modules.admin.databases.mydb import get_database_connection

list_user_roles_api = Blueprint('list_user_roles_api', __name__)

@list_user_roles_api.route('/user_roles', methods=['GET'])
def list_user_roles():
    mydb = get_database_connection()
    print("Latest User roles code is running")

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
