from flask import Blueprint, jsonify, request
import bcrypt
import datetime
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.utilities.logger import logger  # Import the logger module

register_data_api = Blueprint('register_data_api', __name__)

@register_data_api.route('/register', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)  # This will invoke permission check
def register():
    authorization_header = request.headers.get('Authorization')
    logger.debug(f"Authorization header received: {authorization_header}")

    try:
        # Logging to check where the connection might be closed prematurely
        logger.debug(f"{__name__}: Attempting to retrieve user and database details")
        company, instance, dbuser, mydb, appuser, appuserid, user_info, employee_info = get_user_and_db_details(authorization_header)
        logger.debug(f"{appuser} --> {__name__}: User and DB details retrieved successfully")

    except ValueError as e:
        logger.error(f"{__name__}: Authorization failed for {appuser} --> {str(e)}")
        return jsonify({"error": str(e)}), 401

    if not appuser:
        logger.error(f"{appuser} --> {__name__}: Unauthorized access attempt - Username not found.")
        return jsonify({"error": "Unauthorized. Username not found."}), 401

    # Process request data
    username = request.json['username']
    password = request.json['password']
    logger.debug(f"{appuser} --> {__name__}: Retrieved username: {username}")
    
    logger.debug(f"{appuser} --> {__name__}: Before Select statement - Empid: {str(request.json.get('empid'))}")

    emailid = request.json.get('emailid', None)
    empid = request.json.get('empid') or request.form.get('empid', None)

    logger.debug(f"{appuser} --> {__name__}: Email ID: {emailid}, Emp ID: {empid}")
    
    # Hash the password before storing it
    hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())
    logger.debug(f"{appuser} --> {__name__}: Hashed password for the user {appuser}, Emp ID: {hashed_password}")
    # Retrieve fields from the request JSON
    status_value = request.json.get('status_value')
    start_date_value = request.json.get('start_date_value')
    expiry_date_value = request.json.get('expiry_date_value')

    # Prepare query to insert user into the database
    query = "INSERT INTO adm.users (username, password, empid, emailid, status, start_date, expiry_date, created_by, updated_by) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)"
    values = (username, hashed_password, empid, emailid, status_value, start_date_value, expiry_date_value, appuserid, appuserid)

    try:
        mycursor = mydb.cursor()
        logger.debug(f"{appuser} --> {__name__}: Executing Insert Query: {query}")
        mycursor.execute(query, values)
        mydb.commit()
        logger.debug(f"{appuser} --> {__name__}: User registration successful for {username}")
    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Database error occurred during registration: {str(e)}")
        return jsonify({"error": str(e)}), 500
    finally:
        # Close cursor and DB connection after execution
        mycursor.close()
        mydb.close()
        logger.debug(f"{appuser} --> {__name__}: Database connection closed after successful registration")

    # Prepare response
    response = {
        'message': 'Registration successful',
        'username': username,
        'empid': empid,
        'emailid': emailid
    }

    return jsonify(response)
