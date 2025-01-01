from flask import Blueprint, jsonify, request
import bcrypt
from modules.security.permission_required import permission_required
from config import UPDATE_ACCESS_TYPE
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.utilities.logger import logger

modify_user_api = Blueprint('update_user_api', __name__)

@modify_user_api.route('/modify_user', methods=['PUT'])
@permission_required(UPDATE_ACCESS_TYPE, __file__)
def modify_user():

    authorization_header = request.headers.get('Authorization')

    try:
        company, instance, dbuser, mydb, appuser, appuserid, user_info, employee_info = get_user_and_db_details(authorization_header)
    except ValueError as e:
        return jsonify({"error": str(e)}), 401
        
    if not appuser:
        return jsonify({"error": "Unauthorized. Username not found."}), 401

    # Extract parameters from the request
    user_id = request.json.get('id')
    email_id = request.json.get('emailid')
    password = request.json.get('password')  # Add password to update
    status = request.json.get('status')  # Add status to update
    expiry_date = request.json.get('expiry_date')  # Add expiry_date to update
    expiry_date = None if expiry_date == "" else expiry_date

    logger.debug(f"Current User ID: {appuserid}")
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

    update_query += "expiry_date = %s, "
    update_values.append(expiry_date)

    # Check if there are fields to update
    if not update_values:
        error_message = 'No fields provided for update'
        logger.error(error_message)
        return jsonify({'error': error_message}), 400

    # Add the common fields for update (updated_by and updated_at)
    update_query += "updated_by = %s, updated_at = NOW() WHERE id = %s"
    update_values.extend([appuserid, user_id])

    logger.debug(f"{appuser} --> {__name__}: Update Query: {update_query}")   
    logger.debug(f"{appuser} --> {__name__}: Update values: {update_values}")  


    # Execute the update query
    mycursor = mydb.cursor()
    mycursor.execute(update_query, tuple(update_values))
    mydb.commit()

    # Check if any rows were affected (indicating a successful update)
    if mycursor.rowcount > 0:
        response = {'message': 'User information updated successfully'}
        logger.debug(f"{appuser} --> {__name__}: Successful: {response}") 
    else:
        error_message = 'No user found with the provided ID for update'
        logger.error(f"{appuser} --> {__name__}: Update failed: {error_message}") 
        response = {'error': error_message}

    # Close the cursor and connection
    mycursor.close()
    mydb.close()

    return jsonify(response)
