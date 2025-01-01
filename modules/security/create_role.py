from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required  # Import the decorator
from config import WRITE_ACCESS_TYPE    # Import WRITE_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger  # Import the logger module
from modules.security.routines.get_user_and_db_details import get_user_and_db_details

create_role_data_api = Blueprint('create_role_data_api', __name__)

@create_role_data_api.route('/create_role', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE ,  __file__)  # Pass WRITE_ACCESS_TYPE as an argument
def create_role():
    authorization_header = request.headers.get('Authorization')

    try:
        company, instance, dbuser, mydb, appuser, appuserid, user_info, employee_info = get_user_and_db_details(authorization_header)
    except ValueError as e:
        return jsonify({"error": str(e)}), 401
    
    if not appuserid:
        return jsonify({"error": "Unauthorized. Application user id" + {appuserid} + "not found."}), 401
    
    if not appuser:
        return jsonify({"error": "Unauthorized. Application user " + {appuser} + "not found."}), 401

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
