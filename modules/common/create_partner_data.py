from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required  # Import the decorator
from config import WRITE_ACCESS_TYPE  # Import 
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger  # Import the logger module

create_partner_data_api = Blueprint('create_partner_data_api', __name__)

@create_partner_data_api.route('/create_partner_data', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE ,  __file__)  # Pass WRITE_ACCESS_TYPE as an argument
def create_partner_data():
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
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the create partner data function")

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

        partner_type = data['partnertype']
        partner_name = data['partnername']
        contact_person = data.get('contactperson')
        email = data.get('email')
        phone = data.get('phone')
        address = data.get('address')
        city = data.get('city')
        state = data.get('state')
        postal_code = data.get('postalcode')
        country = data.get('country')
        tax_id = data.get('taxid')
        registration_number = data.get('registrationnumber')
        additional_info = data.get('additionalinfo')
        currency_id = data.get('currency_id')
        status = data['status']
        partner_image = request.files['partnerimage'] if 'partnerimage' in request.files else None
        partner_image_data = partner_image.read() if partner_image else None

        # Log parsed data
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Partner Type: {partner_type}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Partner Name: {partner_name}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Contact Person: {contact_person}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Email: {email}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Phone: {phone}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Address: {address}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed City: {city}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed State: {state}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Postal Code: {postal_code}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Country: {country}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Tax ID: {tax_id}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Registration Number: {registration_number}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Additional Info: {additional_info}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Currency Code: {currency_id}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Status: {status}")
        if partner_image:
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Partner Image: File detected")
        else:
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Partner Image: Empty")

        mycursor = mydb.cursor()

        try:
            query = "INSERT INTO com.businesspartner (partnertype, partnername, contactperson, email, phone, address, city, state, postalcode, country, taxid, registrationnumber, additionalinfo, currency_id, status, customerimage, created_by, updated_by) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
            values = (partner_type, partner_name, contact_person, email, phone, address, city, state, postal_code, country, tax_id, registration_number, additional_info, currency_id, status, partner_image_data, current_userid, current_userid)
            
            mycursor.execute(query, values)
            mydb.commit()
            
            # Log success and close the cursor and connection
            logger.info(f"{USER_ID} --> {MODULE_NAME}: Partner data created successfully")
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Partner data created successfully'})
        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{USER_ID} --> {MODULE_NAME}: Unable to create partner data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500
    except Exception as e:
        # Log any exceptions
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
