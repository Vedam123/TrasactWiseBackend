from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

create_aisle_api = Blueprint('create_aisle_api', __name__)

@create_aisle_api.route('/create_aisle', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_aisle():
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
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the create aisle function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)

        current_userid = None
        authorization_header = request.headers.get('Authorization', '')
        if authorization_header.startswith('Bearer '):
            token = authorization_header.replace('Bearer ', '')
            decoded_token = decode_token(token)
            current_userid = decoded_token.get('Userid')

        if request.content_type == 'application/json':
            data = request.get_json()
            print(data)
        else:
            data = request.form

        # Log the received data
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Received data: {data}")

        aisle_name = data['aisle_name']
        description = data.get('description')
        zone_id = data.get('zone_id')
        created_by = current_userid
        updated_by = current_userid

        # Log parsed data
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Aisle Name: {aisle_name}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Description: {description}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Zone ID: {zone_id}")

        mycursor = mydb.cursor()

        try:
            query = """
                INSERT INTO inv.aisles (aisle_name, description, zone_id, created_by, updated_by)
                VALUES (%s, %s, %s, %s, %s)
            """
            values = (aisle_name, description, zone_id, created_by, updated_by)

            mycursor.execute(query, values)
            mydb.commit()

            # Log success and close the cursor and connection
            logger.info(f"{USER_ID} --> {MODULE_NAME}: Aisle data created successfully")
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Aisle data created successfully'}), 200

        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{USER_ID} --> {MODULE_NAME}: Unable to create aisle data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500
    except Exception as e:
        # Log any exceptions
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred : {str(e)}")
        return jsonify({'error': str(e)}), 500
