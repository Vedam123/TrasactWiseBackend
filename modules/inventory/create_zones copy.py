from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger

zones_api = Blueprint('zones_api', __name__)

@zones_api.route('/create_zones', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_zones():
    try:
        MODULE_NAME = __name__

        authorization_header = request.headers.get('Authorization')

        try:
            company, instance, dbuser, mydb, appuser, appuserid, user_info, employee_info = get_user_and_db_details(authorization_header)
            logger.debug(f"{appuser} --> {MODULE_NAME}: Successfully retrieved user details from the token.")
        except ValueError as e:
            logger.error(f"Failed to retrieve user details from token. Error: {str(e)}")
            return jsonify({"error": str(e)}), 401
        
        if not appuser:
            logger.error(f"Unauthorized access attempt: {appuser} --> {MODULE_NAME}: Application user not found.")
            return jsonify({"error": "Unauthorized. Username not found."}), 401

        # Log entry point
        logger.debug(f"{appuser} --> {MODULE_NAME}: Entered in the create zone function")

        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        # Log the received data
        logger.debug(f"{appuser} --> {MODULE_NAME}: Received data: {data}")

        # Parse incoming data
        location_id = data['location_id']
        zone_name = data['zone_name']
        description = data.get('description')
        capacity = int(data.get('capacity'))
        uom_id = data.get('uom_id')  # New field
        created_by = appuserid
        updated_by = appuserid

        # Log parsed data
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed Location ID: {location_id}")
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed Zone Name: {zone_name}")
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed Description: {description}")
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed Capacity: {capacity}")
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed UOM ID: {uom_id}")

        # Validation if needed
        if capacity and (not isinstance(capacity, (int, float)) or float(capacity) <= 0):
            return jsonify({'error': 'Capacity must be a number greater than 0 zero.'}), 400

        # Convert capacity to float (if provided)
        if capacity:
            capacity = float(capacity)

        # Database cursor
        mycursor = mydb.cursor()

        try:
            # Updated query with new columns (uom_id) and handling of timestamps
            query = """
                INSERT INTO inv.zones (location_id, zone_name, description, capacity, uom_id, created_at, created_by, updated_at, updated_by)
                VALUES (%s, %s, %s, %s, %s, CURRENT_TIMESTAMP, %s, CURRENT_TIMESTAMP, %s)
            """
            values = (location_id, zone_name, description, capacity, uom_id, created_by, updated_by)

            # Execute the query and commit the transaction
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
        logger.error(f"{appuser} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
