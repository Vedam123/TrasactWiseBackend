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
    for data in items:
        pic = data[14]
        if pic is not None:
            pic = base64.b64encode(pic).decode('utf-8')
        item_dict = {
            'item_id': data[0],
            'item_code': data[1],
            'item_name': data[2],
            'category_id': data[3],
            'unit_price': data[4],
            'manufacturer': data[5],
            'barcode': data[6],
            'stock_quantity': data[7],
            'min_stock_level': data[8],
            'max_stock_level': data[9],
            'reorder_point': data[10],
            'lead_time': data[11],
            'shelf_life': data[12],
            'location': data[13],
            'item_image': pic,
            'notes': data[15],
            'product_type': data[16],
            'default_uom_id': data[17],            
        }
        item_list.append(item_dict)
    # Close the cursor and connection
    mycursor.close()
    mydb.close()
    # Return the list of items as JSON response
    return jsonify({'items': item_list})
