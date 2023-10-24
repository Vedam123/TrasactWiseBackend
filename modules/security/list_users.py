from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from datetime import datetime
from modules.security.permission_required import permission_required  # Import the decorator
from config import READ_ACCESS_TYPE  # Import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger  # Import the logger module

list_users_api = Blueprint('list_users_api', __name__)

@list_users_api.route('/users', methods=['GET'])
@permission_required(READ_ACCESS_TYPE ,  __file__)  # Pass READ_ACCESS_TYPE as an argument
def list_users():
    authorization_header = request.headers.get('Authorization')
    token_results = ""
    USER_ID = ""
    MODULE_NAME = __name__
    if authorization_header:
        token_results = get_user_from_token(authorization_header)

    if token_results:
        USER_ID = token_results["username"]    
    token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the list users data function")    
    mydb = get_database_connection(USER_ID, MODULE_NAME)
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Getting the list of users")

    # Retrieve all users from the database
    query = "SELECT * FROM adm.users"
    mycursor = mydb.cursor()
    mycursor.execute(query)
    users = mycursor.fetchall()
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Retrieved user data: {users}")

    # Convert the user data into a list of dictionaries
    user_list = []
    for data in users:
        user_dict = {
            'id': data[0],
            'username': data[1],
            'password': data[2],
            'empid': data[3],
            'emailid': data[4],
            'created_at': data[5].strftime('%Y-%m-%d %H:%M:%S')
        }
        user_list.append(user_dict)

    # Close the cursor and connection
    mycursor.close()
    mydb.close()
    
    # Return the list of users as JSON response
    return jsonify({'users': user_list})
