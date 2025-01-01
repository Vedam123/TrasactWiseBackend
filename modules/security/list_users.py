from flask import Blueprint, jsonify, request
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.utilities.logger import logger

list_users_api = Blueprint('list_users_api', __name__)

@list_users_api.route('/users', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)  # Checking if the user has permission to access this endpoint
def list_users():
    try:
        # Extract user information from the authorization token
        authorization_header = request.headers.get('Authorization')

        try:
            company, instance, dbuser, mydb, appuser, appuserid, user_info, employee_info = get_user_and_db_details(authorization_header)
            logger.debug(f"{appuser} --> {__name__}: Successfully retrieved user details from the token.")
        except ValueError as e:
            logger.error(f"Failed to retrieve user details from token. Error: {str(e)}")
            return jsonify({"error": str(e)}), 401
        
        if not appuser:
            logger.error(f"Unauthorized access attempt: {appuser} --> {__name__}: Application user not found.")
            return jsonify({"error": "Unauthorized. Username not found."}), 401

        # Define parameters
        empid = request.args.get('empid')
        username = request.args.get('username')

        # Log the parameters being used in the query
        logger.debug(f"{appuser} --> {__name__}: Searching for users with empid: {empid}, username: {username}")

        # Build the SQL query based on parameters
        query = "SELECT id, username, empid, emailid, status, start_date, expiry_date FROM adm.users"
        conditions = []

        if empid:
            conditions.append(f"empid = '{empid}'")
            logger.debug(f"{appuser} --> {__name__}: Adding condition for empid: {empid}")

        if username:
            conditions.append(f"username = '{username}'")
            logger.debug(f"{appuser} --> {__name__}: Adding condition for username: {username}")

        if conditions:
            query += " WHERE " + " AND ".join(conditions)

        # Execute the query to fetch users based on the provided conditions
        mycursor = mydb.cursor()
        mycursor.execute(query)
        users = mycursor.fetchall()
        mydb.close()

        logger.debug(f"{appuser} --> {__name__}: Retrieved user data: {users}")

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

        logger.debug(f"{appuser} --> {__name__}: Successfully converted user data to dictionary format for response.")

        # Return the list of users as a JSON response
        logger.debug(f"{appuser} --> {__name__}: Returning user data for identifier (empid: {empid}, username: {username}).")
        return jsonify({'users': user_list})

    except Exception as e:
        # Log any exceptions that occur during the process
        logger.error(f"{appuser} --> {__name__}: An error occurred while processing request (empid: {empid}, username: {username}). Error: {str(e)}")
        return jsonify({'error': 'Internal Server Error'}), 500
