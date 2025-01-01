from flask import Blueprint, jsonify, request
from modules.security.routines.get_user_and_db_details import get_user_and_db_details	
from datetime import datetime
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.utilities.logger import logger  # Import the logger module

list_uom_api = Blueprint('list_uom_api', __name__)

@list_uom_api.route('/list_uoms', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def list_uoms():
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
    logger.debug(f"{appuser} --> {__name__}: Entered in the list UOM data function")

    # Retrieve to_convert_uom_list from query parameters
    find_uom_id = request.args.get('find_uom_id', None)

    # Build the SQL query based on the presence of to_convert_uom_list
    if find_uom_id:
        query = f"""
            SELECT *
            FROM com.uom
            WHERE uom_id IN (SELECT base_unit FROM com.uom WHERE uom_id = {find_uom_id})
            OR base_unit IN (SELECT uom_id FROM com.uom WHERE uom_id = {find_uom_id});
        """
    else:
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
