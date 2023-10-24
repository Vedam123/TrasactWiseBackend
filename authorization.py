from flask import request, jsonify
from flask_jwt_extended import get_jwt_identity, jwt_required
from modules.admin.databases.mydb import get_database_connection
from modules.utilities.logger import logger  # Import the logger module

def get_user_permissions_from_database(user_id):
    MODULE_NAME = __name__

    
    logger.debug(f"{MODULE_NAME}: Entered to check if user has permission for user ID {user_id}")
    mydb = get_database_connection()
    mycursor = mydb.cursor()
    # Retrieve user module permissions from the database based on the provided user_id
    query = "SELECT module, read_permission, write_permission, update_permission, delete_permission FROM adm.user_module_permissions WHERE user_id = %s"
    mycursor.execute(query, (user_id,))
    user_permissions = mycursor.fetchall()
    
    logger.debug(f"{MODULE_NAME}: Entered to check if user has permission for user ID {user_id}")

    # Close the cursor and connection
    mycursor.close()
    mydb.close()

    # Convert the database result into a dictionary format for easy access
    permissions_dict = {}
    for module, read_permission, write_permission, update_permission, delete_permission in user_permissions:
        permissions_dict[module] = {
            'read_permission': bool(read_permission),
            'write_permission': bool(write_permission),
            'update_permission': bool(update_permission),
            'delete_permission': bool(delete_permission),
        }

    return permissions_dict

def always_authenticated():
    MODULE_NAME = __name__
    # Mock the authentication process by setting a fixed user_id as the authenticated user
    user_id = 1212  # Replace 123 with the desired user_id
    #verify_jwt_in_request(optional=True)  # Simulate JWT verification (optional=True for an optional JWT)

    return get_user_permissions_from_database(user_id)

@jwt_required(optional=True)  # Use optional=True to make the decorator act as if the JWT is optional
def authorize_user():
    MODULE_NAME = __name__
    # The @jwt_required() decorator ensures that the JWT is present and valid

    current_user = get_jwt_identity()
    logger.debug(f"{MODULE_NAME}: Current user in authorize_user function: {current_user}")

    # Check the requested endpoint and method (GET, POST, PUT, DELETE)
    endpoint = request.endpoint
    method = request.method
    current_user = 1212 
    logger.debug(f"{MODULE_NAME}: Requested endpoint: {endpoint}, method: {method}")

    # Get the required permissions for the requested endpoint and method
    required_permissions = {
        'get_employee_data_api.get_employee_data': ['GET'],
        # Add other endpoints and their required permissions here
    }

    # Get the user's permissions from the database
    user_permissions = get_user_permissions_from_database(current_user)
    logger.debug(f"{MODULE_NAME}: Existing permissions: {user_permissions}")
    logger.debug(f"{MODULE_NAME}: Required permissions: {required_permissions}")

    # Check if the user's permissions match the required permissions for the requested endpoint and method
    permissions = required_permissions.get(f"{endpoint}.{method}", [])
    if all(permission in user_permissions.get(endpoint, {}).get(method, {}) for permission in permissions):
        # If the user has the required permission, allow the request to proceed
        return None

    logger.error(f"{MODULE_NAME}: Insufficient permissions for user: {current_user}")
    # If the user does not have the required permission, return an error response
    return jsonify({'error': 'Insufficient permissions'}), 403
