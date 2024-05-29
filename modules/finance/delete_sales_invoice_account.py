from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

# Define the Blueprint
delete_sales_invoice_account_api = Blueprint('delete_sales_invoice_account_api', __name__)

# Define the route
@delete_sales_invoice_account_api.route('/delete_sales_invoice_account', methods=['DELETE'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def delete_sales_invoice_account():
    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header) if authorization_header else None
        USER_ID = token_results["username"] if token_results else ""
        MODULE_NAME = __name__

        # Log entry point
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'delete_sales_invoice_account' function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)

        current_userid = decode_token(authorization_header.replace('Bearer ', '')).get('Userid') if authorization_header.startswith('Bearer ') else None

        # Check content type
        if request.content_type != 'application/json':
            return jsonify({'error': 'Content-Type must be application/json'}), 400

        data = request.get_json()

        # Log the received data
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Received data: {data}")

        # Check required fields
        if 'line_id' not in data or 'header_id' not in data:
            return jsonify({'error': 'Both line_id and header_id are required'}), 400

        line_id = data['line_id']
        header_id = data['header_id']

        # Check if the record exists
        check_query = """
            SELECT COUNT(*) FROM fin.salesinvoiceaccounts WHERE line_id = %s AND header_id = %s
        """

        check_values = (line_id, header_id)

        mycursor = mydb.cursor()

        try:
            mycursor.execute(check_query, check_values)
            result = mycursor.fetchone()[0]

            if result == 0:
                # Log warning and close the cursor and connection
                logger.warning(f"{USER_ID} --> {MODULE_NAME}: No matching record found for deletion")
                mycursor.close()
                mydb.close()
                return jsonify({'message': 'No matching record found for deletion'}), 404

            # If the record exists, proceed with deletion
            delete_query = """
                DELETE FROM fin.salesinvoiceaccounts WHERE line_id = %s AND header_id = %s
            """

            delete_values = (line_id, header_id)

            mycursor.execute(delete_query, delete_values)
            mydb.commit()

            # Log success and close the cursor and connection
            logger.info(f"{USER_ID} --> {MODULE_NAME}: Account data deleted successfully")
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Account deleted successfully'}), 200

        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{USER_ID} --> {MODULE_NAME}: Unable to delete account data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500

    except Exception as e:
        # Log any exceptions
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
