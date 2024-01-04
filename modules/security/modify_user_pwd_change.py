from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
import bcrypt
from modules.security.permission_required import permission_required
from config import UPDATE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger
from datetime import datetime

modify_user_api = Blueprint('update_user_api', __name__)

@modify_user_api.route('/modify_user_pwd_change', methods=['PUT'])
def modify_user_pwd_change():
    MODULE_NAME = __name__
    
    # Extract parameters from the request
    user_id = request.json.get('id')
    password = request.json.get('password')
    status = request.json.get('status')
    identifier = request.json.get('identifier')  # 'identifier' can be empid, emailid, or username

    logger.debug(f"User ID to update: {user_id}")
    logger.debug(f"User password: {password}")
    logger.debug(f"Status to update: {status}")
    logger.debug(f"Identifier: {identifier}")

    # Check if at least one parameter is provided for the update
    if not user_id:
        error_message = 'User ID is required for the update'
        logger.error(error_message)
        return jsonify({'error': error_message}), 400

    mydb = get_database_connection(identifier, MODULE_NAME)

    # Prepare the update query and values
    update_query = "UPDATE adm.users SET "
    update_values = []

    # Check if password is provided for the update
    if password is not None and password != "":
        # Hash the password before updating
        hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())
        update_query += "password = %s, "
        update_values.append(hashed_password)

    # Add other fields to the SET condition
    update_query += "updated_by = %s WHERE "
    update_values.append(user_id)

    # Add the WHERE conditions based on the identifier
    if identifier.isdigit():  # Check if it's a numeric value (empid)
        update_query += "empid = %s "
        update_values.append(identifier)
    elif '@' in identifier:  # Check if it's an email address (emailid)
        update_query += "emailid = %s "
        update_values.append(identifier)
    else:  # Default to username
        update_query += "username = %s "
        update_values.append(identifier)

    # Add other fields to the WHERE condition
    update_query += "AND id = %s AND status = %s AND (expiry_date IS NULL OR expiry_date >= %s)"
    update_values.extend([user_id, status, datetime.now().strftime('%Y-%m-%d')])

    logger.debug(f"Update Query: {update_query}")
    logger.debug(f"Update Values: {update_values}")

    print(f"Update Query: {update_query}")
    print(f"Update Values: {update_values}")

    # Execute the update query
    mycursor = mydb.cursor()
    abc = mycursor.execute(update_query, tuple(update_values))
    mydb.commit()
    print(mycursor.rowcount)
    # Check if any rows were affected (indicating a successful update)
# Check if any rows were affected (indicating a successful update)
    if mycursor.rowcount > 0:
        response = {'message': 'User information updated successfully'}
        logger.debug(response['message'])
        mycursor.close()
        mydb.close()
        return jsonify(response), 200  # 200 OK for success
    else:
        error_message = 'No user found with the provided ID and conditions for update'
        logger.error(error_message)
        response = {'error': error_message}
        mycursor.close()
        mydb.close()
        return jsonify(response), 500

