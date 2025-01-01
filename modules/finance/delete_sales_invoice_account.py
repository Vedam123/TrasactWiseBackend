from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger

# Define the Blueprint
delete_sales_invoice_account_api = Blueprint('delete_sales_invoice_account_api', __name__)

# Define the route
@delete_sales_invoice_account_api.route('/delete_sales_invoice_account', methods=['DELETE'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def delete_sales_invoice_account():
    try:
       	
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
        logger.debug(f"{appuser} --> {__name__}: Entered the 'delete_sales_invoice_account' function")

       # Check content type
        if request.content_type != 'application/json':
            return jsonify({'error': 'Content-Type must be application/json'}), 400

        data = request.get_json()

        # Log the received data
        logger.debug(f"{appuser} --> {__name__}: Received data: {data}")

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
                logger.warning(f"{appuser} --> {__name__}: No matching record found for deletion")
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
            logger.info(f"{appuser} --> {__name__}: Account data deleted successfully")
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Account deleted successfully'}), 200

        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{appuser} --> {__name__}: Unable to delete account data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500

    except Exception as e:
        # Log any exceptions
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
