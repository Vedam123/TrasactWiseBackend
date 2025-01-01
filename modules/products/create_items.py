from flask import Blueprint, jsonify, request
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from modules.admin.routines.get_next_free_number_function import get_next_free_number_function
from modules.utilities.logger import logger

create_items_api = Blueprint('create_items_api', __name__)

@create_items_api.route('/create_items', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_items():
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
    
    if request.content_type == 'application/json':
        data = request.get_json()
    else:
        data = request.form

    # Log entry point
    logger.debug(f"{appuser} --> {__name__}: Entered in the create item data function")

    # Get the data from the request's form data
    logger.debug(f"{appuser} --> {__name__}: Received Input {data}")
    item_code_prefix = data.get('item_code', '')  # This will be used to prefix the sequence number
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
    is_serial_controlled = data.get('is_serial_controlled') == 'true'  # Convert to boolean

    # Handle multiple file uploads
    image_files = request.files.getlist('item_images')
    
    logger.debug(f"{appuser} --> {__name__}: Received Image files  {image_files}")

    # Validate the required fields (remove unit_price validation)
    if not item_name or not category_id:
        logger.warning(f"{appuser} --> {__name__}: Required fields are missing: item_name=%s, category_id=%s",
                       item_name, category_id)
        return jsonify({'message': 'item_name and category_id are required fields.'}), 400

    try:
        # Get the next free number for the sequence 'ITEM_NUMBER'
        next_number = get_next_free_number_function("ITEM_NUMBER", mydb, appuser, __name__)
        
        # Prefix the next number with the item_code_prefix
        item_code = f"{item_code_prefix}{next_number}"

        # Insert a new item into the database, including is_serial_controlled
        item_query = """
            INSERT INTO com.items 
            (item_code, item_name, category_id, manufacturer, barcode, stock_quantity, min_stock_level, 
            max_stock_level, reorder_point, lead_time, shelf_life, location, product_type, notes, 
            default_uom_id, expiry_date_flag, expiry_date, is_serial_controlled, created_by, updated_by) 
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        # Corresponding values tuple including is_serial_controlled
        item_values = (
            item_code, item_name, category_id, manufacturer, barcode, stock_quantity, min_stock_level, 
            max_stock_level, reorder_point, lead_time, shelf_life, location, product_type, notes, 
            default_uom_id, expiry_date_flag, expiry_date, is_serial_controlled, appuserid, appuserid
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
                mycursor.execute(image_query, (image_binary, image_type, appuserid, appuserid))
                image_id = mycursor.lastrowid

                # Map image to the item in item_image_mapping table
                mycursor.execute(mapping_query, (item_id, image_id, order))
            except Exception as e:
                logger.error(f"{appuser} --> {__name__}: Failed to process image: %s", str(e))
                mydb.rollback()
                return jsonify({'message': 'Failed to process image.', 'error': str(e)}), 400

        mydb.commit()
        mycursor.close()
        mydb.close()

        # Log successful creation
        logger.info(f"{appuser} --> {__name__}: Item created with item_id=%s", item_id)

        # Return the newly created item as a JSON response, including is_serial_controlled
        return jsonify({
            'item_id': item_id, 'item_code': item_code, 'item_name': item_name, 'category_id': category_id, 
            'manufacturer': manufacturer, 'barcode': barcode, 'stock_quantity': stock_quantity, 
            'min_stock_level': min_stock_level, 'max_stock_level': max_stock_level, 'reorder_point': reorder_point, 
            'lead_time': lead_time, 'shelf_life': shelf_life, 'location': location, 'product_type': product_type, 
            'notes': notes, 'default_uom_id': default_uom_id, 'expiry_date_flag': expiry_date_flag, 
            'expiry_date': expiry_date, 'is_serial_controlled': is_serial_controlled
        }), 201
    except Exception as e:
        mycursor.close()
        mydb.close()

        # Log the error
        logger.error(f"{appuser} --> {__name__}: Failed to create item: %s", str(e))

        return jsonify({'message': 'Failed to create item.', 'error': str(e)}), 500
