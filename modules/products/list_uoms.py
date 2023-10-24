from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from datetime import datetime
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger  # Import the logger module

list_uom_api = Blueprint('list_uom_api', __name__)

@list_uom_api.route('/list_uoms', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)  # Pass READ_ACCESS_TYPE as an argument
def list_uoms():
    authorization_header = request.headers.get('Authorization')
    token_results = ""
    USER_ID = ""
    MODULE_NAME = __name__
    if authorization_header:
        token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None

    if token_results:
        USER_ID = token_results["username"]

    # Log entry point
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the list UOM data function")
    mydb = get_database_connection(USER_ID, MODULE_NAME)

    # Retrieve all UOMs from the database
    query = "SELECT * FROM com.uom"
    mycursor = mydb.cursor()
    mycursor.execute(query)
    uom_data = mycursor.fetchall()

    # Convert the UOM data into a list of dictionaries
    uom_list = []
    for data in uom_data:
        uom_dict = {
            'uom_id': data[0],
            'uom_name': data[1],
            'abbreviation': data[2],
            'conversion_factor': data[3],
            'decimal_places': data[4],
            'base_unit': data[5],
            'notes': data[6],
        }
        uom_list.append(uom_dict)
    
    # Close the cursor and connection
    mycursor.close()
    mydb.close()
    
    # Return the list of UOMs as JSON response
    return jsonify({'uom': uom_list})
