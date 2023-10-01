from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required  # Import the decorator
from config import WRITE_ACCESS_TYPE    # Import WRITE_ACCESS_TYPE

create_permission_api = Blueprint('create_permission_api', __name__)

@create_permission_api.route('/create_permissions', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE ,  __file__)  # Pass WRITE_ACCESS_TYPE as an argument
def create_permissions():
    mydb = get_database_connection()
    permissions = request.json
    print(permissions)
    if not permissions:
        return jsonify({'error': 'No permissions data provided'}), 400

    for permission in permissions:
        user_id = permission.get('user_id', None)
        module = permission.get('module', None)
        print("user_id, module", user_id, module)
        read_permission = permission.get('read_permission', False)
        write_permission = permission.get('write_permission', False)
        update_permission = permission.get('update_permission', False)
        delete_permission = permission.get('delete_permission', False)
        if user_id is None or module is None:
            return jsonify({'error': 'user_id and module must be provided'}), 400
        
        # Check if the provided user_id and module combination exists in the database
        query = "SELECT * FROM adm.user_module_permissions WHERE user_id = %s AND module = %s"
        mycursor = mydb.cursor()
        mycursor.execute(query, (user_id, module))
        existing_permission = mycursor.fetchone()
        if existing_permission:
            # If the combination exists, update the existing row
            print("User is already there so updating")
            query = "UPDATE adm.user_module_permissions SET read_permission = %s, write_permission = %s, update_permission = %s, delete_permission = %s WHERE user_id = %s AND module = %s"
            values = (read_permission, write_permission, update_permission, delete_permission, user_id, module)
            mycursor.execute(query, values)
            mydb.commit()
        else:
            # If the combination does not exist, insert a new row
            print("User is not there there so inserting")
            query = "INSERT INTO adm.user_module_permissions (user_id, module, read_permission, write_permission, update_permission, delete_permission) VALUES (%s, %s, %s, %s, %s, %s)"
            values = (user_id, module, read_permission, write_permission, update_permission, delete_permission)
            mycursor.execute(query, values)
            mydb.commit()

        # Close the cursor
        mycursor.close()

    # Close the connection
    mydb.close()

    # Return success message
    return jsonify({'message': 'User module permissions created/updated successfully'})
