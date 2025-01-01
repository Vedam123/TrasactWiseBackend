from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import WRITE_ACCESS_TYPE
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

        try:
            company, instance, dbuser, mydb, appuser, appuserid, user_info, employee_info = get_user_and_db_details(authorization_header)
            logger.debug(f"{appuser} --> {__name__}: Successfully retrieved user details from the token.")
        except ValueError as e:
            logger.error(f"Failed to retrieve user details from token. Error: {str(e)}")
            return jsonify({"error": str(e)}), 401
        
        if not appuser:
            logger.error(f"Unauthorized access attempt: {appuser} --> {__name__}: Application user not found.")
            return jsonify({"error": "Unauthorized. Username not found."}), 401
        
        message = ""

        # Log entry point
        logger.debug(f"{appuser} --> {__name__}: Entered the 'update_purchase_invoice_lines' function")

        data = request.get_json()

        header_id = int(data.get('header_id'))

        # Log the received data
        logger.debug(f"{appuser} --> {__name__}: Received data: {data}")

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
                    update_existing_record(mydb, header_id, line_number, line_id, item_id, quantity, unit_price, line_total, uom_id, appuserid)
                    message += f"Data for line_id {line_id} is updated in the system\n"
                else:
                    # Insert a new record
                    insert_new_record(mydb, header_id, line_number, item_id, quantity, unit_price, line_total, uom_id, appuserid)
                    message += f"Data for line_id {line_number} is inserted in the system\n"
            else:
                # Insert a new record without line_id
                insert_new_record(mydb, header_id, line_number, item_id, quantity, unit_price, line_total, uom_id, appuserid)
                message += f"Data for line_id {line_number} is inserted in the system\n"

        # Log success
        logger.info(f"{appuser} --> {__name__}: Updated or inserted purchase invoice lines")

        # Close the database connection
        mydb.close()

        return jsonify({'success': True, 'message': message.strip()}), 200

    except Exception as e:
        # Log any exceptions
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500

def record_exists_in_database(mydb, header_id, line_number, line_id):
    try:
        # Query to check if a record exists with the given parameters
        select_query = """
            SELECT COUNT(*) 
            FROM fin.purchaseinvoicelines 
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

def update_existing_record(mydb, header_id, line_number, line_id, item_id, quantity, unit_price, line_total, uom_id, appuserid):
    try:
        # Update query
        update_query = """
            UPDATE fin.purchaseinvoicelines
            SET item_id = %s, quantity = %s, unit_price = %s, line_total = %s, uom_id = %s, updated_by = %s
            WHERE header_id = %s AND line_number = %s AND line_id = %s
        """

        # Initialize the cursor
        mycursor = mydb.cursor()

        # Execute the update query
        mycursor.execute(update_query, (item_id, quantity, unit_price, line_total, uom_id, appuserid, header_id, line_number, line_id))
        mydb.commit()
        update_totalamount(mydb, header_id)        

    except Exception as e:
        raise e

    finally:
        # Close the cursor
        mycursor.close()

def insert_new_record(mydb, header_id, line_number, item_id, quantity, unit_price, line_total, uom_id, appuserid):
    try:
        # Insert query
        insert_query = """
            INSERT INTO fin.purchaseinvoicelines (header_id, line_number, item_id, quantity, unit_price, line_total, uom_id, created_by, updated_by)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        """

        # Initialize the cursor
        mycursor = mydb.cursor()

        # Execute the insert query
        mycursor.execute(insert_query, (header_id, line_number, item_id, quantity, unit_price, line_total, uom_id, appuserid, appuserid))
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
            FROM fin.purchaseinvoicelines
            WHERE header_id = %s
        """

        # Update query
        update_query = """
            UPDATE fin.purchaseinvoice
            SET totalamount = %s
            WHERE header_id = %s
        """

        # Initialize the cursor
        mycursor = mydb.cursor()

        # Execute the total amount query
        mycursor.execute(total_amount_query, (header_id,))
        total_amount_result = mycursor.fetchone()
        total_amount = total_amount_result[0] if total_amount_result[0] else 0

        # Update totalamount in fin.purchaseinvoice table
        mycursor.execute(update_query, (total_amount, header_id))
        mydb.commit()

    except Exception as e:
        raise e

    finally:
        # Close the cursor
        mycursor.close()