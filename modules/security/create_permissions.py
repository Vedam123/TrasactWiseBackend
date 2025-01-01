from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger  # Import the logger module
from modules.security.routines.get_user_and_db_details import get_user_and_db_details

create_permission_api = Blueprint('create_permission_api', __name__)

@create_permission_api.route('/create_permissions', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_permissions():

    print("Entered created permissions function ")

    authorization_header = request.headers.get('Authorization')

    try:
        company, instance, dbuser, mydb, appuser, appuserid, user_info, employee_info = get_user_and_db_details(authorization_header)
    except ValueError as e:
        return jsonify({"error": str(e)}), 401
    
    if not appuser:
        return jsonify({"error": "Unauthorized. Username not found."}), 401
    
    logger.debug(f"{appuser} --> {__name__}: Entered in the create permissions data function")

    try:
        permissions = request.json
        logger.debug(f"{appuser} --> {__name__}: ------------------------------------------")
        logger.debug(f"{appuser} --> {__name__}: Received permissions data: {permissions}")
        logger.debug(f"{appuser} --> {__name__}: ------------------------------------------")

        if not permissions or not isinstance(permissions, list):
            return jsonify({'error': 'Invalid or empty permissions data'}), 400

        print("permissions are present")
        with mydb.cursor() as mycursor:
            for permission in permissions:
                user_id = permission.get('user_id', None)
                module = permission.get('module', None)
                logger.debug(f"{appuser} --> {__name__}: user_id, module: {user_id}, {module}")
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
                    logger.debug(f"{appuser} --> {__name__}: User is already there so updating - user_id: {user_id}, module: {module}, current_userid: {appuserid}, permissions selected: read_permission: {read_permission}, write_permission: {write_permission}, update_permission: {update_permission}, delete_permission: {delete_permission}")
                    query = "UPDATE adm.user_module_permissions SET read_permission = %s, write_permission = %s, update_permission = %s, delete_permission = %s, updated_by = %s WHERE user_id = %s AND module = %s"
                    values = (read_permission, write_permission, update_permission, delete_permission, appuserid, user_id, module)
                    logger.debug(f"{appuser} --> {__name__}: Query: {query}")
                    logger.debug(f"{appuser} --> {__name__}: Values: {values}")
                    rows_affected = mycursor.execute(query, values)
                    if rows_affected == 0:
                        logger.debug(f"{appuser} --> {__name__}: No rows were updated. The WHERE condition didn't match any rows.")
                else:
                    logger.debug(f"{appuser} --> {__name__}: User is not there, so inserting")
                    query = "INSERT INTO adm.user_module_permissions (user_id, module, read_permission, write_permission, update_permission, delete_permission, created_by, updated_by) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"
                    values = (user_id, module, read_permission, write_permission, update_permission, delete_permission, appuserid, appuserid)
                    logger.debug(f"{appuser} --> {__name__}: Query: {query}")
                    rows_affected = mycursor.execute(query, values)
                    if rows_affected == 0:
                        logger.debug(f"{appuser} --> {__name__}: No rows were inserted. The WHERE condition didn't match any rows.")
        mydb.commit()
        return jsonify({'message': 'User module permissions created/updated successfully'}), 200
    except Exception as e:
        mydb.rollback()  # Rollback changes if an error occurs
        logger.error(f"{appuser} --> {__name__}: Error: {str(e)}")  # Log the specific error
        return jsonify({'error': 'An error occurred while processing the request'}), 500
    finally:
        mydb.close()  # Always close the database connection
