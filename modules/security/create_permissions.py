from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger  # Import the logger module

create_permission_api = Blueprint('create_permission_api', __name__)

@create_permission_api.route('/create_permissions', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_permissions():

    authorization_header = request.headers.get('Authorization')
    token_results = ""
    USER_ID = ""
    current_user_id = ""
    MODULE_NAME = __name__
    if authorization_header:
        token_results = get_user_from_token(authorization_header)

    if token_results:
        current_user_id = token_results["current_user_id"]
        USER_ID = token_results["username"]

    token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the create permissions data function")

    try:
        mydb = get_database_connection(USER_ID, MODULE_NAME)
        current_userid = None
        authorization_header = request.headers.get('Authorization', '')
        if authorization_header.startswith('Bearer '):
            token = authorization_header.replace('Bearer ', '')
            decoded_token = decode_token(token)
            current_userid = decoded_token.get('Userid')

        permissions = request.json
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: ------------------------------------------")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Received permissions data: {permissions}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: ------------------------------------------")

        if not permissions or not isinstance(permissions, list):
            return jsonify({'error': 'Invalid or empty permissions data'}), 400

        with mydb.cursor() as mycursor:
            for permission in permissions:
                user_id = permission.get('user_id', None)
                module = permission.get('module', None)
                logger.debug(f"{USER_ID} --> {MODULE_NAME}: user_id, module: {user_id}, {module}")
                read_permission = permission.get('read_permission', False)
                write_permission = permission.get('write_permission', False)
                update_permission = permission.get('update_permission', False)
                delete_permission = permission.get('delete_permission', False)
                
                if user_id is None or module is None:
                    return jsonify({'error': 'user_id and module must be provided'}), 400

                query = "SELECT * FROM adm.user_module_permissions WHERE user_id = %s AND module = %s"
                mycursor.execute(query, (user_id, module))
                existing_permission = mycursor.fetchone()
                
                if existing_permission:
                    logger.debug(f"{USER_ID} --> {MODULE_NAME}: User is already there so updating - user_id: {user_id}, module: {module}, current_userid: {current_userid}, permissions selected: read_permission: {read_permission}, write_permission: {write_permission}, update_permission: {update_permission}, delete_permission: {delete_permission}")
                    query = "UPDATE adm.user_module_permissions SET read_permission = %s, write_permission = %s, update_permission = %s, delete_permission = %s, updated_by = %s WHERE user_id = %s AND module = %s"
                    values = (read_permission, write_permission, update_permission, delete_permission, current_userid, user_id, module)
                    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Query: {query}")
                    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Values: {values}")
                    rows_affected = mycursor.execute(query, values)
                    if rows_affected == 0:
                        logger.debug(f"{USER_ID} --> {MODULE_NAME}: No rows were updated. The WHERE condition didn't match any rows.")
                else:
                    logger.debug(f"{USER_ID} --> {MODULE_NAME}: User is not there, so inserting")
                    query = "INSERT INTO adm.user_module_permissions (user_id, module, read_permission, write_permission, update_permission, delete_permission, created_by, updated_by) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"
                    values = (user_id, module, read_permission, write_permission, update_permission, delete_permission, current_userid, current_userid)
                    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Query: {query}")
                    rows_affected = mycursor.execute(query, values)
                    if rows_affected == 0:
                        logger.debug(f"{USER_ID} --> {MODULE_NAME}: No rows were inserted. The WHERE condition didn't match any rows.")
        mydb.commit()
        return jsonify({'message': 'User module permissions created/updated successfully'}), 200
    except Exception as e:
        mydb.rollback()  # Rollback changes if an error occurs
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error: {str(e)}")  # Log the specific error
        return jsonify({'error': 'An error occurred while processing the request'}), 500
    finally:
        mydb.close()  # Always close the database connection
