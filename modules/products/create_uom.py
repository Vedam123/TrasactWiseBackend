import json
import logging  # Import the logging module
from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required  # Import the decorator
from config import WRITE_ACCESS_TYPE  # Import WRITE_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger  # Import the logger module

create_uom_api = Blueprint('create_uom_api', __name__)

@create_uom_api.route('/create_uom', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)  # Pass WRITE_ACCESS_TYPE as an argument
def create_uom():
    authorization_header = request.headers.get('Authorization')
    token_results = ""
    USER_ID = ""
    MODULE_NAME = __name__
    if authorization_header:
        token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None

    if token_results:
        USER_ID = token_results["username"]

    # Log entry point
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the create UOM data function")

    mydb = get_database_connection(USER_ID, MODULE_NAME)

    # Get the data from the request's JSON payload
    data = request.json
    uom_name = data.get('uom_name')
    abbreviation = data.get('abbreviation')
    conversion_factor = data.get('conversion_factor')
    base_unit = data.get('base_unit')
    decimal_places = data.get('decimal_places')
    notes = data.get('notes')

    # Validate the required fields
    if not uom_name or not abbreviation or not conversion_factor:
        logger.warning(f"{USER_ID} --> {MODULE_NAME}: Required fields are missing: uom_name=%s, abbreviation=%s, conversion_factor=%s",
                       uom_name, abbreviation, conversion_factor)
        return jsonify({'message': 'uom_name, abbreviation, and conversion_factor are required fields.'}), 400

    # Insert new UOM into the database
    query = "INSERT INTO com.uom (uom_name, abbreviation, conversion_factor, base_unit, decimal_places, notes) VALUES (%s, %s, %s, %s, %s, %s)"
    values = (uom_name, abbreviation, conversion_factor, base_unit, decimal_places, notes)

    mycursor = mydb.cursor()
    try:
        mycursor.execute(query, values)
        mydb.commit()
        uom_id = mycursor.lastrowid
        mycursor.close()
        mydb.close()

        # Log successful creation
        logger.info(f"{USER_ID} --> {MODULE_NAME}: UOM created: uom_id=%s, uom_name=%s, abbreviation=%s, conversion_factor=%s, base_unit=%s, decimal_places=%s, notes=%s",
                    uom_id, uom_name, abbreviation, conversion_factor, base_unit, decimal_places, notes)

        # Return the newly created UOM as a JSON response
        return jsonify({'uom_id': uom_id, 'uom_name': uom_name, 'abbreviation': abbreviation, 'conversion_factor': conversion_factor, 'base_unit': base_unit, 'decimal_places': decimal_places, 'notes': notes}), 201

    except Exception as e:
        mycursor.close()
        mydb.close()

        # Log the error
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Failed to create UOM: %s", str(e))

        return jsonify({'message': 'Failed to create UOM.', 'error': str(e)}), 500
