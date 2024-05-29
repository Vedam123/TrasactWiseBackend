from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

# Define the Blueprint 
update_sales_invoice_accounts_api = Blueprint('update_sales_invoice_accounts_api', __name__)

@update_sales_invoice_accounts_api.route('/update_sales_invoice_accounts', methods=['PUT'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def update_sales_invoice_accounts():
    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header) if authorization_header else None
        USER_ID = token_results["username"] if token_results else ""
        MODULE_NAME = __name__

        # Log entry point
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'update_invoice_accounts' function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)

        current_userid = decode_token(authorization_header.replace('Bearer ', '')).get('Userid') if authorization_header.startswith('Bearer ') else None

        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        # Log the received data
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Received data: {data}")

        # Check if any of the required fields are missing
        if not all(key in data for key in ['header_id', 'lines']):
            return jsonify({'error': 'Missing required fields: header_id, lines'}), 400

        # Extract header_id from the request
        header_id = int(data.get('header_id'))

        # Get lines from the request
        lines = data.get('lines', [])

        if not lines:
            return jsonify({'error': 'At least one line is required'}), 400

        messages = []  # Accumulate messages for each line

        for line in lines:
            # Extract line specific fields
            line_id = line.get('line_id')
            line_number = line.get('line_number')
            account_id = int(line.get('account_id'))
            debitamount = float(line.get('debitamount'))
            creditamount = float(line.get('creditamount'))

            # Check if a record exists with the given header_id and line_number
            record_exists = record_exists_in_database(mydb, header_id, line_number)

            if record_exists:
                # Update the existing record
                update_existing_record(mydb, header_id, line_number, account_id, debitamount, creditamount, current_userid)
                message = f"Data for header_id {header_id} and line_number {line_number} is updated in the system"
            else:
                # Insert a new record
                insert_new_record(mydb, header_id, line_number, account_id, debitamount, creditamount, current_userid)
                message = f"Data for header_id {header_id} and line_number {line_number} is inserted in the system"

            messages.append(message)  # Add message for current line to the list

        # Log success
        logger.info(f"{USER_ID} --> {MODULE_NAME}: Updated or inserted invoice accounts")

        # Close the database connection
        mydb.close()

        # Return all messages in the response
        return jsonify({'success': True, 'messages': messages}), 200

    except Exception as e:
        # Log any exceptions
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500

def record_exists_in_database(mydb, header_id, line_number):
    try:
        # Query to check if a record exists with the given header_id and line_number
        select_query = """
            SELECT COUNT(*) 
            FROM fin.salesinvoiceaccounts 
            WHERE header_id = %s AND line_number = %s
        """

        # Initialize the cursor
        mycursor = mydb.cursor()

        # Execute the select query
        mycursor.execute(select_query, (header_id, line_number))
        result = mycursor.fetchone()

        # Check if any record exists
        return result[0] > 0

    except Exception as e:
        raise e

    finally:
        # Close the cursor
        mycursor.close()

def update_existing_record(mydb, header_id, line_number, account_id, debitamount, creditamount, current_userid):
    try:
        # Update query
        update_query = """
            UPDATE fin.salesinvoiceaccounts
            SET account_id = %s, debitamount = %s, creditamount = %s, updated_by = %s
            WHERE header_id = %s AND line_number = %s
        """

        # Initialize the cursor
        mycursor = mydb.cursor()

        # Execute the update query
        mycursor.execute(update_query, (account_id, debitamount, creditamount, current_userid, header_id, line_number))
        mydb.commit()

    except Exception as e:
        raise e

    finally:
        # Close the cursor
        mycursor.close()

def insert_new_record(mydb, header_id, line_number, account_id, debitamount, creditamount, current_userid):
    try:
        # Insert query
        insert_query = """
            INSERT INTO fin.salesinvoiceaccounts (header_id, line_number, account_id, debitamount, creditamount, created_by, updated_by)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
        """

        # Initialize the cursor
        mycursor = mydb.cursor()

        # Execute the insert query
        mycursor.execute(insert_query, (header_id, line_number, account_id, debitamount, creditamount, current_userid, current_userid))
        mydb.commit()

    except Exception as e:
        raise e

    finally:
        # Close the cursor
        mycursor.close()
