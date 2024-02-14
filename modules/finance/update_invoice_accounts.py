# Import the relevant modules
from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

# Define the Blueprint
update_invoice_accounts_api = Blueprint('update_invoice_accounts_api', __name__)

@update_invoice_accounts_api.route('/update_invoice_accounts/<int:header_id>/<string:line_number>', methods=['PUT'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def update_invoice_accounts(header_id, line_number):
    try:
        authorization_header = request.headers.get('Authorization')
        token_results = ""
        USER_ID = ""
        MODULE_NAME = __name__
        if authorization_header:
            token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
            token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None

        # Log entry point
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'update_invoice_accounts' function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)

        current_userid = None
        authorization_header = request.headers.get('Authorization', '')
        if authorization_header.startswith('Bearer '):
            token = authorization_header.replace('Bearer ', '')
            decoded_token = decode_token(token)
            current_userid = decoded_token.get('Userid')

        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        # Log the received data
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Received data: {data}")

        # Check if any of the required fields are missing
        if not all(key in data for key in ['account_id', 'debitamount', 'creditamount']):
            return jsonify({'error': 'Missing required fields: account_id, debitamount, creditamount'}), 400

        # Typecast fields to appropriate types
        account_id = int(data.get('account_id'))
        debitamount = float(data.get('debitamount'))
        creditamount = float(data.get('creditamount'))

        # Check if a record exists with the given header_id and line_number
        record_exists = record_exists_in_database(mydb, header_id, line_number)

        if record_exists:
            # Update the existing record
            update_query = """
                UPDATE fin.purchaseinvoiceaccounts
                SET account_id = %s, debitamount = %s, creditamount = %s, updated_by = %s
                WHERE line_number = %s AND header_id = %s
            """
            update_values = (
                account_id,
                debitamount,
                creditamount,
                current_userid,  # updated_by
                line_number,     # line_number to be updated
                header_id        # header_id to be updated
            )
        else:
            # Insert a new record
            update_query = """
                INSERT INTO fin.purchaseinvoiceaccounts (header_id, line_number, account_id, debitamount, creditamount, created_by, updated_by)
                VALUES (%s, %s, %s, %s, %s, %s, %s)
            """
            update_values = (
                header_id,
                line_number,
                account_id,
                debitamount,
                creditamount,
                current_userid,  # created_by
                current_userid   # updated_by
            )

        mycursor = mydb.cursor()

        try:
            mycursor.execute(update_query, update_values)
            mydb.commit()

            if record_exists:
                # Log success for update
                logger.info(f"{USER_ID} --> {MODULE_NAME}: Updated purchase invoice account with line ID: {line_number}")
            else:
                # Log success for insert
                logger.info(f"{USER_ID} --> {MODULE_NAME}: Inserted purchase invoice account with line ID: {line_number}")

            # Close the cursor and connection
            mycursor.close()
            mydb.close()

            return jsonify({'success': True, 'message': 'Purchase Invoice Account updated successfully'}), 200

        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{USER_ID} --> {MODULE_NAME}: Unable to update or insert purchase invoice account with line ID {line_number}: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500

    except Exception as e:
        # Log any exceptions
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500

def record_exists_in_database(mydb, header_id, line_number):
    try:
        # Query to check if a record exists with the given header_id and line_number
        select_query = """
            SELECT COUNT(*) 
            FROM fin.purchaseinvoiceaccounts 
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
