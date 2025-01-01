from flask import Blueprint, jsonify, request
from modules.utilities.logger import logger  # Import the logger module
from modules.security.routines.get_user_and_db_details import get_user_and_db_details

list_modules_api = Blueprint('list_modules_api', __name__)

@list_modules_api.route('/list_modules', methods=['GET'])
def list_modules():
    
    authorization_header = request.headers.get('Authorization')
    try:
        company, instance, dbuser, mydb, appuser, appuserid, user_info, employee_info = get_user_and_db_details(authorization_header)
    except ValueError as e:
        logger.error(f"{appuser} --> {__name__}: Authorization failed for {appuser} --> {__name__}: {str(e)}")
        return jsonify({"error": str(e)}), 401
    
    if not appuser:
        logger.error(f"{appuser} --> {__name__}: Unauthorized access attempt with missing appuser --> {__name__}: Username not found in the request")
        return jsonify({"error": "Unauthorized. Username not found."}), 401  

    logger.debug(f"{appuser} --> {__name__}: Entered the list_modules function, attempting to retrieve module list")

    try:
        # Retrieve all modules from the database
        query = "SELECT * FROM adm.modules"
        mycursor = mydb.cursor()
        mycursor.execute(query)
        modules = mycursor.fetchall()

        # Convert the module data into a list of dictionaries
        modules_list = []
        for data in modules:
            module_dict = {
                'id': data[0],
                'folder_name': data[1]
            }
            modules_list.append(module_dict)

        # Close the cursor and connection
        mycursor.close()
        mydb.close()

        logger.debug(f"{appuser} --> {__name__}: Successfully retrieved and processed {len(modules_list)} modules from the database")
        return jsonify({'modules': modules_list})

    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Error retrieving modules list from the database - {str(e)}")
        return jsonify({"error": "Failed to retrieve modules from the database."}), 500
