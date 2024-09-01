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
    mycursor = mydb.cursor()

    try:
        # Get the data from the request's JSON payload
        data = request.json
        uom_name = data.get('uom_name')
        abbreviation = data.get('abbreviation')
        conversion_factor = data.get('conversion_factor')
        base_unit = data.get('base_unit')
        decimal_places = data.get('decimal_places')

        # Validate the required fields
        if not uom_name or not abbreviation or not conversion_factor:
            logger.warning(f"{USER_ID} --> {MODULE_NAME}: Required fields are missing: uom_name=%s, abbreviation=%s, conversion_factor=%s",
                           uom_name, abbreviation, conversion_factor)
            return jsonify({'message': 'uom_name, abbreviation, and conversion_factor are required fields.'}), 400

        # Insert new UOM into the database without base_unit and notes
        insert_query = """
            INSERT INTO com.uom (uom_name, abbreviation, conversion_factor, decimal_places)
            VALUES (%s, %s, %s, %s)
        """
        insert_values = (uom_name, abbreviation, conversion_factor, decimal_places)
        mycursor.execute(insert_query, insert_values)
        uom_id = mycursor.lastrowid

        # If base_unit is not provided, set base_unit to the newly inserted uom_id
        if not base_unit:
            base_unit = uom_id

        # Update the UOM record with the correct base_unit value
        update_base_unit_query = "UPDATE com.uom SET base_unit = %s WHERE uom_id = %s"
        update_base_unit_values = (base_unit, uom_id)
        mycursor.execute(update_base_unit_query, update_base_unit_values)

        # Fetch base_unit's uom_name from the database
        fetch_base_uom_name_query = "SELECT uom_name FROM com.uom WHERE uom_id = %s"
        mycursor.execute(fetch_base_uom_name_query, (base_unit,))
        base_uom_result = mycursor.fetchone()

        if base_uom_result:
            base_uom_name = base_uom_result[0]
        else:
            base_uom_name = "Unknown"

        # Construct the notes field
        notes = f"1 {uom_name} = {conversion_factor} * {base_uom_name}"

        # Update the UOM record with the notes
        update_notes_query = "UPDATE com.uom SET notes = %s WHERE uom_id = %s"
        update_notes_values = (notes, uom_id)
        mycursor.execute(update_notes_query, update_notes_values)

        # Commit the transaction
        mydb.commit()

        # Log successful creation
        logger.info(f"{USER_ID} --> {MODULE_NAME}: UOM created: uom_id=%s, uom_name=%s, abbreviation=%s, conversion_factor=%s, base_unit=%s, decimal_places=%s, notes=%s",
                    uom_id, uom_name, abbreviation, conversion_factor, base_unit, decimal_places, notes)

        # Return the newly created UOM as a JSON response
        return jsonify({
            'uom_id': uom_id,
            'uom_name': uom_name,
            'abbreviation': abbreviation,
            'conversion_factor': conversion_factor,
            'base_unit': base_unit,
            'decimal_places': decimal_places,
            'notes': notes
        }), 201

    except Exception as e:
        mydb.rollback()
        # Log the error
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Failed to create UOM: %s", str(e))
        return jsonify({'message': 'Failed to create UOM.', 'error': str(e)}), 500

    finally:
        mycursor.close()
        mydb.close()
