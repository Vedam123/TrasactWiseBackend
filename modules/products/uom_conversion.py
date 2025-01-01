from flask import Blueprint, jsonify, request
from modules.security.routines.get_user_and_db_details import get_user_and_db_details	
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.utilities.logger import logger  # Import the logger module

conversion_api = Blueprint('conversion_api', __name__)

def fetch_conversion_factor(mycursor, target_uom, appuser, __name__):
    try:
        query = "SELECT conversion_factor FROM com.uom WHERE abbreviation = %s"
        logger.debug(f"{appuser} --> {__name__}: Executing query: %s", query)
        
        mycursor.execute(query, (target_uom,))
        row = mycursor.fetchone()
        logger.debug(f"{appuser} --> {__name__}: Fetched row: %s", row)
        
        if row:
            return row[0]
        else:
            logger.warning(f"{appuser} --> {__name__}: No conversion factor found.")
            return None
        
    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Error fetching conversion factor: %s", e)
        return None

def convert_quantity(source_quantity, source_uom, target_uom, mycursor, appuser, __name__):
    source_conversion_factor = fetch_conversion_factor(mycursor, source_uom, appuser, __name__)
    target_conversion_factor = fetch_conversion_factor(mycursor, target_uom, appuser, __name__)
    
    if source_conversion_factor is None or target_conversion_factor is None:
        return None, None
    
    # Calculate quotient and remainder
    quotient = source_quantity * source_conversion_factor // target_conversion_factor
    remainder = source_quantity * source_conversion_factor % target_conversion_factor
    
    return quotient, remainder


@conversion_api.route('/uom_conversion', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)  # Pass READ_ACCESS_TYPE as an argument
def convert_quantity_endpoint():
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
        source_uom = request.args.get('source_uom')
        source_quantity = float(request.args.get('source_quantity'))
        target_uom = request.args.get('target_uom')

        logger.debug(f"{appuser} --> {__name__}: source_uom: %s, source_quantity: %s, target_uom: %s", source_uom, source_quantity, target_uom)
        mycursor = mydb.cursor()

        converted_quantity, reminder_quantity = convert_quantity(source_quantity, source_uom, target_uom, mycursor, appuser, __name__)
        if converted_quantity is None:
            mycursor.close()
            mydb.close()
            logger.warning(f"{appuser} --> {__name__}: Conversion not possible")
            return jsonify({'message': 'Conversion not possible'})

        mycursor.close()
        mydb.close()

        return jsonify({'target_uom': target_uom, 
                        'converted_quantity': converted_quantity,
                        'reminder_quantity':reminder_quantity,
                        'source_uom':source_uom})

    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: An error occurred: %s", str(e))
        return jsonify({'error': str(e)})
