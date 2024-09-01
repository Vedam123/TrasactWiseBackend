from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
import base64
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

list_item_categories_api = Blueprint('list_item_categories_api', __name__)

@list_item_categories_api.route('/list_item_categories', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def list_item_categories():
    authorization_header = request.headers.get('Authorization')
    token_results = ""
    USER_ID = ""
    MODULE_NAME = __name__
    
    if authorization_header:
        token_results = get_user_from_token(authorization_header) if authorization_header else None

    if token_results:
        USER_ID = token_results["username"]

    # Log entry point
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the list item categories data function")
    mydb = get_database_connection(USER_ID, MODULE_NAME)

    # Retrieve all item categories from the database
    query = "SELECT * FROM com.itemcategory"
    mycursor = mydb.cursor()
    mycursor.execute(query)
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
