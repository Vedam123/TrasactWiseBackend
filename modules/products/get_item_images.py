from flask import Blueprint, jsonify, request
import base64
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.utilities.logger import logger

# Define the Blueprint for item images API
get_item_images_api = Blueprint('get_item_images_api', __name__)

@get_item_images_api.route('/get_item_images', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_item_images():
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
    logger.debug(f"{appuser} --> {__name__}: Entered in the get item images function")

    # Get parameters from request
    item_id = request.args.get('item_id')
    mapping_id = request.args.get('mapping_id')

    # Check if at least one parameter is provided
    if not item_id and not mapping_id:
        return jsonify({'error': 'item_id or mapping_id is required'}), 400

    # Query to retrieve images, their order, and their IDs based on item_id or mapping_id
    image_query = """
    SELECT i.image, im.image_order, im.image_id
    FROM com.item_images i
    JOIN com.item_image_mapping im ON i.image_id = im.image_id
    WHERE {condition}
    ORDER BY im.image_order
    """

    if item_id:
        query_condition = "im.item_id = %s"
        query_params = (item_id,)
    else:
        query_condition = "im.mapping_id = %s"
        query_params = (mapping_id,)

    # Execute query
    mycursor = mydb.cursor()
    mycursor.execute(image_query.format(condition=query_condition), query_params)
    image_records = mycursor.fetchall()

    # Initialize the response with an empty list of images
    images = []

    for image_record in image_records:
        image_data = image_record[0]
        image_order = image_record[1]
        image_id = image_record[2]
        if image_data is not None:
            encoded_image = base64.b64encode(image_data).decode('utf-8')
            images.append({
                'image': encoded_image,
                'image_order': image_order,
                'image_id': image_id
            })

    # Close the cursor and connection
    mycursor.close()
    mydb.close()

    # Return all images along with their order and ID as a JSON response
    return jsonify({'images': images})
