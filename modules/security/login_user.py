import os
import configparser
from flask import Blueprint, jsonify, request, current_app
import bcrypt
import base64
from datetime import timedelta
from modules.admin.databases.mydb import get_database_connection
from flask_jwt_extended import create_access_token, create_refresh_token, get_jwt, jwt_required
from modules.utilities.logger import logger  # Import the logger module
from config import  APPLICATION_CREDENTIALS
from config import DB_INSTANCES_BASE_PATH

login_data_api = Blueprint('login_data_api', __name__)
JWT_REF_TOKEN_EXPIRES = timedelta(days=7)

@staticmethod
def get_user_info(username, mydb, appuserstatus):
    print("Received status",username, appuserstatus)
    query = "SELECT username, password, emailid, empid, id, status, start_date, expiry_date FROM adm.users WHERE username = %s and status = %s"
    values = (username, appuserstatus,)

    try:
        with mydb.cursor() as mycursor:
            mycursor.execute(query, values)
            result = mycursor.fetchone()
            if result is None:
                logger.error(f"No data found for username {username} with status {appuserstatus}")
                return None  # Or handle it as needed
            # Ensure the result has 5 expected columns
            if len(result) != 8:
                logger.error(f"Unexpected result format: {result}. Expected 8 columns.")
                return None  # Or handle it as needed
            return result
    except Exception as e:
        logger.error(f"An error occurred while querying adm.users table: {e}")
        return None
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

# Helper function to read .instance.cnf file
def read_instance_cnf(company, instance):
    db_instance_path = os.path.join(DB_INSTANCES_BASE_PATH, company, "system", "db_instances")
    instance_folder = os.path.join(db_instance_path, instance)

    if not os.path.isdir(instance_folder):
        raise FileNotFoundError(f"Instance folder for {instance} not found.")
    
    config_file_path = os.path.join(instance_folder, ".instance.cnf")
    if not os.path.exists(config_file_path):
        raise FileNotFoundError(f".instance.cnf file not found for {instance}.")

    config = configparser.ConfigParser()
    config.read(config_file_path)

    user = config.get('client', 'user').strip()
    host = config.get('client', 'host').strip()
    port = config.getint('client', 'port')
    password = config.get('client', 'password').strip()

    return user,host, port, password


