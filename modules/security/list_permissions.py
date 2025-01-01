from flask import Blueprint, jsonify, request
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.utilities.logger import logger  # Import the logger module

list_permissions_api = Blueprint('list_permissions_api', __name__)

@list_permissions_api.route('/list_module_permissions', methods=['GET'])
def list_permissions():
    print("Entered the list module permissions function ")
    authorization_header = request.headers.get('Authorization')

    try:
        company, instance, dbuser, mydb, appuser, appuserid, user_info, employee_info = get_user_and_db_details(authorization_header)
    except ValueError as e:
        logger.error(f"{appuser} --> {__name__}: Authorization failed for appuser {appuser} --> {__name__}: {str(e)}")
        return jsonify({"error": str(e)}), 401
    
    if not appuser:
        logger.error(f"{appuser} --> {__name__}: Unauthorized access attempt for appuser {appuser} --> {__name__}: Username not found")
        return jsonify({"error": "Unauthorized. Username not found."}), 401
    
    # Log the attempt to list user module permissions
    user_id = request.args.get('user_id')  # Use 'request.args' for query string parameters
    logger.debug(f"{appuser} --> {__name__}: Attempting to retrieve user module permissions for the user {user_id}")

    try:
        if user_id:
            query = "SELECT * FROM adm.user_module_permissions WHERE user_id = %s"
            mycursor = mydb.cursor()
            mycursor.execute(query, (user_id,))
            logger.debug(f"{appuser} --> {__name__}: Retrieved user module permissions for user_id {user_id}")
        else:
            # Retrieve all user module permissions from the database
            query = "SELECT * FROM adm.user_module_permissions"
            mycursor = mydb.cursor()
            mycursor.execute(query)
            logger.debug(f"{appuser} --> {__name__}: Retrieved all user module permissions")

        # Fetch all permissions from the query
        user_module_permissions = mycursor.fetchall()

        # Convert the user module permissions data into a list of dictionaries
        user_module_permissions_list = []
        for data in user_module_permissions:
            user_module_permissions_dict = {
                'id': data[0],
                'user_id': data[1],
                'module': data[2],
                'read_permission': bool(data[3]),
                'write_permission': bool(data[4]),
                'update_permission': bool(data[5]),
                'delete_permission': bool(data[6])
            }
            user_module_permissions_list.append(user_module_permissions_dict)
            logger.debug(f"{appuser} --> {__name__}: Retrieved permission for user_id {data[1]}: {user_module_permissions_dict}")

        # Close the cursor and connection
        mycursor.close()
        mydb.close()

        logger.debug(f"{appuser} --> {__name__}: Successfully retrieved {len(user_module_permissions_list)} user module permissions")
        return jsonify({'user_module_permissions': user_module_permissions_list})

    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Error retrieving user module permissions - {str(e)}")
        return jsonify({"error": "Failed to retrieve user module permissions from the database."}), 500
