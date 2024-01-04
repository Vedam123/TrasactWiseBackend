from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
import bcrypt
from modules.security.permission_required import permission_required
from config import UPDATE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

modify_user_api = Blueprint('update_user_api', __name__)

@modify_user_api.route('/modify_user', methods=['PUT'])
@permission_required(UPDATE_ACCESS_TYPE, __file__)
def modify_user():
    MODULE_NAME = __name__
    currentuserid = decode_token(request.headers.get('Authorization', '').replace('Bearer ', '')).get('Userid') if request.headers.get('Authorization', '').startswith('Bearer ') else None
    token = request.headers.get('Authorization', '').replace('Bearer ', '')
    logger.debug(f"Received token: {token}")

    # Add this line to print or log the actual token content
    print(currentuserid)
    print(UPDATE_ACCESS_TYPE)
    print( __file__)

    token_info = decode_token(token)
    logger.debug(f"Decoded token information: {token_info}")

    currentuserid = token_info.get('Userid') if token_info else None
    logger.debug(f"Current User ID: {currentuserid}")

    # Extract parameters from the request
    user_id = request.json.get('id')
    email_id = request.json.get('emailid')
    password = request.json.get('password')  # Add password to update
    status = request.json.get('status')  # Add status to update
    expiry_date = request.json.get('expiry_date')  # Add expiry_date to update
    expiry_date = None if expiry_date == "" else expiry_date

    logger.debug(f"Current User ID: {currentuserid}")
    logger.debug(f"User ID to update: {user_id}")
    logger.debug(f"Email ID to update: {email_id}")
    logger.debug(f"Password to update: {password}")
    logger.debug(f"Status to update: {status}")
    logger.debug(f"Expiry Date to update: {expiry_date}")

    # Check if at least one parameter is provided for the update
    if not user_id:
        error_message = 'User ID is required for the update'
        logger.error(error_message)
        return jsonify({'error': error_message}), 400

    mydb = get_database_connection(currentuserid, MODULE_NAME)

    # Prepare the update query and values
    update_query = "UPDATE adm.users SET "
    update_values = []

    if email_id is not None:
        if email_id != "":
            update_query += "emailid = %s, "
            update_values.append(email_id)

    if password is not None:
        if password != "":
            # Hash the password before updating
            hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())
            update_query += "password = %s, "
            update_values.append(hashed_password)

    if status is not None:
        if status != "":
            update_query += "status = %s, "
            update_values.append(status)

    if expiry_date is not None:
        if expiry_date != "":
            update_query += "expiry_date = %s, "
            update_values.append(expiry_date)

    # Check if there are fields to update
    if not update_values:
        error_message = 'No fields provided for update'
        logger.error(error_message)
        return jsonify({'error': error_message}), 400

    # Add the common fields for update (updated_by and updated_at)
    update_query += "updated_by = %s, updated_at = NOW() WHERE id = %s"
    update_values.extend([currentuserid, user_id])

    logger.debug(f"Update Query: {update_query}")
    logger.debug(f"Update Values: {update_values}")

    # Execute the update query
    mycursor = mydb.cursor()
    mycursor.execute(update_query, tuple(update_values))
    mydb.commit()

    # Check if any rows were affected (indicating a successful update)
    if mycursor.rowcount > 0:
        response = {'message': 'User information updated successfully'}
        logger.debug(response['message'])
    else:
        error_message = 'No user found with the provided ID for update'
        logger.error(error_message)
        response = {'error': error_message}

    # Close the cursor and connection
    mycursor.close()
    mydb.close()

    return jsonify(response)
