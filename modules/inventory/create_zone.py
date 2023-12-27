# POST API for inv.locations
from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

zones_api = Blueprint('zones_api', __name__)

@zones_api.route('/create_zone', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_zone():
    try:
        authorization_header = request.headers.get('Authorization')
        token_results = ""
        USER_ID = ""
        MODULE_NAME = __name__
        if authorization_header:
            token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
            token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None

        # Log entry point
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the create zone function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)

        current_userid = None
        authorization_header = request.headers.get('Authorization', '')
        if authorization_header.startswith('Bearer '):
            token = authorization_header.replace('Bearer ', '')
            decoded_token = decode_token(token)
            current_userid = decoded_token.get('Userid')

        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        # Log the received data
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Received data: {data}")

        location_id = data['location_id']
        zone_name = data['zone_name']
        description = data.get('description')
        capacity = data.get('capacity')
        created_by = current_userid
        updated_by = current_userid

        # Log parsed data
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Location ID: {location_id}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Zone Name: {zone_name}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Description: {description}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Capacity: {capacity}")

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
            logger.info(f"{USER_ID} --> {MODULE_NAME}: Zone data created successfully")
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Zone data created successfully'}), 200

        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{USER_ID} --> {MODULE_NAME}: Unable to create zone data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500

    except Exception as e:
        # Log any exceptions
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred : {str(e)}")
        return jsonify({'error': str(e)}), 500