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
        token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None

    if token_results:
        USER_ID = token_results["username"]

    # Log entry point
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the create item data function")

    mydb = get_database_connection(USER_ID, MODULE_NAME)

    current_userid = None
    authorization_header = request.headers.get('Authorization', '')
    if authorization_header.startswith('Bearer '):
        token = authorization_header.replace('Bearer ', '')
        decoded_token = decode_token(token)
        current_userid = decoded_token.get('Userid')

    # Get the data from the request's form data
    item_code = request.form.get('item_code')
    item_name = request.form.get('item_name')
    category_id = request.form.get('category_id')
    unit_price = request.form.get('unit_price')
    manufacturer = request.form.get('manufacturer')
    barcode = request.form.get('barcode')
    stock_quantity = request.form.get('stock_quantity')
    min_stock_level = request.form.get('min_stock_level')
    max_stock_level = request.form.get('max_stock_level')
    reorder_point = request.form.get('reorder_point')
    lead_time = request.form.get('lead_time')
    shelf_life = request.form.get('shelf_life') or None
    location = request.form.get('location')
    product_type = request.form.get('product_type')
    notes = request.form.get('notes')
    default_uom_id = request.form.get('default_uom_id')
    expiry_date_flag = request.form.get('expiry_date_flag') == 'true'  # Convert to boolean
    expiry_date = request.form.get('expiry_date') or None

    # Handle file upload
    item_image = request.files.get('item_image')
    image_binary = None
    if item_image:
        try:
            image_binary = item_image.read()
        except Exception as e:
            logger.error(f"{USER_ID} --> {MODULE_NAME}: Failed to process image: %s", str(e))
            return jsonify({'message': 'Failed to process image.', 'error': str(e)}), 400

    # Validate the required fields
    if not item_code or not item_name or not category_id or not unit_price:
        logger.warning(f"{USER_ID} --> {MODULE_NAME}: Required fields are missing: item_code=%s, item_name=%s, category_id=%s, unit_price=%s",
                       item_code, item_name, category_id, unit_price)
        return jsonify({'message': 'item_code, item_name, category_id, and unit_price are required fields.'}), 400

    # Insert a new item into the database
    query = """
        INSERT INTO com.items 
        (item_code, item_name, category_id, unit_price, manufacturer, barcode, stock_quantity, min_stock_level, 
        max_stock_level, reorder_point, lead_time, shelf_life, location, product_type, item_image, notes, 
        default_uom_id, expiry_date_flag, expiry_date, created_by, updated_by) 
        VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
    """
    values = (
        item_code, item_name, category_id, unit_price, manufacturer, barcode, stock_quantity, min_stock_level, 
        max_stock_level, reorder_point, lead_time, shelf_life, location, product_type, image_binary, notes, 
        default_uom_id, expiry_date_flag, expiry_date, current_userid, current_userid
    )

    mycursor = mydb.cursor()
    try:
        mycursor.execute(query, values)
        mydb.commit()
        item_id = mycursor.lastrowid
        mycursor.close()
        mydb.close()

        # Log successful creation
        logger.info(f"{USER_ID} --> {MODULE_NAME}: Item created: item_id=%s, item_code=%s, item_name=%s, category_id=%s, unit_price=%s, manufacturer=%s, barcode=%s, stock_quantity=%s, min_stock_level=%s, max_stock_level=%s, reorder_point=%s, lead_time=%s, shelf_life=%s, location=%s, product_type=%s, expiry_date_flag=%s, expiry_date=%s",
                    item_id, item_code, item_name, category_id, unit_price, manufacturer, barcode, stock_quantity, 
                    min_stock_level, max_stock_level, reorder_point, lead_time, shelf_life, location, product_type, 
                    expiry_date_flag, expiry_date)

        # Return the newly created item as a JSON response
        return jsonify({
            'item_id': item_id, 'item_code': item_code, 'item_name': item_name, 'category_id': category_id, 
            'unit_price': unit_price, 'manufacturer': manufacturer, 'barcode': barcode, 'stock_quantity': stock_quantity, 
            'min_stock_level': min_stock_level, 'max_stock_level': max_stock_level, 'reorder_point': reorder_point, 
            'lead_time': lead_time, 'shelf_life': shelf_life, 'location': location, 'product_type': product_type, 
            'item_image': None, 'notes': notes, 'default_uom_id': default_uom_id, 'expiry_date_flag': expiry_date_flag, 
            'expiry_date': expiry_date
        }), 201
    except Exception as e:
        mycursor.close()
        mydb.close()

        # Log the error
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Failed to create item: %s", str(e))

        return jsonify({'message': 'Failed to create item.', 'error': str(e)}), 500