@login_data_api.route('/login', methods=['POST'])
def login():
    MODULE_NAME = __name__
    # Get input values
    company = request.json.get("company", None)
    instance = request.json.get("instance", None)
    appuser = request.json.get("username", None)
    password = request.json.get("password", None)
    appuserstatus = request.json.get("status", None)

    print(appuser,password,appuserstatus,instance,company)

    try:
        # Check for user in APPLICATION_CREDENTIALS
        user_info = next(
            (info for info in APPLICATION_CREDENTIALS
            if info["username"] == appuser and 
                info["status"].lower() == appuserstatus.lower() and  # Cast both to lowercase
                bcrypt.checkpw(password.encode('utf-8'), info["password"].encode('utf-8'))),
            None
        )
        print("Entered in Application user block of login_user API",user_info)

        if user_info:
            expires_in_seconds = int(current_app.config["JWT_ACCESS_TOKEN_EXPIRES"].total_seconds())
            print("Entered in user info IF")

            userid = int(user_info['userid'])
            #appuser = user_info['username']
            name = user_info['name']
            status = user_info['status']
            pwd = user_info['password']

            access_token = create_access_token(
                identity=appuser, 
                additional_claims={
                    "Userid": userid,
                    "empid":userid,
                    "username": appuser,
                    "name":name,
                    "expires_in": expires_in_seconds,
                    "password": pwd,      
                    "appuserstatus": status,  
                    "instance": instance,      
                    "company": company,
                    "emailid": None         
                }
            )

            # Create refresh token
            refresh_token = create_refresh_token(
                identity=appuser, 
                   additional_claims={
                    "Userid": userid,
                    "empid":userid,
                    "username": appuser,
                    "name":name,
                    "expires_in": expires_in_seconds,
                    "password": pwd,      
                    "appuserstatus": status,  
                    "instance": instance,      
                    "company": company,
                    "emailid": None            
                }
            )

            return jsonify({
                "access_token": access_token,
                "refresh_token": refresh_token,
                "username": appuser,
                "appuserstatus": status, 
                "userid": userid,
                "empid": userid,
                "name": name,
                "emp_img": "None",
                "token_expires_delta": expires_in_seconds,
                "refresh_token_expires_delta": int(JWT_REF_TOKEN_EXPIRES.total_seconds()),
                "instance": instance,      
                "company": company,
                "emailid": None        
            })

        else:
            print(" User is not in application users ", appuser, password, appuserstatus, instance, company)
            if company and instance:
                try:
                    # Read instance configuration for company and instance
                    user, host, port, instance_password = read_instance_cnf(company, instance)

                    print("Fetched user details DB user for the instance", user, host, port, instance_password)
                    print("Entered User details ", appuser, password, appuserstatus, instance, company)

                    # Connect to the database using the instance credentials
                    mydb = get_database_connection(user, MODULE_NAME, host, port, instance_password,appuser)

                    # Fetch the encrypted password from the database for the user
                    print("Before result comparision of get user info")
                    print(appuser,appuserstatus )
                    result = get_user_info(appuser, mydb, appuserstatus)
                    print("Result ",result)
                    if result:
                        print(f"Query result: {result}")  # Debug the query result
                        dbusername, dbpassword, dbemailid, dbempid, dbid ,db_status,db_start_dt,db_exp_dt= result
                        # Continue with processing
                    else:
                        print(f"Failed to fetch user info for {appuser}")


                    dbname, dbpic = fetch_employee_details(dbempid, mydb)
                    #pic = base64.b64encode(dbpic).decode('utf-8') if isinstance(dbname, bytes) else "None"
                    pic = base64.b64encode(dbpic).decode('utf-8') if isinstance(dbpic, bytes) else "None"

                    print("Password sent ",password)
                    print("Password fetched ",dbpassword)
                    #print("Image Vedam --> ",pic)

                    if result:
                        # Decrypt the password fetched from the database (assuming it's encrypted with bcrypt or any other method)

                        if bcrypt.checkpw(password.encode('utf-8'), dbpassword.encode('utf-8')):
                            print("Both the passwords match")

                            # Proceed with generating JWT tokens
                            expires_in_seconds = int(current_app.config["JWT_ACCESS_TOKEN_EXPIRES"].total_seconds())
                            access_token = create_access_token(
                                identity=dbusername, 
                                    additional_claims={
                                        "Userid": dbid,
                                        "empid":dbempid,
                                        "username": dbusername,
                                        "name":dbname,
                                        "expires_in": expires_in_seconds,
                                        "password": dbpassword,      
                                        "appuserstatus": db_status,  
                                        "instance": instance,      
                                        "company": company,
                                        "emailid": dbemailid         
                                        }
                            )

                            refresh_token = create_refresh_token(
                                identity=dbusername, 
                                    additional_claims={
                                        "Userid": dbid,
                                        "empid":dbempid,
                                        "username": dbusername,
                                        "name":dbname,
                                        "expires_in": expires_in_seconds,
                                        "password": dbpassword,      
                                        "appuserstatus": db_status,  
                                        "instance": instance,      
                                        "company": company,
                                        "emailid": dbemailid         
                                        }
                            )

                            # Fetch employee details
                            print("before returning json")
                            mydb.close()                  
                            return jsonify({
                                "access_token": access_token,
                                "refresh_token": refresh_token,
                                "username": dbusername,
                                "appuserstatus": db_status,                                 
                                "userid": dbid,
                                "empid": dbempid,
                                "name": dbname,
                                "emp_img": pic,
                                "token_expires_delta": expires_in_seconds,
                                "refresh_token_expires_delta": int(JWT_REF_TOKEN_EXPIRES.total_seconds()),
                                "instance": instance,      
                                "company": company,
                                "emailid": dbemailid        
                            })                

                        else:
                            # Passwords do not match
                            print("Invalid password")
                            return jsonify({"error": "Invalid password"}), 401

                    else:
                        # User not found
                        print("User not found or account is not active.")
                        return jsonify({"error": "User not found or account is inactive"}), 401

                except FileNotFoundError as e:
                    logger.error(f"Error reading .instance.cnf file: {str(e)}")
                    return jsonify({'error': 'Invalid company or instance information'}), 400
                except Exception as e:
                    logger.error(f"An error occurred while processing login: {str(e)}")
                    return jsonify({'error': 'An error occurred during login'}), 500

            return jsonify({'error': 'Invalid username or password'}), 401

    except Exception as e:
        logger.error(f"{MODULE_NAME}: An error occurred - {str(e)}")
        return jsonify({'error': 'An error occurred during the login process'}), 500

