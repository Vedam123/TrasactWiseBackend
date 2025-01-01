from flask import Blueprint, jsonify, request
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.utilities.logger import logger
from modules.products.routines.uom_conversion import uom_conversion  

baseunit_uom_conversion_api = Blueprint('baseunit_uom_conversion_api', __name__)

@baseunit_uom_conversion_api.route('/baseunit_uom_conversion', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)  
def baseunit_uom_conversion():
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

    # Log entry point
    logger.debug(f"{appuser} --> {__name__}: Entered in the convert quantity data function")

    try:

        source_uom_id = int(request.args.get('source_uom_id'))
        source_quantity = float(request.args.get('quantity'))  # Changed 'source_quantity' to 'quantity'
        target_uom_id = int(request.args.get('target_uom_id'))

        # Log input parameters
        logger.debug(f"{appuser} --> {__name__}: Source UOM ID: {source_uom_id}")
        logger.debug(f"{appuser} --> {__name__}: Source Quantity: {source_quantity}")
        logger.debug(f"{appuser} --> {__name__}: Target UOM ID: {target_uom_id}")

        # Call the function and handle the result
        result = uom_conversion(source_uom_id, source_quantity, target_uom_id, mydb, appuser, __name__)

        # Log the result for debugging purposes
        logger.debug(f"{appuser} --> {__name__}: UOM Conversion Result: {result}")

        mydb.close()

        # Assuming the function returns a valid response, return it as JSON
        return jsonify(result)

    except Exception as e:
        mydb.close()
        # Log error details
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
