from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
import bcrypt
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger  # Import the logger module

register_data_api = Blueprint('register_data_api', __name__)

@register_data_api.route('/register', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def register():
    MODULE_NAME = __name__
    currentuserid = decode_token(request.headers.get('Authorization', '').replace('Bearer ', '')).get('Userid') if request.headers.get('Authorization', '').startswith('Bearer ') else None
    username = request.json['username']
    password = request.json['password']
    logger.debug(f"Current User ID: {currentuserid}")
    logger.debug(f"Username: {username}")
    logger.debug("Before select statement: " + str(request.json['empid']))

    if 'emailid' in request.json:
        emailid = request.json['emailid']
    else:
        emailid = None

    if 'empid' in request.json:
        empid = request.json['empid']
    elif 'empid' in request.form:
        empid = request.form['empid']
    else:
        empid = None

    logger.debug(f"Email ID: {emailid}")
    logger.debug(f"Emp ID: {empid}")

    # Hash and store the user's password securely in the database
    hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())

    mydb = get_database_connection(username,MODULE_NAME)

    # Save the user data to the database
    # Assuming you have a 'users' table with columns 'username', 'password', 'empid', and 'emailid'
    query = "INSERT INTO adm.users (username, password, empid, emailid, created_by, updated_by) VALUES (%s, %s, %s, %s, %s, %s)"
    values = (username, hashed_password, empid, emailid, currentuserid, currentuserid)
    mycursor = mydb.cursor()
    mycursor.execute(query, values)
    mydb.commit()

    # Return success message along with username, empid, and emailid
    response = {
        'message': 'Registration successful',
        'username': username,
        'empid': empid,
        'emailid': emailid
    }

    # Close the cursor and connection
    mycursor.close()
    mydb.close()

    logger.debug("Registration successful")
    return jsonify(response)
