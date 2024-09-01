from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
import base64
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger  # Import the logger module

list_items_api = Blueprint('list_items_api', __name__)

@list_items_api.route('/list_items', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def list_items():
    authorization_header = request.headers.get('Authorization')
    token_results = ""
    USER_ID = ""
    MODULE_NAME = __name__
    
    if authorization_header:
        token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None

    if token_results:
        USER_ID = token_results["username"]

    # Log entry point
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the list items data function")
    mydb = get_database_connection(USER_ID, MODULE_NAME)

    # Retrieve all items from the database
    query = "SELECT * FROM com.items"
    mycursor = mydb.cursor()
    mycursor.execute(query)
    items = mycursor.fetchall()

    # Get the column names from the cursor's description
    column_names = [desc[0] for desc in mycursor.description]

    # Convert the item data into a list of dictionaries
    item_list = []
    for item_data in items:
        item_dict = {}
        item_id = None
        
        for i, value in enumerate(item_data):
            column_name = column_names[i]
            item_dict[column_name] = value
            if column_name == 'item_id':
                item_id = value

        # Fetch the image data based on the item_id
        if item_id:
            image_data = None

            # Query to get the image ID with image_order 1
            image_mapping_query = """
            SELECT image_id 
            FROM com.item_image_mapping 
            WHERE item_id = %s AND image_order = 1
            """
            mycursor.execute(image_mapping_query, (item_id,))
            image_mapping = mycursor.fetchone()

            if image_mapping:
                image_id = image_mapping[0]

                # Query to get the image data
                image_query = """
                SELECT image 
                FROM com.item_images 
                WHERE image_id = %s
                """
                mycursor.execute(image_query, (image_id,))
                image_record = mycursor.fetchone()

                if image_record:
                    image_data = image_record[0]
                    if image_data is not None:
                        image_data = base64.b64encode(image_data).decode('utf-8')

            # Add the image to the item dictionary
            item_dict['item_image'] = image_data

        item_list.append(item_dict)

    # Close the cursor and connection
    mycursor.close()
    mydb.close()

    # Return the list of items as JSON response
    return jsonify({'items': item_list})
