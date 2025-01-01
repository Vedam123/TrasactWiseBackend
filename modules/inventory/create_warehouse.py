# POST API for inv.warehouses
from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger

create_warehouse_api = Blueprint('create_warehouse_api', __name__)

@create_warehouse_api.route('/create_warehouse', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_warehouse():
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
        logger.debug(f"{appuser} --> {MODULE_NAME}: Entered in the create warehouse function")

        if request.content_type == 'application/json':
            data = request.get_json()
            print(data)
        else:
            data = request.form

        # Log the received data
        logger.debug(f"{appuser} --> {MODULE_NAME}: Received data: {data}")

        warehouse_name = data['warehouse_name']
        description = data.get('description')
        address_line1 = data.get('address_line1')
        address_line2 = data.get('address_line2')
        city = data.get('city')
        state = data.get('state')
        postal_code = data.get('postal_code')
        country = data.get('country')
        capacity = data.get('capacity')
        temperature_controlled = data.get('temperature_controlled')
        security_level = data.get('security_level')
        created_by = appuserid
        updated_by = appuserid

        # Log parsed data
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed Warehouse Name: {warehouse_name}")
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed Description: {description}")
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed Address Line 1: {address_line1}")
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed Address Line 2: {address_line2}")
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed City: {city}")
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed State: {state}")
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed Postal Code: {postal_code}")
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed Country: {country}")
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed Capacity: {capacity}")
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed Temperature Controlled: {temperature_controlled}")
        logger.debug(f"{appuser} --> {MODULE_NAME}: Parsed Security Level: {security_level}")

        mycursor = mydb.cursor()

        try:
            query = """
                INSERT INTO inv.warehouses (warehouse_name, description, address_line1, address_line2, city, state,
                                            postal_code, country, capacity, temperature_controlled, security_level,
                                            created_at, updated_at, created_by, updated_by)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, %s, %s)
            """
            values = (warehouse_name, description, address_line1, address_line2, city, state,
                      postal_code, country, capacity, temperature_controlled, security_level,
                      created_by, updated_by)

            mycursor.execute(query, values)
            mydb.commit()

            # Log success and close the cursor and connection
            logger.info(f"{appuser} --> {MODULE_NAME}: Warehouse data created successfully")
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Warehouse data created successfully'}), 200

        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{appuser} --> {MODULE_NAME}: Unable to create warehouse data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500
    except Exception as e:
        # Log any exceptions
        logger.error(f"{appuser} --> {MODULE_NAME}: An error occurred : {str(e)}")
        return jsonify({'error': str(e)}), 500
