from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger  # Import the logger module

conversion_api = Blueprint('conversion_api', __name__)

def fetch_conversion_factor(mycursor, target_uom, USER_ID, MODULE_NAME):
    try:
        query = "SELECT conversion_factor FROM com.uom WHERE abbreviation = %s"
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Executing query: %s", query)
        
        mycursor.execute(query, (target_uom,))
        row = mycursor.fetchone()
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Fetched row: %s", row)
        
        if row:
            return row[0]
        else:
            logger.warning(f"{USER_ID} --> {MODULE_NAME}: No conversion factor found.")
            return None
        
    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error fetching conversion factor: %s", e)
        return None

def convert_quantity(source_quantity, source_uom, target_uom, mycursor, USER_ID, MODULE_NAME):
    source_conversion_factor = fetch_conversion_factor(mycursor, source_uom, USER_ID, MODULE_NAME)
    target_conversion_factor = fetch_conversion_factor(mycursor, target_uom, USER_ID, MODULE_NAME)
    
    if source_conversion_factor is None or target_conversion_factor is None:
        return None
        
    converted_quantity = (source_quantity * source_conversion_factor) / target_conversion_factor
    return converted_quantity

@conversion_api.route('/uom_conversion', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)  # Pass READ_ACCESS_TYPE as an argument
def convert_quantity_endpoint():
    authorization_header = request.headers.get('Authorization')
    token_results = ""
    USER_ID = ""
    MODULE_NAME = __name__
    if authorization_header:
        token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None

    if token_results:
        USER_ID = token_results["username"]

    # Log entry point
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the convert quantity data function")
    try:
        source_uom = request.args.get('source_uom')
        source_quantity = float(request.args.get('source_quantity'))
        target_uom = request.args.get('target_uom')

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: source_uom: %s, source_quantity: %s, target_uom: %s", source_uom, source_quantity, target_uom)
        
        mydb = get_database_connection(USER_ID, MODULE_NAME)
        mycursor = mydb.cursor()

        converted_quantity = convert_quantity(source_quantity, source_uom, target_uom, mycursor, USER_ID, MODULE_NAME)
        if converted_quantity is None:
            mycursor.close()
            mydb.close()
            logger.warning(f"{USER_ID} --> {MODULE_NAME}: Conversion not possible")
            return jsonify({'message': 'Conversion not possible'})

        mycursor.close()
        mydb.close()

        return jsonify({'target_uom': target_uom, 'converted_quantity': converted_quantity})

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred: %s", str(e))
        return jsonify({'error': str(e)})
