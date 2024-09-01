from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from flask_jwt_extended import decode_token
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

create_items_api = Blueprint('create_items_api', __name__)

@create_items_api.route('/create_items', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_items():
    authorization_header = request.headers.get('Authorization')
    token_results = ""
    USER_ID = ""
    MODULE_NAME = __name__
    
    if authorization_header:
        token_results = get_user_from_token(authorization_header) if authorization_header else None

    if token_results:
        USER_ID = token_results["username"]
    
    if request.content_type == 'application/json':
        data = request.get_json()
    else:
        data = request.form

    # Log entry point
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the create item data function")

    mydb = get_database_connection(USER_ID, MODULE_NAME)

    current_userid = None
    if authorization_header.startswith('Bearer '):
        token = authorization_header.replace('Bearer ', '')
        decoded_token = decode_token(token)
        current_userid = decoded_token.get('Userid')

    # Get the data from the request's form data
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Received Input {data}")
    item_code = data.get('item_code')
    item_name = data.get('item_name')
    category_id = data.get('category_id')
    manufacturer = data.get('manufacturer')
    barcode = data.get('barcode') or None
    stock_quantity = data.get('stock_quantity') or None
    min_stock_level = data.get('min_stock_level') or None
    max_stock_level = data.get('max_stock_level') or None
    reorder_point = data.get('reorder_point') or None
    lead_time = data.get('lead_time') or None
    shelf_life = data.get('shelf_life') or None
    location = data.get('location') or None
    product_type = data.get('product_type')
    notes = data.get('notes')
    default_uom_id = data.get('default_uom_id')
    expiry_date_flag = data.get('expiry_date_flag') == 'true'  # Convert to boolean
    expiry_date = data.get('expiry_date') or None

    # Handle multiple file uploads
    image_files = request.files.getlist('item_images')
    
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Received Image files  {image_files}")

    # Validate the required fields (remove unit_price validation)
    if not item_code or not item_name or not category_id:
        logger.warning(f"{USER_ID} --> {MODULE_NAME}: Required fields are missing: item_code=%s, item_name=%s, category_id=%s",
                       item_code, item_name, category_id)
        return jsonify({'message': 'item_code, item_name, and category_id are required fields.'}), 400

    try:
        # Insert a new item into the database (remove unit_price from query and values)
       # Corrected SQL query after removing unit_price
        item_query = """
            INSERT INTO com.items 
            (item_code, item_name, category_id, manufacturer, barcode, stock_quantity, min_stock_level, 
            max_stock_level, reorder_point, lead_time, shelf_life, location, product_type, notes, 
            default_uom_id, expiry_date_flag, expiry_date, created_by, updated_by) 
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        # Corresponding values tuple without unit_price
        item_values = (
            item_code, item_name, category_id, manufacturer, barcode, stock_quantity, min_stock_level, 
            max_stock_level, reorder_point, lead_time, shelf_life, location, product_type, notes, 
            default_uom_id, expiry_date_flag, expiry_date, current_userid, current_userid
        )


        mycursor = mydb.cursor()
        mycursor.execute(item_query, item_values)
        item_id = mycursor.lastrowid

        # Handle multiple images
        image_query = """
            INSERT INTO com.item_images (image, image_type, created_by, updated_by) 
            VALUES (%s, %s, %s, %s)
        """
        mapping_query = """
            INSERT INTO com.item_image_mapping (item_id, image_id, image_order) 
            VALUES (%s, %s, %s)
        """
        
        for order, image_file in enumerate(image_files, start=1):
            try:
                image_binary = image_file.read()
                image_type = image_file.content_type  # Get the MIME type of the image

                # Insert image into item_images table
                mycursor.execute(image_query, (image_binary, image_type, current_userid, current_userid))
                image_id = mycursor.lastrowid

                # Map image to the item in item_image_mapping table
                mycursor.execute(mapping_query, (item_id, image_id, order))
            except Exception as e:
                logger.error(f"{USER_ID} --> {MODULE_NAME}: Failed to process image: %s", str(e))
                mydb.rollback()
                return jsonify({'message': 'Failed to process image.', 'error': str(e)}), 400

        mydb.commit()
        mycursor.close()
        mydb.close()

        # Log successful creation
        logger.info(f"{USER_ID} --> {MODULE_NAME}: Item created with item_id=%s", item_id)

        # Return the newly created item as a JSON response (remove unit_price from response)
        return jsonify({
            'item_id': item_id, 'item_code': item_code, 'item_name': item_name, 'category_id': category_id, 
            'manufacturer': manufacturer, 'barcode': barcode, 'stock_quantity': stock_quantity, 
            'min_stock_level': min_stock_level, 'max_stock_level': max_stock_level, 'reorder_point': reorder_point, 
            'lead_time': lead_time, 'shelf_life': shelf_life, 'location': location, 'product_type': product_type, 
            'notes': notes, 'default_uom_id': default_uom_id, 'expiry_date_flag': expiry_date_flag, 
            'expiry_date': expiry_date
        }), 201
    except Exception as e:
        mycursor.close()
        mydb.close()

        # Log the error
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Failed to create item: %s", str(e))

        return jsonify({'message': 'Failed to create item.', 'error': str(e)}), 500
