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

from config import JWT_ACCESS_TOKEN_EXPIRES, APPLICATION_CREDENTIALS

login_data_api = Blueprint('login_data_api', __name__)
JWT_REF_TOKEN_EXPIRES = timedelta(days=7)

@staticmethod
def get_user_info(username,mydb,active_status):
    print(username,active_status)
    query = "SELECT username, password, emailid, empid, id FROM adm.users WHERE username = %s and status = %s"
    values = (username,active_status,)
    try:
        with mydb.cursor() as mycursor:
            mycursor.execute(query, values)
            return mycursor.fetchone()
    except Exception as e:
        logger.error(f"An Error occuered in selecting data from adm.users table: {e}")
        return jsonify({'message': 'An Error occuered in selecting data from adm.users table:'}), 500
    finally:
        mycursor.close()

@staticmethod
def fetch_employee_details(empid,mydb):
    query = "SELECT name, pic FROM com.employee WHERE empid = %s"
    values = (int(empid),)
    try:
        with mydb.cursor() as mycursor:
            mycursor.execute(query, values)
            return mycursor.fetchone()
    except Exception as e:
        logger.error(f"An Error occuered in selecting data from com.employee table: {e}")
        return jsonify({'message': 'An Error occuered in selecting data from com.employee table:'}), 500
    finally:
        mycursor.close()    

@login_data_api.route('/login', methods=['POST'])
def login():
    MODULE_NAME = __name__
    username = request.json.get("username", None)
    password = request.json.get("password", None)
    instance = request.json.get("instance", None)
    active_status = request.json.get("name", None)

    print("Instance name sent from front end",instance)

    try:
        user_info = next(
            (info for info in APPLICATION_CREDENTIALS
             if info["username"] == username and info["status"] == active_status and bcrypt.checkpw(password.encode('utf-8'), info["password"].encode('utf-8'))),
            None
        )
        print("User Info",user_info)
        if user_info:
            expires_in_seconds = int(current_app.config["JWT_ACCESS_TOKEN_EXPIRES"].total_seconds())

            access_token = create_access_token(
                identity=username, additional_claims={"Userid": user_info["userid"], "expires_in": expires_in_seconds}
            )

            refresh_token = create_refresh_token(
                identity=username, additional_claims={"Userid": user_info["userid"], "expires_in": JWT_REF_TOKEN_EXPIRES.total_seconds()}
            )

            logger.debug(f"{MODULE_NAME}: Token Expires Delta: {expires_in_seconds}")
            logger.debug(f"{MODULE_NAME}: Refresh Expires Delta: {int(JWT_REF_TOKEN_EXPIRES.total_seconds())}")

            return jsonify({
                "access_token": access_token,
                "refresh_token": refresh_token,
                "username": username,
                "userid": int(user_info["userid"]),
                "empid": 0,
                "name": user_info["name"],
                "emp_img": "None",
                "token_expires_delta": expires_in_seconds,
                "refresh_token_expires_delta": int(JWT_REF_TOKEN_EXPIRES.total_seconds())
            })
        else:
            print("Entered in else condition")
            mydb = get_database_connection(username,MODULE_NAME)
            result = get_user_info(username,mydb,active_status)
            print("Result db",result)

            if result:
                stored_username, stored_password, emailid, empid, userid = result

                if bcrypt.checkpw(password.encode('utf-8'), stored_password.encode('utf-8')):
                    expires_in_seconds = int(current_app.config["JWT_ACCESS_TOKEN_EXPIRES"].total_seconds())
                    logger.debug(f"{MODULE_NAME}: Config JWT ACCESS TOKEN EXPIRE TIME: {JWT_ACCESS_TOKEN_EXPIRES}")

                    access_token = create_access_token(
                        identity=username, additional_claims={"Userid": userid, "expires_in": expires_in_seconds}
                    )

                    refresh_token = create_refresh_token(
                        identity=username, additional_claims={"Userid": userid, "expires_in": JWT_REF_TOKEN_EXPIRES.total_seconds()}
                    )

                    logger.debug(f"{MODULE_NAME}: Token Expires Delta: {expires_in_seconds}")
                    logger.debug(f"{MODULE_NAME}: Refresh Expires Delta: {int(JWT_REF_TOKEN_EXPIRES.total_seconds())}")

                    result1 = fetch_employee_details(empid,mydb)

                    fetched_name, fetched_image = result1[0], result1[1]

                    pic = base64.b64encode(fetched_image).decode('utf-8') if isinstance(fetched_image, bytes) else "None"
                    mydb.close()
                    return jsonify({
                        "access_token": access_token,
                        "refresh_token": refresh_token,
                        "username": stored_username,
                        "userid": userid,
                        "empid": empid,
                        "name": fetched_name or "NO NAME IN DB",
                        "emp_img": pic,
                        "token_expires_delta": expires_in_seconds,
                        "refresh_token_expires_delta": int(JWT_REF_TOKEN_EXPIRES.total_seconds())
                    })
            mydb.close()
    except Exception as e:
        logger.error(f"{MODULE_NAME}: An error occurred - {str(e)}")

    return jsonify({'error': 'Invalid username or password'}), 401

@login_data_api.route('/profile', methods=['GET'])
@jwt_required()
def profile():
    MODULE_NAME = __name__
    logger.debug(f"{MODULE_NAME}: Entered in the profile function")
    username = request.json.get("username", None)
    response_body = {
        "name": {username},
        "about": "Hello! You are an employee of this organization to access the Application"
    }
    return response_body

@login_data_api.route('/generate_password_hash', methods=['POST'])
def generate_password_hash():
    MODULE_NAME = __name__
    username = request.json.get("username", None)
    plaintext_password = request.json.get("plaintext_password", None)

    logger.debug(f"{MODULE_NAME}: Username Arrived to generate password hash function: {username}")

    salt = bcrypt.gensalt()
    hashed_password = bcrypt.hashpw(plaintext_password.encode('utf-8'), salt)

    return jsonify({"hashed_password": hashed_password.decode('utf-8')})
