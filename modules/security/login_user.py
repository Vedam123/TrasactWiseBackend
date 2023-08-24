from flask import Blueprint, jsonify, request,current_app
import bcrypt, json
from datetime import datetime, timedelta, timezone
from modules.admin.databases.mydb import get_database_connection
from flask_jwt_extended import create_access_token,get_jwt,get_jwt_identity, \
                               unset_jwt_cookies, jwt_required, JWTManager

from config import JWT_ACCESS_TOKEN_EXPIRES, APPLICATION_CREDENTIALS

login_data_api = Blueprint('login_data_api', __name__)

@login_data_api.route('/login', methods=['POST'])
def login():
    username = request.json.get("username", None)
    password = request.json.get("password", None)

    print("Username Arrived to login function ", username)
    print("Password Arrived to login function ", password)

    # Check if the provided username and password match any entry in USERNAME_PASSWORD_PAIRS
    for user_info in APPLICATION_CREDENTIALS:
        if user_info["username"] == username and bcrypt.checkpw(
            password.encode('utf-8'), user_info["password"].encode('utf-8')
        ):
            # Passwords match, generate and return a session token or JWT
            print("The User is in the Password Pair list in the config file : credential are matched",int(user_info["userid"]))
            access_token = create_access_token(
                identity=username, expires_delta=current_app.config["JWT_ACCESS_TOKEN_EXPIRES"]
            )
            return jsonify({
                "access_token": access_token,
                "username" : username,
                "userid" : int(user_info["userid"])
            })

    # If the username-password pair is not found in the array, check the database
    print("The User is not in the Password Pair list in the config file : credential will be checked in the db")
    mydb = get_database_connection()
    query = "SELECT username, password, emailid, empid,id FROM adm.users WHERE username = %s"
    values = (username,)
    mycursor = mydb.cursor()
    mycursor.execute(query, values)
    result = mycursor.fetchone()

    if result:
        stored_username = result[0]
        stored_password = result[1]
        emailid = result[2]
        empid = result[3]
        userid=result[4]

        if bcrypt.checkpw(password.encode('utf-8'), stored_password.encode('utf-8')):
            # Passwords match, generate and return a session token or JWT
            print("Config JWT ACCESS TOKEN EXPIRE TIME : ", JWT_ACCESS_TOKEN_EXPIRES)
            access_token = create_access_token(
                identity=stored_username, expires_delta=current_app.config["JWT_ACCESS_TOKEN_EXPIRES"]
            )
            return jsonify({
                "access_token": access_token,
                "username" : stored_username,
                "userid" : userid 
            })

    # Close the cursor and connection
    mycursor.close()
    mydb.close()
    # Invalid credentials
    return jsonify({'error': 'Invalid username or password'}), 401

@login_data_api.route('/profile', methods=['GET'])
@jwt_required()
def profile():
    response_body = {
        "name": "Vedam",
        "about" :"Hello! I'm a full stack developer that loves python and javascript"
    }

    return response_body

@login_data_api.route('/generate_password_hash', methods=['POST'])
def generate_password_hash():
    username = request.json.get("username", None)
    plaintext_password = request.json.get("plaintext_password", None)

    print("Username Arrived to login function ", username)
    print("Password Arrived to login function ", plaintext_password)

    # Generate a new random salt
    salt = bcrypt.gensalt()

    # Hash the plaintext password using the generated salt
    hashed_password = bcrypt.hashpw(plaintext_password.encode('utf-8'), salt)

    return jsonify({"hashed_password": hashed_password.decode('utf-8')})
