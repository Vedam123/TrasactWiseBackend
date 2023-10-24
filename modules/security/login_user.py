from flask import Blueprint, jsonify, request, current_app
import bcrypt
import json
import base64
from datetime import datetime, timedelta, timezone
from modules.admin.databases.mydb import get_database_connection
from flask_jwt_extended import create_access_token, create_refresh_token, get_jwt, get_jwt_identity, \
    unset_jwt_cookies, jwt_required, JWTManager
from modules.security.permission_required import permission_required  # Import the decorator
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger  # Import the logger module

from config import JWT_ACCESS_TOKEN_EXPIRES, APPLICATION_CREDENTIALS, JWT_REFRESH_TOKEN_EXPIRES

login_data_api = Blueprint('login_data_api', __name__)

@login_data_api.route('/login', methods=['POST'])
@login_data_api.route('/login', methods=['POST'])
def login():
    MODULE_NAME = __name__
  
    username = request.json.get("username", None)
    password = request.json.get("password", None)

    logger.debug(f"{MODULE_NAME}: Username Arrived to login function: {username}")
    logger.debug(f"{MODULE_NAME}: Password Arrived to login function")

    # Check if the provided username and password match any entry in USERNAME_PASSWORD_PAIRS
    for user_info in APPLICATION_CREDENTIALS:
        if user_info["username"] == username and bcrypt.checkpw(
            password.encode('utf-8'), user_info["password"].encode('utf-8')
        ):
            userid = user_info["userid"]
            # Passwords match, generate and return a session token or JWT
            logger.debug(f"{MODULE_NAME}: The User is in the Password Pair list in the config file: credentials are matched")
            access_token = create_access_token(
                identity=username, additional_claims={"Userid": userid}, expires_delta=current_app.config["JWT_ACCESS_TOKEN_EXPIRES"]
            )

            refresh_token = create_refresh_token(
                identity=username, additional_claims={"Userid": userid},
                expires_delta=JWT_REFRESH_TOKEN_EXPIRES
            )

            logger.debug(f"{MODULE_NAME}: Application user details: {username}, {userid}, {access_token}")
            logger.debug(f"{MODULE_NAME}: Refresh Token: {refresh_token}")

            return jsonify({
                "access_token": access_token,
                "refresh_token": refresh_token,
                "username": username,
                "userid": int(user_info["userid"]),
                "empid": 0,
                "name": user_info["name"],
                "emp_img": "None"
            })
    # If the username-password pair is not found in the array, check the database
    logger.debug(f"{MODULE_NAME}: The User is not in the Password Pair list in the config file: credentials will be checked in the db")
    mydb = get_database_connection(username,MODULE_NAME)
    query = "SELECT username, password, emailid, empid, id FROM adm.users WHERE username = %s"
    values = (username,)
    logger.debug(f"{MODULE_NAME}: User name is used to fetch db: {username}")
    mycursor = mydb.cursor()
    mycursor.execute(query, values)
    result = mycursor.fetchone()

    if result:
        stored_username = result[0]
        logger.debug(f"{MODULE_NAME}: Stored user name: {stored_username}")
        stored_password = result[1]
        emailid = result[2]
        empid = result[3]
        userid = result[4]

        if bcrypt.checkpw(password.encode('utf-8'), stored_password.encode('utf-8')):
            # Passwords match, generate and return a session token or JWT
            logger.debug(f"{MODULE_NAME}: Config JWT ACCESS TOKEN EXPIRE TIME: {JWT_ACCESS_TOKEN_EXPIRES}")
            access_token = create_access_token(
                identity=stored_username, additional_claims={"Userid": userid}, expires_delta=current_app.config["JWT_ACCESS_TOKEN_EXPIRES"]
            )

            refresh_token = create_refresh_token(
                identity=username, additional_claims={"Userid": userid},
                expires_delta=JWT_REFRESH_TOKEN_EXPIRES
            )
            logger.debug(f"{MODULE_NAME}: Stored user details: {access_token}, {stored_username}, {userid}")
            logger.debug(f"{MODULE_NAME}: Refresh Token: {refresh_token}")

            query1 = "SELECT name, pic FROM com.employee WHERE empid = %s"
            values = (int(empid),)
            mycursor1 = mydb.cursor()
            mycursor1.execute(query1, values)
            result1 = mycursor1.fetchone()
            logger.debug(f"{MODULE_NAME}: Input Employee id is: {empid}")
            fetched_name = result1[0]
            fetched_image = result1[1]
            if isinstance(fetched_image, bytes):
                pic = base64.b64encode(fetched_image).decode('utf-8')
            else:
                pic = "None"
            mycursor1.close()

            if fetched_name:
                return jsonify({
                    "access_token": access_token,
                    "refresh_token": refresh_token,
                    "username": stored_username,
                    "userid": userid,
                    "empid": empid,
                    "name": fetched_name,
                    "emp_img": pic 
                })
            else:
                # Handle the case when result1 is not truthy
                return jsonify({
                    "access_token": access_token,
                    "refresh_token": refresh_token,
                    "username": stored_username,
                    "userid": userid,
                    "empid": empid,
                    "name": "NO NAME IN DB",
                    "emp_img": pic 
                })
    # Close the cursor and connection
    mycursor.close()
    mydb.close()
    # Invalid credentials
    logger.warning(f"{MODULE_NAME}: Invalid username or password")
    return jsonify({'error': 'Invalid username or password'}), 401

@login_data_api.route('/profile', methods=['GET'])
@jwt_required()
def profile():
    MODULE_NAME = __name__ 
    logger.debug(f"{MODULE_NAME}: Entered in the profile function")       
    response_body = {
        "name": "Vedam",
        "about": "Hello! I'm a full stack developer that loves python and javascript"
    }
    return response_body

@login_data_api.route('/generate_password_hash', methods=['POST'])
def generate_password_hash():
    MODULE_NAME = __name__ 
    logger.debug(f"{MODULE_NAME}: Entered in the generate password hash function")       
    username = request.json.get("username", None)
    plaintext_password = request.json.get("plaintext_password", None)
    
    logger.debug(f"{MODULE_NAME}: Username Arrived to generate password hash function: {username}")

    # Generate a new random salt
    salt = bcrypt.gensalt()

    # Hash the plaintext password using the generated salt
    hashed_password = bcrypt.hashpw(plaintext_password.encode('utf-8'), salt)

    return jsonify({"hashed_password": hashed_password.decode('utf-8')})
