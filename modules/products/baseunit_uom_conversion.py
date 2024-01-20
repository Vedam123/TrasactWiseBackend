from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger
from modules.products.routines.uom_conversion import uom_conversion  

baseunit_uom_conversion_api = Blueprint('baseunit_uom_conversion_api', __name__)

@baseunit_uom_conversion_api.route('/baseunit_uom_conversion', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)  
def baseunit_uom_conversion():
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
        mydb = get_database_connection(USER_ID, MODULE_NAME)

        source_uom_id = int(request.args.get('source_uom_id'))
        source_quantity = float(request.args.get('quantity'))  # Changed 'source_quantity' to 'quantity'
        target_uom_id = int(request.args.get('target_uom_id'))

        # Log input parameters
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Source UOM ID: {source_uom_id}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Source Quantity: {source_quantity}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Target UOM ID: {target_uom_id}")

        # Call the function and handle the result
        result = uom_conversion(source_uom_id, source_quantity, target_uom_id, mydb, USER_ID, MODULE_NAME)

        # Log the result for debugging purposes
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: UOM Conversion Result: {result}")

        mydb.close()

        # Assuming the function returns a valid response, return it as JSON
        return jsonify(result)

    except Exception as e:
        mydb.close()
        # Log error details
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
