from flask import Blueprint, jsonify, request
import base64
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import READ_ACCESS_TYPE
from modules.utilities.logger import logger

list_item_categories_api = Blueprint('list_item_categories_api', __name__)

@list_item_categories_api.route('/list_item_categories', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def list_item_categories():
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
    logger.debug(f"{appuser} --> {__name__}: Entered in the list item categories data function")

    # Retrieve query parameters (optional)
    category_id = request.args.get('category_id')
    category_name = request.args.get('category_name')

    # Base query
    query = "SELECT * FROM com.itemcategory"
    filters = []
    values = []

    # Add conditions based on parameters
    if category_id:
        filters.append("category_id = %s")
        values.append(category_id)
    if category_name:
        filters.append("category_name LIKE %s")
        values.append(f"%{category_name}%")

    if filters:
        query += " WHERE " + " AND ".join(filters)

    # Execute query
    mycursor = mydb.cursor()
    mycursor.execute(query, values)
    item_categories = mycursor.fetchall()

    item_category_list = []

    for category in item_categories:
        category_id = category[0]
        category_name = category[1]
        description = category[2]
        is_active = category[3]
        tax_information = category[4]
        default_uom = category[5]

        # Initialize the image as None
        image_data = None

        # Query to get the image ID with image_order 1
        image_mapping_query = """
        SELECT image_id 
        FROM com.category_image_mapping 
        WHERE category_id = %s AND image_order = 1
        """
        mycursor.execute(image_mapping_query, (category_id,))
        image_mapping = mycursor.fetchone()

        if image_mapping:
            image_id = image_mapping[0]

            # Query to get the image data
            image_query = """
            SELECT image 
            FROM com.category_images 
            WHERE image_id = %s
            """
            mycursor.execute(image_query, (image_id,))
            image_record = mycursor.fetchone()

            if image_record:
                image_data = image_record[0]
                if image_data is not None:
                    image_data = base64.b64encode(image_data).decode('utf-8')

        # Construct the category dictionary
        item_category_dict = {
            'category_id': category_id,
            'category_name': category_name,
            'description': description,
            'is_active': is_active,
            'tax_information': tax_information,
            'default_uom': default_uom,
            'image': image_data,
        }
        item_category_list.append(item_category_dict)

    # Close the cursor and connection
    mycursor.close()
    mydb.close()

    # Return the list of item categories as JSON response
    return jsonify({'item_categories': item_category_list})
