from flask import Blueprint, jsonify, request
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.security.permission_required import permission_required  # Import the decorator
from config import WRITE_ACCESS_TYPE  # Import 
from modules.utilities.logger import logger  # Import the logger module

create_partner_data_api = Blueprint('create_partner_data_api', __name__)

@create_partner_data_api.route('/create_partner_data', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE ,  __file__)  # Pass WRITE_ACCESS_TYPE as an argument
def create_partner_data():
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
        logger.debug(f"{appuser} --> {__name__}: Entered in the create partner data function")      
              
        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        # Log the received data
        logger.debug(f"{appuser} --> {__name__}: Received data: {data}")

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
        logger.debug(f"{appuser} --> {__name__}: Parsed Partner Type: {partner_type}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Partner Name: {partner_name}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Contact Person: {contact_person}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Email: {email}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Phone: {phone}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Address: {address}")
        logger.debug(f"{appuser} --> {__name__}: Parsed City: {city}")
        logger.debug(f"{appuser} --> {__name__}: Parsed State: {state}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Postal Code: {postal_code}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Country: {country}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Tax ID: {tax_id}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Registration Number: {registration_number}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Additional Info: {additional_info}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Currency Code: {currency_id}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Status: {status}")
        if partner_image:
            logger.debug(f"{appuser} --> {__name__}: Parsed Partner Image: File detected")
        else:
            logger.debug(f"{appuser} --> {__name__}: Parsed Partner Image: Empty")

        mycursor = mydb.cursor()

        try:
            query = "INSERT INTO com.businesspartner (partnertype, partnername, contactperson, email, phone, address, city, state, postalcode, country, taxid, registrationnumber, additionalinfo, currency_id, status, customerimage, created_by, updated_by) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
            values = (partner_type, partner_name, contact_person, email, phone, address, city, state, postal_code, country, tax_id, registration_number, additional_info, currency_id, status, partner_image_data, appuserid, appuserid)
            
            mycursor.execute(query, values)
            mydb.commit()
            
            # Log success and close the cursor and connection
            logger.info(f"{appuser} --> {__name__}: Partner data created successfully")
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Partner data created successfully'})
        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{appuser} --> {__name__}: Unable to create partner data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500
    except Exception as e:
        # Log any exceptions
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
