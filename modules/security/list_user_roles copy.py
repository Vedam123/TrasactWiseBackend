from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required  # Import the decorator
from config import READ_ACCESS_TYPE  # Import READ_ACCESS_TYPE
from modules.security.routines.get_user_and_db_details import get_user_and_db_details  # Import the function for user details
from modules.utilities.logger import logger  # Import the logger module

list_user_roles_api = Blueprint('list_user_roles_api', __name__)

@list_user_roles_api.route('/user_roles', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)  # Pass READ_ACCESS_TYPE as an argument
def list_user_roles():
    authorization_header = request.headers.get('Authorization')

    # Initialize variables
    appuser = ""
    mydb = None
    try:
        # Get user details from token and database details
        company, instance, dbuser, mydb, appuser, appuserid, user_info, employee_info = get_user_and_db_details(authorization_header)
    except ValueError as e:
        logger.error(f"{appuser} --> {__name__}: Authorization failed due to {str(e)}")
        return jsonify({"error": str(e)}), 401
    
    if not appuser:
        logger.error(f"Unauthorized access attempt for appuser {appuser} --> {__name__}: Application user not found")
        return jsonify({"error": f"Unauthorized. Application user {appuser} not found."}), 401
    
    logger.debug(f"{appuser} --> {__name__}: Entered the list user roles function")

    try:
        # Since mydb is already obtained from get_user_and_db_details, no need to call get_database_connection
        logger.debug(f"{appuser} --> {__name__}: Successfully obtained database connection")

        # Query to retrieve all user roles from the database
        query = """
        SELECT ur.id, ur.user_id, u.username, ur.role_id, r.name as role_name, ur.Assigned_At
        FROM adm.user_roles ur
        INNER JOIN adm.users u ON ur.user_id = u.id
        INNER JOIN adm.roles r ON ur.role_id = r.id
        """
        mycursor = mydb.cursor()
        mycursor.execute(query)
        user_roles = mycursor.fetchall()
        
        logger.debug(f"{appuser} --> {__name__}: Retrieved {len(user_roles)} user roles data from the database")

        # Convert the user role data into a list of dictionaries with all the fields
        user_role_list = []
        for user_role in user_roles:
            role_entry = {
                'id': user_role[0],
                'user_id': user_role[1],
                'username': user_role[2],
                'role_id': user_role[3],
                'role_name': user_role[4],
                'Assigned_At': user_role[5].strftime('%Y-%m-%d %H:%M:%S')
            }
            user_role_list.append(role_entry)
            logger.debug(f"{appuser} --> {__name__}: Processed user role entry: {role_entry}")

        # Close the cursor and connection
        mycursor.close()
        mydb.close()
        logger.debug(f"{appuser} --> {__name__}: Database connection and cursor closed successfully")

        # Return the list of user roles as JSON response
        return jsonify({'user_roles': user_role_list})
    
    except Exception as e:
        # Log any error that happens during the database operation
        logger.error(f"{appuser} --> {__name__}: Error occurred while retrieving user roles: {str(e)}")
        return jsonify({"error": "Failed to retrieve user roles."}), 500
