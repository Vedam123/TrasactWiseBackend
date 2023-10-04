from flask import Blueprint, jsonify
from modules.admin.databases.mydb import get_database_connection
import base64
from datetime import datetime
from modules.security.permission_required import permission_required  # Import the decorator
from config import READ_ACCESS_TYPE  # Import READ_ACCESS_TYPE

list_items_api = Blueprint('list_items_api', __name__)

@list_items_api.route('/list_items', methods=['GET'])
@permission_required(READ_ACCESS_TYPE ,  __file__)  # Pass READ_ACCESS_TYPE as an argument
def list_items():
    mydb = get_database_connection()

    # Retrieve all items from the database
    query = "SELECT * FROM com.items"
    mycursor = mydb.cursor()
    mycursor.execute(query)
    items = mycursor.fetchall()

    # Convert the item data into a list of dictionaries
    item_list = []
    for item_data in items:
        item_id, item_code, item_name, category_id, unit_price, manufacturer, barcode, stock_quantity, \
        min_stock_level, max_stock_level, reorder_point, lead_time, shelf_life, location,product_type,item_image, notes, \
        default_uom_id, created_at, updated_at, created_by, updated_by = item_data
        
        pic = item_image
        if pic is not None:
            pic = base64.b64encode(pic).decode('utf-8')
       
        item_dict = {
            'item_id': item_id,
            'item_code': item_code,
            'item_name': item_name,
            'category_id': category_id,
            'unit_price': unit_price,
            'manufacturer': manufacturer,
            'barcode': barcode,
            'stock_quantity': stock_quantity,
            'min_stock_level': min_stock_level,
            'max_stock_level': max_stock_level,
            'reorder_point': reorder_point,
            'lead_time': lead_time,
            'shelf_life': shelf_life,
            'location': location,
            'item_image': item_image,
            'notes': notes,
            'product_type': product_type,
            'default_uom_id': default_uom_id,
            'created_at': created_at,
            'updated_at': updated_at,
            'created_by': created_by,
            'updated_by': updated_by
        }
        item_list.append(item_dict)

    # Close the cursor and connection
    mycursor.close()
    mydb.close()
    
    # Return the list of items as JSON response
    return jsonify({'items': item_list})
