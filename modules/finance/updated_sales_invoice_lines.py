from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

# Define the Blueprint
update_sales_invoice_lines_api = Blueprint('update_sales_invoice_lines_api', __name__)

@update_sales_invoice_lines_api.route('/update_sales_invoice_lines', methods=['PUT'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def update_sales_invoice_lines():
    try:
        # Get the user ID from the token
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header) if authorization_header else None
        USER_ID = token_results["username"] if token_results else ""
        MODULE_NAME = __name__
        message = ""

        # Log entry point
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'update_sales_invoice_lines' function")

        # Get the database connection
        mydb = get_database_connection(USER_ID, MODULE_NAME)

        # Get the current user ID from the token
        current_userid = decode_token(authorization_header.replace('Bearer ', '')).get('Userid') if authorization_header.startswith('Bearer ') else None

        # Get the request data
        data = request.get_json()

        header_id = int(data.get('header_id'))

        # Log the received data
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Received data: {data}")

        # Get lines from the request
        lines = data.get('lines', [])

        if not lines:
            raise ValueError("At least one line is required")

        # Process each line
        for line in lines:
            line_id = line.get('line_id')
            line_number = line.get('line_number')
            item_id = line.get('item_id')
            quantity = line.get('quantity')
            unit_price = line.get('unit_price')
            line_total = line.get('line_total')
            uom_id = line.get('uom_id')

            # Check if line_number is provided
            if not line_number:
                raise ValueError("line_number is required for each line")

            # If line_id is provided, check if a record exists with the given parameters
            if line_id:
                record_exists = record_exists_in_database(mydb, header_id, line_number, line_id)

                if record_exists:
                    # Update the existing record
                    update_existing_record(mydb, header_id, line_number, line_id, item_id, quantity, unit_price, line_total, uom_id, current_userid)
                    message += f"Data for line_id {line_id} is updated in the system\n"
                else:
                    # Insert a new record
                    insert_new_record(mydb, header_id, line_number, item_id, quantity, unit_price, line_total, uom_id, current_userid)
                    message += f"Data for line_id {line_number} is inserted in the system\n"
            else:
                # Insert a new record without line_id
                insert_new_record(mydb, header_id, line_number, item_id, quantity, unit_price, line_total, uom_id, current_userid)
                message += f"Data for line_id {line_number} is inserted in the system\n"

        # Log success
        logger.info(f"{USER_ID} --> {MODULE_NAME}: Updated or inserted sales invoice lines")

        # Close the database connection
        mydb.close()

        return jsonify({'success': True, 'message': message.strip()}), 200

    except Exception as e:
        # Log any exceptions
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500

def record_exists_in_database(mydb, header_id, line_number, line_id):
    try:
        # Query to check if a record exists with the given parameters
        select_query = """
            SELECT COUNT(*) 
            FROM fin.salesinvoicelines 
            WHERE header_id = %s AND line_number = %s AND line_id = %s
        """

        # Initialize the cursor
        mycursor = mydb.cursor()

        # Execute the select query
        mycursor.execute(select_query, (header_id, line_number, line_id))
        result = mycursor.fetchone()

        # Check if any record exists
        return result[0] > 0

    except Exception as e:
        raise e

    finally:
        # Close the cursor
        mycursor.close()

def update_existing_record(mydb, header_id, line_number, line_id, item_id, quantity, unit_price, line_total, uom_id, current_userid):
    try:
        # Update query
        update_query = """
            UPDATE fin.salesinvoicelines
            SET item_id = %s, quantity = %s, unit_price = %s, line_total = %s, uom_id = %s, updated_by = %s
            WHERE header_id = %s AND line_number = %s AND line_id = %s
        """

        # Initialize the cursor
        mycursor = mydb.cursor()

        # Execute the update query
        mycursor.execute(update_query, (item_id, quantity, unit_price, line_total, uom_id, current_userid, header_id, line_number, line_id))
        mydb.commit()
        update_totalamount(mydb, header_id)        

    except Exception as e:
        raise e

    finally:
        # Close the cursor
        mycursor.close()

def insert_new_record(mydb, header_id, line_number, item_id, quantity, unit_price, line_total, uom_id, current_userid):
    try:
        # Insert query
        insert_query = """
            INSERT INTO fin.salesinvoicelines (header_id, line_number, item_id, quantity, unit_price, line_total, uom_id, created_by, updated_by)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        """

        # Initialize the cursor
        mycursor = mydb.cursor()

        # Execute the insert query
        mycursor.execute(insert_query, (header_id, line_number, item_id, quantity, unit_price, line_total, uom_id, current_userid, current_userid))
        mydb.commit()

        update_totalamount(mydb, header_id)

    except Exception as e:
        raise e

    finally:
        # Close the cursor
        mycursor.close()

def update_totalamount(mydb, header_id):
    try:
        # Total amount query
        total_amount_query = """
            SELECT SUM(line_total) AS total_amount
            FROM fin.salesinvoicelines
            WHERE header_id = %s
        """

        # Update query
        update_query = """
            UPDATE fin.salesinvoice
            SET totalamount = %s
            WHERE header_id = %s
        """

        # Initialize the cursor
        mycursor = mydb.cursor()

        # Execute the total amount query
        mycursor.execute(total_amount_query, (header_id,))
        total_amount_result = mycursor.fetchone()
        total_amount = total_amount_result[0] if total_amount_result[0] else 0

        # Update totalamount in fin.salesinvoice table
        mycursor.execute(update_query, (total_amount, header_id))
        mydb.commit()

    except Exception as e:
        raise e

    finally:
        # Close the cursor
        mycursor.close()
