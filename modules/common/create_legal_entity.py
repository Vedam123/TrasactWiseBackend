from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger

create_legal_entity_api = Blueprint('create_legal_entity_api', __name__)

@create_legal_entity_api.route('/create_legal_entity', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_legal_entity():
    try:
		
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
        logger.debug(f"{appuser} --> {__name__}: Entered in the create legal entity function")

       
        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        # Log the received data
        logger.debug(f"{appuser} --> {__name__}: Received data: {data}")

        name = data['name']
        registration_number = data['registration_number']
        address = data['address']
        contact_email = data.get('contact_email')
        contact_phone = data.get('contact_phone')
        about = data.get('about')

        # Log parsed data
        logger.debug(f"{appuser} --> {__name__}: Parsed Name: {name}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Registration Number: {registration_number}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Address: {address}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Contact Email: {contact_email}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Contact Phone: {contact_phone}")
        logger.debug(f"{appuser} --> {__name__}: Parsed About: {about}")

        mycursor = mydb.cursor()

        try:
            query = "INSERT INTO com.legal_entity (name, registration_number, address, contact_email, contact_phone, about, created_by, updated_by) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"
            values = (name, registration_number, address, contact_email, contact_phone, about, appuserid, appuserid)

            mycursor.execute(query, values)
            mydb.commit()

            # Log success and close the cursor and connection
            logger.info(f"{appuser} --> {__name__}: Legal entity data created successfully")
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Legal entity data created successfully'})
        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{appuser} --> {__name__}: Unable to create legal entity data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500
    except Exception as e:
        # Log any exceptions
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
