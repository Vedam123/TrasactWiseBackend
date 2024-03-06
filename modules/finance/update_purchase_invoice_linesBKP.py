# Import the relevant modules
from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

# Define the Blueprint
update_purchase_invoice_lines_api = Blueprint('update_purchase_invoice_lines_api', __name__)

# Define the route
@update_purchase_invoice_lines_api.route('/update_purchase_invoice_lines', methods=['PUT'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def update_purchase_invoice_lines():
    try:
        # Get the user ID from the token
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header) if authorization_header else None
        USER_ID = token_results["username"] if token_results else ""
        MODULE_NAME = __name__
        message = ""

        # Log entry point
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'update_purchase_invoice_lines' function")

        # Get the database connection
        mydb = get_database_connection(USER_ID, MODULE_NAME)

        # Get the current user ID from the token
        current_userid = decode_token(authorization_header.replace('Bearer ', '')).get('Userid') if authorization_header.startswith('Bearer ') else None

        # Get the request data
        data = request.get_json() if request.content_type == 'application/json' else request.form

        # Log the received data
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Received data: {data}")

        # Cast fields to appropriate types
        item_id = int(data.get('item_id'))
        quantity = float(data.get('quantity'))
        unit_price = float(data.get('unit_price'))
        line_total = float(data.get('line_total'))
        uom_id = int(data.get('uom_id'))

        # Dynamically retrieve parameters from request
        header_id = request.args.get('header_id')
        line_id = request.args.get('line_id')
        line_number = request.args.get('line_number')

        if not any([header_id, line_id, line_number]):
            raise ValueError("At least one of header_id, line_id, or line_number is required")

        # Check if a record exists with the given parameters
        record_exists = record_exists_in_database(mydb, header_id, line_id, line_number)

        if record_exists:
            # Update the existing record
            update_existing_record(mydb, header_id, line_id, line_number, item_id, quantity, unit_price, line_total, uom_id, current_userid)
            message = "Data is updated in the system"
        else:
            # Insert a new record
            insert_new_record(mydb, header_id, line_id, line_number, item_id, quantity, unit_price, line_total, uom_id, current_userid)
            message = "Data is inserted in the system"

        # Log success
        logger.info(f"{USER_ID} --> {MODULE_NAME}: Updated or inserted purchase invoice line")

        # Close the database connection
        mydb.close()

        return jsonify({'success': True, 'message': message}), 200

    except Exception as e:
        # Log any exceptions
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500

def record_exists_in_database(mydb, header_id, line_id, line_number):
    try:
        # Query to check if a record exists with the given parameters
        select_query = """
            SELECT COUNT(*) 
            FROM fin.purchaseinvoicelines 
            WHERE (%s IS NULL OR header_id = %s) AND (%s IS NULL OR line_id = %s) AND (%s IS NULL OR line_number = %s)
        """

        # Initialize the cursor
        mycursor = mydb.cursor()

        # Execute the select query
        mycursor.execute(select_query, (header_id, header_id, line_id, line_id, line_number, line_number))
        result = mycursor.fetchone()

        # Check if any record exists
        return result[0] > 0

    except Exception as e:
        raise e

    finally:
        # Close the cursor
        mycursor.close()

def update_existing_record(mydb, header_id, line_id, line_number, item_id, quantity, unit_price, line_total, uom_id, current_userid):
    try:
        # Update query
        update_query = """
            UPDATE fin.purchaseinvoicelines
            SET item_id = %s, quantity = %s, unit_price = %s, line_total = %s, uom_id = %s, updated_by = %s
            WHERE (%s IS NULL OR header_id = %s) AND (%s IS NULL OR line_id = %s) AND (%s IS NULL OR line_number = %s)
        """

        # Initialize the cursor
        mycursor = mydb.cursor()

        # Execute the update query
        mycursor.execute(update_query, (item_id, quantity, unit_price, line_total, uom_id, current_userid, header_id, header_id, line_id, line_id, line_number, line_number))
        mydb.commit()

    except Exception as e:
        raise e

    finally:
        # Close the cursor
        mycursor.close()

def insert_new_record(mydb, header_id, line_id, line_number, item_id, quantity, unit_price, line_total, uom_id, current_userid):
    try:
        # Insert query
        insert_query = """
            INSERT INTO fin.purchaseinvoicelines (header_id, line_id, line_number, item_id, quantity, unit_price, line_total, uom_id, created_by, updated_by)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """

        # Initialize the cursor
        mycursor = mydb.cursor()

        # Execute the insert query
        mycursor.execute(insert_query, (header_id, line_id, line_number, item_id, quantity, unit_price, line_total, uom_id, current_userid, current_userid))
        mydb.commit()

    except Exception as e:
        raise e

    finally:
        # Close the cursor
        mycursor.close()
