from flask import Blueprint, jsonify
from modules.admin.databases.mydb import get_database_connection
import base64
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE

list_items_api = Blueprint('list_items_api', __name__)

@list_items_api.route('/list_items', methods=['GET'])
@permission_required(READ_ACCESS_TYPE ,  __file__)
def list_items():
    mydb = get_database_connection()

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
        for i, value in enumerate(item_data):
            column_name = column_names[i]
            if column_name == 'item_image' and value is not None:
                value = base64.b64encode(value).decode('utf-8')
            item_dict[column_name] = value
        item_list.append(item_dict)

    # Close the cursor and connection
    mycursor.close()
    mydb.close()
    
    # Return the list of items as JSON response
    return jsonify({'items': item_list})
