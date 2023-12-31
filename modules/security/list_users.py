from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from datetime import datetime
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

list_users_api = Blueprint('list_users_api', __name__)

@list_users_api.route('/users', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def list_users():
    try:
        # Extract user information from the authorization token
        authorization_header = request.headers.get('Authorization')
        token_results = ""
        USER_ID = ""
        MODULE_NAME = __name__
        if authorization_header:
            token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]    
        
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the list users data function")    
        mydb = get_database_connection(USER_ID, MODULE_NAME)
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Getting the list of users")

        # Define parameters
        empid = request.args.get('empid')
        username = request.args.get('username')

        # Build the SQL query based on parameters
        query = "SELECT id, username, empid, emailid, status, start_date, expiry_date FROM adm.users"
        conditions = []

        if empid:
            conditions.append(f"empid = '{empid}'")

        if username:
            conditions.append(f"username = '{username}'")

        if conditions:
            query += " WHERE " + " AND ".join(conditions)

        mycursor = mydb.cursor()
        mycursor.execute(query)
        users = mycursor.fetchall()
        
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Retrieved user data: {users}")

        # Convert user data into a list of dictionaries with field names
        user_list = []
        for data in users:
            user_dict = {
                'id': data[0],
                'username': data[1],
                'empid': data[2],
                'emailid': data[3],
                'start_date': data[5].strftime('%d-%m-%Y') if data[5] else None,
                'status': data[4],
                'expiry_date': data[6].strftime('%d-%m-%Y') if data[6] else None
            }
            user_list.append(user_dict)

        # Return the list of users as a JSON response
        return jsonify({'users': user_list})

    except Exception as e:
        # Log any exceptions
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return jsonify({'error': 'Internal Server Error'}), 500
