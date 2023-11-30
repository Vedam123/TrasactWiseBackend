from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

create_legal_entity_api = Blueprint('create_legal_entity_api', __name__)

@create_legal_entity_api.route('/create_legal_entity', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_legal_entity():
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
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the create legal entity function")

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

        name = data['name']
        registration_number = data['registration_number']
        address = data['address']
        contact_email = data.get('contact_email')
        contact_phone = data.get('contact_phone')
        about = data.get('about')

        # Log parsed data
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Name: {name}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Registration Number: {registration_number}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Address: {address}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Contact Email: {contact_email}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Contact Phone: {contact_phone}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed About: {about}")

        mycursor = mydb.cursor()

        try:
            query = "INSERT INTO com.legal_entity (name, registration_number, address, contact_email, contact_phone, about, created_by, updated_by) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"
            values = (name, registration_number, address, contact_email, contact_phone, about, current_userid, current_userid)

            mycursor.execute(query, values)
            mydb.commit()

            # Log success and close the cursor and connection
            logger.info(f"{USER_ID} --> {MODULE_NAME}: Legal entity data created successfully")
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Legal entity data created successfully'})
        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{USER_ID} --> {MODULE_NAME}: Unable to create legal entity data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500
    except Exception as e:
        # Log any exceptions
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
