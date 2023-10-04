from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required  # Import the decorator
from config import WRITE_ACCESS_TYPE    # Import 
from flask_jwt_extended import decode_token

create_partner_data_api = Blueprint('create_partner_data_api', __name__)

@create_partner_data_api.route('/create_partner_data', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE ,  __file__)  # Pass WRITE_ACCESS_TYPE as an argument
def create_partner_data():
    mydb = get_database_connection()
    
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

    print(data)

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
    currency_code = data.get('currencycode')
    status = data['status']
    partner_image = request.files['partnerimage'] if 'partnerimage' in request.files else None
    partner_image_data = partner_image.read() if partner_image else None

    print("Parsed Partner Type:", partner_type)
    print("Parsed Partner Name:", partner_name)
    print("Parsed Contact Person:", contact_person)
    print("Parsed Email:", email)
    print("Parsed Phone:", phone)
    print("Parsed Address:", address)
    print("Parsed City:", city)
    print("Parsed State:", state)
    print("Parsed Postal Code:", postal_code)
    print("Parsed Country:", country)
    print("Parsed Tax ID:", tax_id)
    print("Parsed Registration Number:", registration_number)
    print("Parsed Additional Info:", additional_info)
    print("Parsed Currency Code:", currency_code)
    print("Parsed Status:", status)
    if partner_image:
        print("Parsed Partner Image: File detected")
    else:
        print("Parsed Partner Image: Empty")

    mycursor = mydb.cursor()

    try:
        query = "INSERT INTO com.businesspartner (partnertype, partnername, contactperson, email, phone, address, city, state, postalcode, country, taxid, registrationnumber, additionalinfo, currencycode, status, customerimage,created_by,updated_by) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
        values = (partner_type, partner_name, contact_person, email, phone, address, city, state, postal_code, country, tax_id, registration_number, additional_info, currency_code, status, partner_image_data,current_userid,current_userid)

        mycursor.execute(query, values)
        mydb.commit()
        # Close the cursor and connection
        mycursor.close()
        mydb.close()
        return jsonify({'message': 'Partner data created successfully'})
    except Exception as e:
        # Close the cursor and connection
        mycursor.close()
        mydb.close()
        print("Unable to create partner data:", str(e))
        return jsonify({'error': str(e)}), 500
