from flask import Blueprint, jsonify, request
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger

# Define the Blueprint for item images API
create_item_images_api = Blueprint('create_item_images_api', __name__)

@create_item_images_api.route('/create_item_images', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_item_images():
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

    logger.debug(f"{appuser} --> {__name__}: Entered in the create item images function")

    logger.debug(f"{appuser} --> {__name__}: After Database connected: {mydb1}")

    # Retrieve item_id from form data
    item_id = request.form.get('item_id')
    if not item_id:
        return jsonify({'error': 'item_id is required'}), 400

    # Retrieve images from request.files
    images = request.files.getlist('item_images')

    if not images:
        return jsonify({'error': 'At least one image is required'}), 400

    try:
        mycursor = mydb1.cursor()

        # Get the maximum image_order for the given item_id
        get_max_order_query = "SELECT COALESCE(MAX(image_order), 0) FROM com.item_image_mapping WHERE item_id = %s"
        mycursor.execute(get_max_order_query, (item_id,))
        max_image_order = mycursor.fetchone()[0]

        image_query = """
            INSERT INTO com.item_images (image, image_type, created_by, updated_by) 
            VALUES (%s, %s, %s, %s)
        """
        mapping_query = """
            INSERT INTO com.item_image_mapping (item_id, image_id, image_order) 
            VALUES (%s, %s, %s)
        """

        for order, file in enumerate(images, start=max_image_order + 1):
            try:
                image_binary = file.read()
                image_type = file.content_type  # 'image/jpeg', 'image/png'

                # Insert image into item_images table
                mycursor.execute(image_query, (image_binary, image_type, appuserid, appuserid))
                image_id = mycursor.lastrowid

                # Map image to the item in item_image_mapping table
                mycursor.execute(mapping_query, (item_id, image_id, order))
            except Exception as e:
                logger.error(f"{appuser} --> {__name__}: Failed to process image: %s", str(e))
                mydb1.rollback()
                return jsonify({'error': 'Failed to process one or more images.', 'details': str(e)}), 400

        mydb1.commit()
        logger.info(f"{appuser} --> {__name__}: Images successfully inserted for item_id={item_id}")

        return jsonify({'message': 'Images successfully inserted.'}), 200

    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Failed to insert images: %s", str(e))
        return jsonify({'error': 'Failed to insert images.', 'details': str(e)}), 500
    finally:
        if mycursor:
            mycursor.close()
        if mydb1:
            mydb1.close()
