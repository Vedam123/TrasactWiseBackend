from flask import Blueprint, jsonify, request
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.security.permission_required import permission_required  # Import the decorator
from config import READ_ACCESS_TYPE  # Import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger  # Import the logger module

list_roles_api = Blueprint('list_roles_api', __name__)

@list_roles_api.route('/roles', methods=['GET'])
@permission_required(READ_ACCESS_TYPE ,  __file__)  # Pass READ_ACCESS_TYPE as an argument
def list_roles():
    authorization_header = request.headers.get('Authorization')
    
    try:
        company, instance, dbuser, mydb, appuser, appuserid, user_info, employee_info = get_user_and_db_details(authorization_header)
    except ValueError as e:
        logger.error(f"Authorization failed for appuser {appuser} --> {__name__}: {str(e)}")
        return jsonify({"error": str(e)}), 401
    
    if not appuser:
        logger.error(f"Unauthorized access attempt for appuser {appuser} --> {__name__}: Application user not found")
        return jsonify({"error": f"Unauthorized. Application user {appuser} not found."}), 401
    
    logger.debug(f"{appuser} --> {__name__}: Entered the list roles function to retrieve role data")

    try:
        # Retrieve all roles from the database
        query = "SELECT * FROM adm.roles"
        mycursor = mydb.cursor()
        mycursor.execute(query)
        roles = mycursor.fetchall()

        logger.debug(f"{appuser} --> {__name__}: Successfully retrieved {len(roles)} roles from the database")

        # Convert the role data into a list of dictionaries
        role_list = []
        for data in roles:
            role_dict = {
                'id': data[0],
                'name': data[1],
                'description': data[2],
                'created_at': data[3].strftime('%Y-%m-%d %H:%M:%S'),
                'updated_at': data[4].strftime('%Y-%m-%d %H:%M:%S')
            }
            role_list.append(role_dict)
            logger.debug(f"{appuser} --> {__name__}: Retrieved role data: {role_dict}")

        # Close the cursor and connection
        mycursor.close()
        mydb.close()

        logger.debug(f"{appuser} --> {__name__}: Successfully closed database connection")

        # Return the list of roles as JSON response
        return jsonify({'roles': role_list})

    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Error retrieving roles from database - {str(e)}")
        return jsonify({"error": "Failed to retrieve roles from the database."}), 500
