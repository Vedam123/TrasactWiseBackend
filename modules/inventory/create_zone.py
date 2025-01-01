# POST API for inv.locations
from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger

zones_api = Blueprint('zones_api', __name__)

@zones_api.route('/create_zone', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_zone():
    try:
        MODULE_NAME = __name__

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
        # Log entry point
        logger.debug(f"{appuser} --> {MODULE_NAME}: Entered in the create zone function")

        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        # Log the received data
        logger.debug(f"{appuser} --> {MODULE_NAME}: Received data: {data}")

        location_id = data['location_id']
        zone_name = data['zone_name']
        description = data.get('description')
        capacity = data.get('capacity')
        created_by = appuserid
        updated_by = appuserid

        # Log parsed data
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed Location ID: {location_id}")
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed Zone Name: {zone_name}")
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed Description: {description}")
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed Capacity: {capacity}")

        mycursor = mydb.cursor()

        try:
            query = """
                INSERT INTO inv.zones (location_id, zone_name, description, capacity, created_by, updated_by)
                VALUES (%s, %s, %s, %s, %s, %s)
            """
            values = (location_id, zone_name, description, capacity, created_by, updated_by)

            mycursor.execute(query, values)
            mydb.commit()

            # Log success and close the cursor and connection
            logger.info(f"{appuser} --> {MODULE_NAME}: Zone data created successfully")
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Zone data created successfully'}), 200

        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{appuser} --> {MODULE_NAME}: Unable to create zone data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500

    except Exception as e:
        # Log any exceptions
        logger.error(f"{appuser} --> {MODULE_NAME}: An error occurred : {str(e)}")
        return jsonify({'error': str(e)}), 500