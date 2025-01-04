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
        capacity = data.get('capacity')
        if capacity == '':
            capacity = None
        uom_id = None
        if capacity is not None:
            uom_id = data.get('uom_id', None)  # Only set uom_id if capacity is not None
        created_by = appuserid
        updated_by = appuserid

        # Log parsed data
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed Location ID: {location_id}")
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed Zone Name: {zone_name}")
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed Description: {description}")
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed Capacity: {capacity}")
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed UOM ID: {uom_id}")

        # Convert capacity to float (if provided)
        if capacity:
            capacity = float(capacity)
        else:
            capacity = None  # If not provided, set to None (NULL in DB)

        # Handle UOM ID: If it is an empty string or not provided, set it to None (NULL in DB)
        if uom_id == '' or uom_id is None:
            uom_id = None

        # Database cursor
        mycursor = mydb.cursor()

        try:
            # Updated query with handling for NULL values (capacity, uom_id)
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
