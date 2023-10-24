import json
import logging  # Import the logging module
from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
import base64
from modules.security.permission_required import permission_required  # Import the decorator
from config import WRITE_ACCESS_TYPE  # Import WRITE_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger  # Import the logger module

create_item_api = Blueprint('create_item_api', __name__)

@create_item_api.route('/create_item', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)  # Pass WRITE_ACCESS_TYPE as an argument
def create_item():
    authorization_header = request.headers.get('Authorization')
    token_results = ""
    USER_ID = ""
    MODULE_NAME = __name__
    if authorization_header:
        token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None

    if token_results:
        USER_ID = token_results["username"]

    # Log entry point
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the create item data function")

    mydb = get_database_connection(USER_ID, MODULE_NAME)

    # Get the data from the request's JSON payload
    data = request.json
    item_code = data.get('item_code')
    item_name = data.get('item_name')
    category_id = data.get('category_id')
    unit_price = data.get('unit_price')
    manufacturer = data.get('manufacturer')
    barcode = data.get('barcode')
    stock_quantity = data.get('stock_quantity')
    min_stock_level = data.get('min_stock_level')
    max_stock_level = data.get('max_stock_level')
    reorder_point = data.get('reorder_point')
    lead_time = data.get('lead_time')
    shelf_life = data.get('shelf_life')
    location = data.get('location')
    item_image = data.get('item_image')
    notes = data.get('notes')
    product_type = data.get('product_type')

    # Validate the required fields
    if not item_code or not item_name or not category_id or not unit_price:
        logger.warning(f"{USER_ID} --> {MODULE_NAME}: Required fields are missing: item_code=%s, item_name=%s, category_id=%s, unit_price=%s",
                       item_code, item_name, category_id, unit_price)
        return jsonify({'message': 'item_code, item_name, category_id, and unit_price are required fields.'}), 400

    # Convert the base64-encoded item image to binary
    image_base64 = None
    if item_image is not None:
        try:
            item_image = base64.b64decode(item_image.encode('utf-8'))
            image_base64 = base64.b64encode(item_image).decode('utf-8')
        except Exception as e:
            logger.error(f"{USER_ID} --> {MODULE_NAME}: Failed to decode image: %s", str(e))
            return jsonify({'message': 'Failed to decode image.', 'error': str(e)}), 400

    # Insert a new item into the database
    query = "INSERT INTO com.items (item_code, item_name, category_id, unit_price, manufacturer, barcode, stock_quantity, min_stock_level, max_stock_level, reorder_point, lead_time, shelf_life, location, item_image, notes, product_type) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
    values = (item_code, item_name, category_id, unit_price, manufacturer, barcode, stock_quantity, min_stock_level, max_stock_level, reorder_point, lead_time, shelf_life, location, item_image, notes, product_type)

    mycursor = mydb.cursor()
    try:
        mycursor.execute(query, values)
        mydb.commit()
        item_id = mycursor.lastrowid
        mycursor.close()
        mydb.close()

        # Log successful creation
        logger.info(f"{USER_ID} --> {MODULE_NAME}: Item created: item_id=%s, item_code=%s, item_name=%s, category_id=%s, unit_price=%s, manufacturer=%s, barcode=%s, stock_quantity=%s, min_stock_level=%s, max_stock_level=%s, reorder_point=%s, lead_time=%s, shelf_life=%s, location=%s, item_image=%s, notes=%s, product_type=%s",
                    item_id, item_code, item_name, category_id, unit_price, manufacturer, barcode, stock_quantity, min_stock_level, max_stock_level, reorder_point, lead_time, shelf_life, location, bool(image_base64), notes, product_type)

        # Return the newly created item as a JSON response
        return jsonify({'item_id': item_id, 'item_code': item_code, 'item_name': item_name, 'category_id': category_id, 'unit_price': unit_price, 'manufacturer': manufacturer, 'barcode': barcode, 'stock_quantity': stock_quantity, 'min_stock_level': min_stock_level, 'max_stock_level': max_stock_level, 'reorder_point': reorder_point, 'lead_time': lead_time, 'shelf_life': shelf_life, 'location': location, 'item_image': image_base64, 'notes': notes, 'product_type': product_type}), 201
    except Exception as e:
        mycursor.close()
        mydb.close()

        # Log the error
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Failed to create item: %s", str(e))

        return jsonify({'message': 'Failed to create item.', 'error': str(e)}), 500
