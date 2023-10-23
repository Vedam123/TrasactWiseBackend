from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required  # Import the decorator
from config import DELETE_ACCESS_TYPE    # Import WRITE_ACCESS_TYPE
#from configure_logging import configure_logging
from modules.security.get_user_from_token import get_user_from_token

# Get a logger for this module
#logger = configure_logging()

delete_user_modules_api = Blueprint('delete_user_modules_api', __name__)

@delete_user_modules_api.route('/delete_user_modules', methods=['DELETE'])
@permission_required(DELETE_ACCESS_TYPE ,  __file__)  # Pass WRITE_ACCESS_TYPE as an argument
def delete_user_modules():
   #  MODULE_NAME = __name__ 
   #  token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None
    # USER_ID = token_results['username']
    # logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the delete user modules data function")    
    mydb = get_database_connection()

    # Retrieve user_id and modules from the request
    user_id = request.json.get('user_id', None)
    modules = request.json.get('modules', [])
    print(user_id)
    print(modules)
    if user_id is None:
        return jsonify({'error': 'user_id must be provided'}), 400

    if not modules:
        return jsonify({'error': 'modules must be provided as a list of module names'}), 400

    # Check if the provided user_id exists in the database
    query = "SELECT * FROM adm.users WHERE id = %s"
    mycursor = mydb.cursor()
    mycursor.execute(query, (user_id,))
    existing_user = mycursor.fetchone()

    if not existing_user:
        return jsonify({'error': 'User does not exist for the given user_id'}), 404

    # Loop through the list of modules and delete the corresponding rows
    for module in modules:
        # Check if the provided module exists in the database
        query = "SELECT * FROM adm.user_module_permissions WHERE user_id = %s AND module = %s"
        mycursor.execute(query, (user_id, module))
        existing_permission = mycursor.fetchone()

        if not existing_permission:
            # If the combination does not exist, skip this module and proceed with the next one
            continue

        # If the combination exists, delete the row
        delete_query = "DELETE FROM adm.user_module_permissions WHERE user_id = %s AND module = %s"
        mycursor.execute(delete_query, (user_id, module))
        mydb.commit()

    # Close the cursor
    mycursor.close()

    # Close the connection
    mydb.close()

    # Return success message
    return jsonify({'message': 'User module permissions deleted successfully'})
