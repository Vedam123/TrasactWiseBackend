from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required  # Import the decorator
from config import WRITE_ACCESS_TYPE    # Import WRITE_ACCESS_TYPE

create_role_data_api = Blueprint('create_role_data_api', __name__)

@create_role_data_api.route('/create_role', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE ,  __file__)  # Pass WRITE_ACCESS_TYPE as an argument
def create_role():
    mydb = get_database_connection()

    # Retrieve role data from the request
    role_name = request.json.get('name', None)
    role_description = request.json.get('description', None)

    if role_name is None:
        return jsonify({'error': 'Role name must be provided'}), 400

    # Create the role in the database
    query = "INSERT INTO adm.roles (name, description) VALUES (%s, %s)"
    values = (role_name, role_description)  # Assuming no description is provided in the request
    mycursor = mydb.cursor()
    mycursor.execute(query, values)
    mydb.commit()

        # Close the cursor and connection
    mycursor.close()
    mydb.close()

    # Return success message
    return jsonify({'message': 'Role created successfully'})
