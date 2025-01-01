from flask import Blueprint, jsonify, request
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.security.permission_required import permission_required
from config import UPDATE_ACCESS_TYPE
from modules.utilities.logger import logger

update_items_api = Blueprint('update_items_api', __name__)

@update_items_api.route('/update_items', methods=['PUT'])
@permission_required(UPDATE_ACCESS_TYPE, __file__)
def update_items():
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
    logger.debug(f"{appuser} --> {__name__}: Entered in the update item data function")

       # Get the data from the request's form data
    logger.debug(f"{appuser} --> {__name__}: Received Input {data}")
    
    # Use conditional logic to handle empty strings and convert them to None if necessary
    def convert_empty_to_none(value):
        return value if value not in (None, '', 'null') else None

    item_code = data.get('item_code', '')  # Find item by item_code (required)
    item_name = convert_empty_to_none(data.get('item_name'))  # Convert empty strings to None
    category_id = convert_empty_to_none(data.get('category_id'))
    manufacturer = convert_empty_to_none(data.get('manufacturer'))
    barcode = convert_empty_to_none(data.get('barcode'))
    stock_quantity = convert_empty_to_none(data.get('stock_quantity'))
    min_stock_level = convert_empty_to_none(data.get('min_stock_level'))
    max_stock_level = convert_empty_to_none(data.get('max_stock_level'))
    reorder_point = convert_empty_to_none(data.get('reorder_point'))
    lead_time = convert_empty_to_none(data.get('lead_time'))
    shelf_life = convert_empty_to_none(data.get('shelf_life'))
    location = convert_empty_to_none(data.get('location'))
    product_type = convert_empty_to_none(data.get('product_type'))
    notes = convert_empty_to_none(data.get('notes'))
    default_uom_id = convert_empty_to_none(data.get('default_uom_id'))

    # Convert 'true' or 'false' strings to actual booleans, defaulting to False if missing
   # expiry_date_flag = data.get('expiry_date_flag', '').lower() == 'true' if 'expiry_date_flag' in data else False
    expiry_date_flag = data.get('expiry_date_flag')
    expiry_date = convert_empty_to_none(data.get('expiry_date'))
    #is_serial_controlled = data.get('is_serial_controlled', '').lower() == 'true' if 'is_serial_controlled' in data else False
    is_serial_controlled = data.get('is_serial_controlled')

    logger.debug(f"{appuser} --> {__name__}: Expiry Date Flag  {expiry_date_flag} , {is_serial_controlled}")
    print("Inputed expiry flag and serial flag ", expiry_date_flag, is_serial_controlled)

    # Handle multiple file uploads
    image_files = request.files.getlist('item_images')

    logger.debug(f"{appuser} --> {__name__}: Received Image files  {image_files}")

    # Validate required fields
    if not item_code or not item_name or not category_id:
        logger.warning(f"{appuser} --> {__name__}: Required fields are missing: item_code=%s, item_name=%s, category_id=%s",
                       item_code, item_name, category_id)
        return jsonify({'message': 'item_code, item_name, and category_id are required fields.'}), 400

    try:
        # Find item_id using item_code
        find_item_query = "SELECT item_id FROM com.items WHERE item_code = %s"
        mycursor = mydb.cursor()
        mycursor.execute(find_item_query, (item_code,))
        item_result = mycursor.fetchone()

        if not item_result:
            return jsonify({'message': f'Item with item_code {item_code} not found.'}), 404

        item_id = item_result[0]

        # Update the item in the database
        update_item_query = """
            UPDATE com.items 
            SET item_name=%s, category_id=%s, manufacturer=%s, barcode=%s, stock_quantity=%s, min_stock_level=%s, 
                max_stock_level=%s, reorder_point=%s, lead_time=%s, shelf_life=%s, location=%s, product_type=%s, 
                notes=%s, default_uom_id=%s, expiry_date_flag=%s, expiry_date=%s, is_serial_controlled=%s, 
                updated_by=%s 
            WHERE item_id=%s
        """
        update_item_values = (
            item_name, category_id, manufacturer, barcode, stock_quantity, min_stock_level, max_stock_level,
            reorder_point, lead_time, shelf_life, location, product_type, notes, default_uom_id, 
            expiry_date_flag, expiry_date, is_serial_controlled, appuserid, item_id
        )

        mycursor.execute(update_item_query, update_item_values)

        # Handle image updates (if any are uploaded)
        if image_files:
            # Get the maximum image_order for the item_id
            max_order_query = "SELECT MAX(image_order) FROM com.item_image_mapping WHERE item_id = %s"
            mycursor.execute(max_order_query, (item_id,))
            max_image_order_result = mycursor.fetchone()
            max_image_order = max_image_order_result[0] if max_image_order_result[0] is not None else 0

            image_query = """
                INSERT INTO com.item_images (image, image_type, created_by, updated_by) 
                VALUES (%s, %s, %s, %s)
            """
            mapping_query = """
                INSERT INTO com.item_image_mapping (item_id, image_id, image_order) 
                VALUES (%s, %s, %s)
            """

            for order, image_file in enumerate(image_files, start=max_image_order + 1):
                try:
                    image_binary = image_file.read()
                    image_type = image_file.content_type

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

        # Log successful update
        logger.info(f"{appuser} --> {__name__}: Item updated with item_id=%s", item_id)

        # Return the updated item details
        return jsonify({
            'item_id': item_id, 'item_code': item_code, 'item_name': item_name, 'category_id': category_id, 
            'manufacturer': manufacturer, 'barcode': barcode, 'stock_quantity': stock_quantity, 
            'min_stock_level': min_stock_level, 'max_stock_level': max_stock_level, 'reorder_point': reorder_point, 
            'lead_time': lead_time, 'shelf_life': shelf_life, 'location': location, 'product_type': product_type, 
            'notes': notes, 'default_uom_id': default_uom_id, 'expiry_date_flag': expiry_date_flag, 
            'expiry_date': expiry_date, 'is_serial_controlled': is_serial_controlled
        }), 200

    except Exception as e:
        mycursor.close()
        mydb.close()

        # Log the error
        logger.error(f"{appuser} --> {__name__}: Failed to update item: %s", str(e))

        return jsonify({'message': 'Failed to update item.', 'error': str(e)}), 500
