import json
import logging
import mimetypes
from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
create_item_category_api = Blueprint('create_item_category_api', __name__)

@create_item_category_api.route('/create_item_category', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_item_category():
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

    logger.debug(f"{appuser} --> {__name__}: Entered the create categories data function")
    
       
    logger.info(f"{appuser} --> {__name__}: Before JSON parsing the incoming requests")

    # Get the data from the request's JSON payload
    if request.content_type == 'application/json':
        data = request.get_json()
    else:
        data = request.form


    logger.debug(f"{appuser} --> {__name__}: Received Input {data}")
    
    category_name = data.get('category_name')
    description = data.get('description')
    is_active = data.get('is_active')
    tax_information = data.get('tax_information')
    default_uom = data.get('uom_id')

    # Handling images
    images = request.files.getlist('images')  # Assuming images are sent as a list of files

    logger.debug(f"{appuser} --> {__name__}: Received Image files  {images}")

    logger.info(f"{appuser} --> {__name__}: Parsed Request Data: %s", data)

    # Validate the required fields
    if not category_name or not description or not is_active or not tax_information or not default_uom:
        logger.warning(f"{appuser} --> {__name__}: Required fields are missing: category_name=%s, description=%s, is_active=%s, tax_information=%s, default_uom=%s",
                       category_name, description, is_active, tax_information, default_uom)
        return jsonify({'message': 'category_name, description, is_active, tax_information, and default_uom are required fields.'}), 400

    # Insert a new item category into the database
    query = "INSERT INTO com.itemcategory (category_name, description, is_active, tax_information, default_uom, created_by, updated_by) VALUES (%s, %s, %s, %s, %s, %s, %s)"
    values = (category_name, description, is_active, tax_information, default_uom, appuserid, appuserid)

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
                image_values = (image_data, image_type, appuserid, appuserid)
                
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
        logger.info(f"{appuser} --> {__name__}: Item category created: category_id=%s, category_name=%s, description=%s, is_active=%s, tax_information=%s, default_uom=%s", 
                    category_id, category_name, description, is_active, tax_information, default_uom)

        # Return the newly created item category as a JSON response
        return jsonify({'category_id': category_id, 'category_name': category_name, 'description': description, 'is_active': is_active, 'tax_information': tax_information, 'default_uom': default_uom}), 201
    except Exception as e:
        mycursor.close()
        mydb.close()

        # Log the error
        logger.error(f"{appuser} --> {__name__}: Failed to create item category: %s", str(e))

        return jsonify({'message': 'Failed to create item category.', 'error': str(e)}), 500
