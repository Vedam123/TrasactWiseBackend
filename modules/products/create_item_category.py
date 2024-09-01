import json
import logging
import mimetypes
from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

create_item_category_api = Blueprint('create_item_category_api', __name__)

@create_item_category_api.route('/create_item_category', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_item_category():
    authorization_header = request.headers.get('Authorization')
    token_results = ""
    USER_ID = ""
    MODULE_NAME = __name__
    
    if authorization_header:
        token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None

    if token_results:
        USER_ID = token_results["username"]

    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the create categories data function")
    
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

    # Handling images
    images = request.files.getlist('images')  # Assuming images are sent as a list of files

    logger.info(f"{USER_ID} --> {MODULE_NAME}: Parsed Request Data: %s", data)

    # Validate the required fields
    if not category_name or not description or not is_active or not tax_information or not default_uom:
        logger.warning(f"{USER_ID} --> {MODULE_NAME}: Required fields are missing: category_name=%s, description=%s, is_active=%s, tax_information=%s, default_uom=%s",
                       category_name, description, is_active, tax_information, default_uom)
        return jsonify({'message': 'category_name, description, is_active, tax_information, and default_uom are required fields.'}), 400

    # Insert a new item category into the database
    query = "INSERT INTO com.itemcategory (category_name, description, is_active, tax_information, default_uom, created_by, updated_by) VALUES (%s, %s, %s, %s, %s, %s, %s)"
    values = (category_name, description, is_active, tax_information, default_uom, current_userid, current_userid)

    mycursor = mydb.cursor()
    try:
        mycursor.execute(query, values)
        mydb.commit()
        category_id = mycursor.lastrowid

        # If images are provided, process and insert them
        if images:
            for index, image in enumerate(images):
                # Determine the MIME type of the image
                image_type = mimetypes.guess_type(image.filename)[0] or 'unknown'
                
                # Read the image data
                image_data = image.read()
                
                # Insert the image data into com.category_images
                image_query = "INSERT INTO com.category_images (image, image_type, created_by, updated_by) VALUES (%s, %s, %s, %s)"
                image_values = (image_data, image_type, current_userid, current_userid)
                
                mycursor.execute(image_query, image_values)
                mydb.commit()
                image_id = mycursor.lastrowid

                # Insert mapping into com.category_image_mapping with image_order
                mapping_query = "INSERT INTO com.category_image_mapping (category_id, image_id, image_order, created_at, updated_at) VALUES (%s, %s, %s, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP)"
                mapping_values = (category_id, image_id, index + 1)  # Image order starts from 1
                
                mycursor.execute(mapping_query, mapping_values)
                mydb.commit()

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