@login_data_api.route('/profile', methods=['GET'])
@jwt_required()
def profile():
    MODULE_NAME = __name__
    logger.debug(f"{MODULE_NAME}: Entered in the profile function")

    # Get the entire JWT claim (including the identity and additional claims)
    jwt_claims = get_jwt()

    # Extract values from the JWT claims
    appuser = jwt_claims.get("username", "Not Available")
    password = jwt_claims.get("password", "Not Available")
    password_from_jwt = password.strip()  # Strip whitespace if needed
    appuserstatus = jwt_claims.get("appuserstatus", "Not Available")
    instance = jwt_claims.get("instance", "Not Available")
    company = jwt_claims.get("company", "Not Available")
    emailid = jwt_claims.get("emailid", "Not Available") 

    logger.debug(f"JWT Claims: {jwt_claims}")
    logger.debug(f"Username: {appuser}")
    logger.debug(f"Password: {password}")
    logger.debug(f"Active Status: {appuserstatus}")
    logger.debug(f"Instance: {instance}")
    logger.debug(f"Company: {company}")

    # Print the values of the JWT claims
    print(f"Username from JWT: {appuser}")
    print(f"Password from JWT: {password}")
    print(f"Active Status from JWT: {appuserstatus}")
    print(f"Instance from JWT: {instance}")
    print(f"Company from JWT: {company}")
    print(f"Email ID from JWT: {emailid}")

    try:
        # Check if the user exists in APPLICATION_CREDENTIALS
        user_info = next(
            (info for info in APPLICATION_CREDENTIALS
            if info["username"] == appuser and 
                info["status"].lower() == appuserstatus.lower() and  # Cast both to lowercase
                bcrypt.checkpw(password.encode('utf-8'), info["password"].encode('utf-8'))),
            None
        )

        if user_info:
            # Verify the password (assuming bcrypt is used for password hashing)
            if bcrypt.checkpw(password.encode('utf-8'), user_info["password"].encode('utf-8')):
                logger.debug(f"User {appuser} found in APPLICATION_CREDENTIALS. Password verified.")

                # If user is active and credentials match, return user info
                return jsonify({
                    "username": appuser,
                    "user_id": user_info["userid"],
                    "status": appuserstatus,
                    "instance": instance,
                    "company": company
                })
            else:
                logger.debug(f"Password mismatch for user {appuser} in APPLICATION_CREDENTIALS.")
                return jsonify({"error": "Invalid password"}), 401

        else:
            # User not found in APPLICATION_CREDENTIALS, now check the database
            logger.debug(f"User {appuser} not found in APPLICATION_CREDENTIALS, checking in the database.")

            if company and instance:
                try:
                    # Read instance configuration for company and instance
                    user, host, port, instance_password = read_instance_cnf(company, instance)

                    # Connect to the database using the instance credentials
                    mydb = get_database_connection(user, MODULE_NAME, host, port, instance_password)

                    print("db connected successfully ", appuser, appuserstatus)

                    # Fetch the encrypted password from the database for the user
                    result = get_user_info(appuser, mydb, appuserstatus)

                    print("get user info called  ", result)   

      

                    if result:
                        # Unpack the result to get the stored password (which is encrypted)
                        stored_username, encrypted_password, emailid, empid, userid, db_status, db_start_dt, db_exp_dt = result
                        print("DB PWD ",encrypted_password)
                        print("Password ",password)
                        password = password.strip()  # Strip leading/trailing whitespaces from the user-provided password
                        #password = "welcome"
                        encrypted_password = encrypted_password.strip()  # Strip from database password
                        # Verify password match
                        #if bcrypt.checkpw(password_from_jwt.encode('utf-8'), encrypted_password.encode('utf-8')):
                        logger.debug(f"User {appuser} found in the database. Password verified.")
                        print("Both passwords match.")
                        # Fetch employee details
                        result1 = fetch_employee_details(empid, mydb)
                        fetched_name, fetched_image = result1[0], result1[1]
                        pic = base64.b64encode(fetched_image).decode('utf-8') if isinstance(fetched_image, bytes) else "None"
                        # Close the DB connection
                        mydb.close()
                        # Return the profile details
                        return jsonify({
                            "username": stored_username,
                            "user_id": userid,
                            "empid": empid,
                            "name": fetched_name or "No Name in DB",
                            "emailid": emailid,
                            "emp_img": pic,
                            "status": appuserstatus,
                            "instance": instance,
                            "company": company
                        })

                        #else:
                        #    logger.debug(f"Password mismatch for user {username} in the database.")
                        #    return jsonify({"error": "Invalid password"}), 401

                    else:
                        logger.debug(f"User {appuser} not found or account is not active in the database.")
                        return jsonify({"error": "User not found or account is inactive"}), 401

                except FileNotFoundError as e:
                    logger.error(f"Error reading .instance.cnf file: {str(e)}")
                    return jsonify({'error': 'Invalid company or instance information'}), 400
                except Exception as e:
                    logger.error(f"An error occurred while processing profile request: {str(e)}")
                    return jsonify({'error': 'An error occurred during profile retrieval'}), 500

            return jsonify({'error': 'Invalid username or password'}), 401

    except Exception as e:
        logger.error(f"{MODULE_NAME}: An error occurred while fetching profile data - {str(e)}")
        return jsonify({'error': 'An error occurred during the profile process'}), 500



@login_data_api.route('/generate_password_hash', methods=['POST'])
def generate_password_hash():
    MODULE_NAME = __name__
    appuser = request.json.get("username", None)
    plaintext_password = request.json.get("plaintext_password", None)

    logger.debug(f"{MODULE_NAME}: Username Arrived to generate password hash function: {appuser}")

    salt = bcrypt.gensalt()
    hashed_password = bcrypt.hashpw(plaintext_password.encode('utf-8'), salt)

    return jsonify({"hashed_password": hashed_password.decode('utf-8')})

@login_data_api.route('/verify_password', methods=['POST'])
def verify_password():
    MODULE_NAME = __name__
    
    # Get input from the request
    hashed_password = request.json.get("hashed_password", None)
    plaintext_password = request.json.get("plaintext_password", None)
    
    if not hashed_password or not plaintext_password:
        return jsonify({"error": "Both hashed_password and plaintext_password are required"}), 400
    
    # Verify if the hashed password matches the plaintext password
    if bcrypt.checkpw(plaintext_password.encode('utf-8'), hashed_password.encode('utf-8')):
        return jsonify({"message": "Password matches the hash!"})
    else:
        return jsonify({"error": "Password does not match the hash"}), 401

