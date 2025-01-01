from flask import Blueprint, jsonify, request
from modules.security.routines.get_user_and_db_details import get_user_and_db_details	
from modules.security.permission_required import permission_required
from config import UPDATE_ACCESS_TYPE
from modules.utilities.logger import logger

# Define the Blueprint for updating item images API
update_item_category_image_api = Blueprint('update_item_category_image_api', __name__)

@update_item_category_image_api.route('/update_item_category_image', methods=['PUT'])
@permission_required(UPDATE_ACCESS_TYPE, __file__)
def update_item_category_image():
    authorization_header = request.headers.get('Authorization')
    try:
        company, instance, dbuser, mydb1, appuser, appuserid, user_info, employee_info = get_user_and_db_details(authorization_header)
        logger.debug(f"{appuser} --> {__name__}: Successfully retrieved user details from the token.")
    except ValueError as e:
        logger.error(f"Failed to retrieve user details from token. Error: {str(e)}")
        return jsonify({"error": str(e)}), 401
    
    if not appuser:
        logger.error(f"Unauthorized access attempt: {appuser} --> {__name__}: Application user not found.")
        return jsonify({"error": "Unauthorized. Username not found."}), 401

    logger.debug(f"{appuser} --> {__name__}: Entered in the update item image function")  
    logger.debug(f"{appuser} --> {__name__}: After authorization check ")

    # Retrieve category_id and image_id from request.form
    category_id = request.form.get('category_id')
    image_id = request.form.get('image_id')
    new_image_file = request.files.get('new_image_file')

    logger.debug(f"{appuser} --> {__name__}: Input category id  --> {category_id}")  
    logger.debug(f"{appuser} --> {__name__}: Input Image Id  --> {image_id}")  
    logger.debug(f"{appuser} --> {__name__}: Input new Image file  --> {new_image_file}")  

    if not category_id or not image_id:
        return jsonify({'error': 'category_id and image_id are required'}), 400

    if not new_image_file:
        return jsonify({'error': 'new_image_file is required'}), 400

    try:
        mycursor = mydb1.cursor()

        # Check if the category_id and image_id exist in the mapping table
        mapping_check_query = """
            SELECT COUNT(*) FROM com.category_image_mapping
            WHERE category_id = %s AND image_id = %s
        """
        mycursor.execute(mapping_check_query, (category_id, image_id))
        if mycursor.fetchone()[0] == 0:
            return jsonify({'error': 'category_id or image_id not found in the mapping table'}), 404

        # Update the image in com.category_imagestable
        update_image_query = """
            UPDATE com.category_images
            SET image = %s, image_type = %s, updated_by = %s 
            WHERE image_id = %s
        """

        # Read the new image file and get its type
        image_binary = new_image_file.read()
        image_type = new_image_file.content_type  # 'image/jpeg', 'image/png'

        # Execute the update query
        mycursor.execute(update_image_query, (image_binary, image_type, appuserid, image_id))

        mydb1.commit()
        logger.info(f"{appuser} --> {__name__}: Image successfully updated for category_id={category_id}, image_id={image_id}")

        return jsonify({'message': 'Image successfully updated.'}), 200

    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Failed to update image: %s", str(e))
        return jsonify({'error': 'Failed to update image.', 'details': str(e)}), 500

    finally:
        if mycursor:
            mycursor.close()
        if mydb1:
            mydb1.close()
