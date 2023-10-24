import json
import logging  # Import the logging module
from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
import base64
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger  # Import the logger module

create_item_category_api = Blueprint('create_item_category_api', __name__)

@create_item_category_api.route('/create_item_category', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)  # Pass WRITE_ACCESS_TYPE as an argument
def create_item_category():
    authorization_header = request.headers.get('Authorization')
    token_results = ""
    USER_ID = ""
    MODULE_NAME = __name__
    if authorization_header:
        token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None

    if token_results:
        USER_ID = token_results["username"]

    # Log entry point
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the create categories data function")
    
    mydb = get_database_connection(USER_ID, MODULE_NAME)
    current_userid = None
    authorization_header = request.headers.get('Authorization', '')
    
    if authorization_header.startswith('Bearer '):
        token = authorization_header.replace('Bearer ', '')
        decoded_token = decode_token(token)
        current_userid = decoded_token.get('Userid')
    
    logger.info(f"{USER_ID} --> {MODULE_NAME}: Before JSON parsing the incoming requests")

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

    logger.info(f"{USER_ID} --> {MODULE_NAME}: Parsed Request Data: %s", data)
    logger.info(f"{USER_ID} --> {MODULE_NAME}: category_name: %s", category_name)
    logger.info(f"{USER_ID} --> {MODULE_NAME}: description: %s", description)
    logger.info(f"{USER_ID} --> {MODULE_NAME}: is_active: %s", is_active)
    logger.info(f"{USER_ID} --> {MODULE_NAME}: tax_information: %s", tax_information)
    logger.info(f"{USER_ID} --> {MODULE_NAME}: default_uom: %s", default_uom)

    if image:
        logger.info(f"{USER_ID} --> {MODULE_NAME}: Parsed Category Image: File detected")
    else:
        logger.info(f"{USER_ID} --> {MODULE_NAME}: Parsed Category Image: Empty")

    logger.info(f"{USER_ID} --> {MODULE_NAME}: Parsed the incoming requests: category_name=%s, description=%s, is_active=%s, tax_information=%s, default_uom=%s, image=%s",
                category_name, description, is_active, tax_information, default_uom, bool(image))

    # Validate the required fields
    if not category_name or not description or not is_active or not tax_information or not default_uom:
        logger.warning(f"{USER_ID} --> {MODULE_NAME}: Required fields are missing: category_name=%s, description=%s, is_active=%s, tax_information=%s, default_uom=%s",
                       category_name, description, is_active, tax_information, default_uom)
        return jsonify({'message': 'category_name, description, is_active, tax_information, and default_uom are required fields.'}), 400

    # Insert a new item category into the database
    query = "INSERT INTO com.itemcategory (category_name, description, is_active, tax_information, default_uom, image, created_by, updated_by) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"
    values = (category_name, description, is_active, tax_information, default_uom, image_data, current_userid, current_userid)

    mycursor = mydb.cursor()
    try:
        mycursor.execute(query, values)
        mydb.commit()
        category_id = mycursor.lastrowid
        mycursor.close()
        mydb.close()

        # Log successful creation
        logger.info(f"{USER_ID} --> {MODULE_NAME}: Item category created: category_id=%s, category_name=%s, description=%s, is_active=%s, tax_information=%s, default_uom=%s", 
                    category_id, category_name, description, is_active, tax_information, default_uom)

        # Return the newly created item category as a JSON response
        return jsonify({'category_id': category_id, 'category_name': category_name, 'description': description, 'is_active': is_active, 'tax_information': tax_information, 'default_uom': default_uom}), 201
    except Exception as e:
        mycursor.close()
        mydb.close()

        # Log the error
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Failed to create item category: %s", str(e))

        return jsonify({'message': 'Failed to create item category.', 'error': str(e)}), 500
