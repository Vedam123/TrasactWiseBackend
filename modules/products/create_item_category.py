from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
import base64
from modules.security.permission_required import permission_required  # Import the decorator
from config import WRITE_ACCESS_TYPE    # Import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
#from logger import logger 
from modules.security.get_user_from_token import get_user_from_token

# Get a logger for this module
#logger = configure_logging()

create_item_category_api = Blueprint('create_item_category_api', __name__)

@create_item_category_api.route('/create_item_category', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE ,  __file__)  # Pass WRITE_ACCESS_TYPE as an argument
def create_item_category():
    MODULE_NAME = __name__ 
    token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None
    USER_ID = token_results['username']
    #logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the create categories data function")
    mydb = get_database_connection()
    current_userid = None
    authorization_header = request.headers.get('Authorization', '')
    if authorization_header.startswith('Bearer '):
        token = authorization_header.replace('Bearer ', '')
        decoded_token = decode_token(token)
        current_userid = decoded_token.get('Userid')
    print("Before JSON parsing the incoming requests")
    
    # Get the data from the request's JSON payload

    if request.content_type == 'application/json':
        data = request.get_json()
    else:
        data = request.form

    category_name = data.get('category_name')
    description = data.get('description')
    is_active = data.get('is_active')
    tax_information = data.get('tax_information')
    default_uom = data.get('uom_id')
    # image is no longer included in the request JSON
    image = request.files['image'] if 'image' in request.files else None
    image_data = image.read() if image else None

    print(data)

    print("category_name :", category_name)
    print("description :", description)
    print("is_active :", is_active)
    print("tax_information :", tax_information)
    print("default_uom :", default_uom)
   ## print("image_data :", image_data)
    if image:
        print("Parsed Categrory file Image: File detected")
    else:
        print("Parsed Categrory file Image: Empty")

    print("Got parsed the incoming requests", category_name, description,is_active,tax_information,default_uom,image)

    # Validate the required fields
    if not category_name or not description or not is_active or not tax_information or not default_uom:
        print("category_name :", category_name)
        print("description :", description)
        print("is_active :", is_active)
        print("tax_information :", tax_information)
        print("default_uom :", default_uom)
        return jsonify({'message': 'category_name, description, is_active, tax_information, and default_uom are required fields.'}), 400

    # Insert new item category into the database
    query = "INSERT INTO com.itemcategory (category_name, description, is_active, tax_information, default_uom, image,created_by,updated_by) VALUES (%s, %s, %s, %s, %s, %s,%s,%s)"
    values = (category_name, description, is_active, tax_information, default_uom, image_data,current_userid,current_userid)

    mycursor = mydb.cursor()
    try:
        mycursor.execute(query, values)
        mydb.commit()
        category_id = mycursor.lastrowid
        mycursor.close()
        mydb.close()
        # Return the newly created item category as JSON response
        return jsonify({'category_id': category_id, 'category_name': category_name, 'description': description, 'is_active': is_active, 'tax_information': tax_information, 'default_uom': default_uom}), 201

    except Exception as e:
        mycursor.close()
        mydb.close()
        return jsonify({'message': 'Failed to create item category.', 'error': str(e)}), 500
