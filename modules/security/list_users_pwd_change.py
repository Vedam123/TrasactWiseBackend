from flask import Blueprint, jsonify, request
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.security.permission_required import permission_required  # Import the decorator
from config import READ_ACCESS_TYPE  # Import READ_ACCESS_TYPE
from modules.utilities.logger import logger

list_users_api = Blueprint('list_users_api', __name__)

@list_users_api.route('/list_users_pwd_change', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __name__)  # Adding the permission required decorator to the route
def list_users_pwd_change():
    authorization_header = request.headers.get('Authorization')

    try:
        # Fetch user and database details from the token
        company, instance, dbuser, mydb, appuser, appuserid, user_info, employee_info = get_user_and_db_details(authorization_header)
        logger.debug(f"{appuser} --> {__name__}: User details successfully retrieved.")
    except ValueError as e:
        # Log error when user details cannot be fetched
        logger.error(f"{appuser} --> {__name__}: Failed to get user details. Error: {str(e)}")
        return jsonify({"error": str(e)}), 401
    
    if not appuser:
        # Log error for unauthorized access
        logger.error(f"Unauthorized access attempt by {appuser} --> {__name__}: Application user not found.")
        return jsonify({"error": "Unauthorized. Username not found."}), 401
    
    try:       
        # Get the identifier from query parameters
        identifier = request.args.get('identifier')  # 'identifier' can be empid, emailid, or username
        if identifier is None:
            # Log error if the identifier is missing
            logger.error(f"{appuser} --> {__name__}: Missing 'identifier' parameter in request.")
            return jsonify({'error': 'Missing identifier parameter'}), 400
        
        logger.debug(f"{appuser} --> {__name__}: Entered in the list users data function")
        logger.debug(f"{appuser} --> {__name__}: Getting the list of users with identifier '{identifier}'")

        # Build the SQL query based on the identifier
        query = "SELECT id, username, empid, emailid, status, start_date, expiry_date FROM adm.users"
        conditions = []

        if identifier:
            if identifier.isdigit():  # Check if it's a numeric value (empid)
                conditions.append(f"empid = '{identifier}'")
                logger.debug(f"{appuser} --> {__name__}: Searching users by empid: {identifier}")
            elif '@' in identifier:  # Check if it's an email address (emailid)
                conditions.append(f"emailid = '{identifier}'")
                logger.debug(f"{appuser} --> {__name__}: Searching users by emailid: {identifier}")
            else:  # Default to username
                conditions.append(f"username = '{identifier}'")
                logger.debug(f"{appuser} --> {__name__}: Searching users by username: {identifier}")

        if conditions:
            query += " WHERE " + " AND ".join(conditions)

        # Execute the query to fetch users based on the identifier
        mycursor = mydb.cursor()
        mycursor.execute(query)
        users = mycursor.fetchall()
        
        # Log the results of the query
        logger.debug(f"{appuser} --> {__name__}: Retrieved user data for identifier '{identifier}': {users}")

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

        # Log the successful completion of the user data conversion
        logger.debug(f"{appuser} --> {__name__}: Successfully processed user data for identifier '{identifier}'")

        # Close the database connection
        mycursor.close()
        mydb.close()
        logger.debug(f"{appuser} --> {__name__}: Database connection closed")

        # Return the list of users as a JSON response
        return jsonify({'users': user_list})

    except Exception as e:
        # Log any exceptions that occur during the process
        logger.error(f"{appuser} --> {__name__}: An error occurred while processing identifier '{identifier}'. Error: {str(e)}")
        return jsonify({'error': 'Internal Server Error'}), 500
