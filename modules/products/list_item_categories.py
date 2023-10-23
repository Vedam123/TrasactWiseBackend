from flask import Blueprint, jsonify,request
from modules.admin.databases.mydb import get_database_connection
import base64
from datetime import datetime
from modules.security.permission_required import permission_required  # Import the decorator
from config import READ_ACCESS_TYPE  # Import READ_ACCESS_TYPE
#from logger import logger 
from modules.security.get_user_from_token import get_user_from_token

# Get a logger for this module
#logger = configure_logging()

list_item_categories_api = Blueprint('list_item_categories_api', __name__)

@list_item_categories_api.route('/list_item_categories', methods=['GET'])
@permission_required(READ_ACCESS_TYPE ,  __file__)  # Pass READ_ACCESS_TYPE as an argument
def list_item_categories():
    MODULE_NAME = __name__ 
    token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None
    USER_ID = token_results['username']
    #logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the list item categories data function")
    mydb = get_database_connection()

    # Retrieve all item categories from the database
    query = "SELECT * FROM com.itemcategory"
    mycursor = mydb.cursor()
    mycursor.execute(query)
    item_categories = mycursor.fetchall()

    # Convert the item category data into a list of dictionaries
    item_category_list = []
    for data in item_categories:
        pic = data[6]
        if pic is not None:
            pic = base64.b64encode(pic).decode('utf-8')
        item_category_dict = {
            'category_id': data[0],
            'category_name': data[1],
            'description': data[2],
            'is_active': data[3],
            'tax_information': data[4],
            'default_uom': data[5],
            'image': pic,
        }
        item_category_list.append(item_category_dict)
    # Close the cursor and connection
    mycursor.close()
    mydb.close()
    # Return the list of item categories as JSON response
    return jsonify({'item_categories': item_category_list})
