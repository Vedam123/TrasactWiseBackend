from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from datetime import datetime
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

list_users_api = Blueprint('list_users_api', __name__)

@list_users_api.route('/list_users_pwd_change', methods=['GET'])
def list_users_pwd_change():
    try:
        MODULE_NAME = __name__
        identifier = request.args.get('identifier')  # 'identifier' can be empid, emailid, or username
        if identifier is None:
            return jsonify({'error': 'Missing identifier parameter'}), 400
        
        logger.debug(f"{identifier} --> {MODULE_NAME}: Entered in the list users data function")    
        mydb = get_database_connection(identifier, MODULE_NAME)
        logger.debug(f"{identifier} --> {MODULE_NAME}: Getting the list of users")

        # Build the SQL query based on the identifier
        query = "SELECT id, username, empid, emailid, status, start_date, expiry_date FROM adm.users"
        conditions = []

        if identifier:
            if identifier.isdigit():  # Check if it's a numeric value (empid)
                conditions.append(f"empid = '{identifier}'")
            elif '@' in identifier:  # Check if it's an email address (emailid)
                conditions.append(f"emailid = '{identifier}'")
            else:  # Default to username
                conditions.append(f"username = '{identifier}'")

        if conditions:
            query += " WHERE " + " AND ".join(conditions)

        mycursor = mydb.cursor()
        mycursor.execute(query)
        users = mycursor.fetchall()
        
        logger.debug(f"{identifier} --> {MODULE_NAME}: Retrieved user data: {users}")

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
        logger.error(f"{identifier} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return jsonify({'error': 'Internal Server Error'}), 500
