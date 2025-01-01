from flask import Blueprint, jsonify, request
import base64
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import READ_ACCESS_TYPE
from modules.utilities.logger import logger  # Import the logger module

list_items_api = Blueprint('list_items_api', __name__)

@list_items_api.route('/list_items', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def list_items():
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
    logger.debug(f"{appuser} --> {__name__}: Entered in the list items data function")

    # Retrieve the item_id or item_code from query parameters
    item_id = request.args.get('item_id')
    item_code = request.args.get('item_code')

    mycursor = mydb.cursor()

    # If item_id or item_code is provided, filter the query accordingly
    if item_id:
        query = "SELECT * FROM com.items WHERE item_id = %s"
        mycursor.execute(query, (item_id,))
    elif item_code:
        query = "SELECT * FROM com.items WHERE item_code = %s"
        mycursor.execute(query, (item_code,))
    else:
        # If no filters are provided, fetch all items
        query = "SELECT * FROM com.items"
        mycursor.execute(query)

    items = mycursor.fetchall()

    # If no items were found, return a 404 response
    if not items:
        return jsonify({'message': 'No items found with the provided item_code or item_id.'}), 404

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
