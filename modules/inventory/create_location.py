# POST API for inv.locations
from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger

create_location_api = Blueprint('create_location_api', __name__)

@create_location_api.route('/create_location', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_location():
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
        logger.debug(f"{appuser} --> {MODULE_NAME}: Entered in the create location function")

        if request.content_type == 'application/json':
            data = request.get_json()
            print(data)
        else:
            data = request.form

        # Log the received data
        logger.debug(f"{appuser} --> {MODULE_NAME}: Received data: {data}")

        location_name = data['location_name']
        location_type = data['location_type']
        description = data.get('description')
        capacity = data.get('capacity')
        temperature_controlled = data.get('temperature_controlled')
        security_level = data.get('security_level')
        warehouse_id = data.get('warehouse_id')
        created_by = appuserid
        updated_by = appuserid

        # Log parsed data
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed Location Name: {location_name}")
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed Location Type: {location_type}")
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed Description: {description}")
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed Capacity: {capacity}")
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed Temperature Controlled: {temperature_controlled}")
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed Security Level: {security_level}")
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed Warehouse ID: {warehouse_id}")

        mycursor = mydb.cursor()

        try:
            query = """
                INSERT INTO inv.locations (location_name, location_type, description, capacity,
                                           temperature_controlled, security_level, warehouse_id,
                                           created_at, updated_at, created_by, updated_by)
                VALUES (%s, %s, %s, %s, %s, %s, %s, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, %s, %s)
            """
            values = (location_name, location_type, description, capacity,
                      temperature_controlled, security_level, warehouse_id,
                      created_by, updated_by)

            mycursor.execute(query, values)
            mydb.commit()

            # Log success and close the cursor and connection
            logger.info(f"{appuser} --> {MODULE_NAME}: Location data created successfully")
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Location data created successfully'}), 200

        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{appuser} --> {MODULE_NAME}: Unable to create location data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500
    except Exception as e:
        # Log any exceptions
        logger.error(f"{appuser} --> {MODULE_NAME}: An error occurred : {str(e)}")
        return jsonify({'error': str(e)}), 500
