# Assuming you have already imported the necessary modules and set up your database connection

from flask import jsonify, request, Blueprint
from modules.security.permission_required import permission_required
from modules.admin.databases.mydb import get_database_connection
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.inventory.routines.update_receipt_and_po import update_receipt_and_po
from modules.utilities.logger import logger

update_inspection_api = Blueprint('update_inspection_api', __name__)
@update_inspection_api.route('/update_inspection', methods=['PUT'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def update_inspection():
    MODULE_NAME = __name__

    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'update inspection' function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)
        mycursor = mydb.cursor()

        current_userid = None
        authorization_header = request.headers.get('Authorization', '')
        if authorization_header.startswith('Bearer '):
            token = authorization_header.replace('Bearer ', '')
            decoded_token = decode_token(token)
            current_userid = decoded_token.get('Userid')

        # Assuming you receive the updated data as JSON in the request body
        data = request.get_json()

        # Extract the inspection_id and transaction_header_number from the request data
        inspection_id = data.get('inspection_id')
        transaction_header_number = data.get('transaction_header_number')
        transaction_status = data.get('status')
        transaction_number = data.get('transaction_number')
        transaction_type = data.get('transaction_type')

        # Check if inspection_id and transaction_header_number are provided
        if inspection_id is None or transaction_header_number is None:
            logger.error(f"{USER_ID} --> {MODULE_NAME}: Missing inspection_id or transaction_header_number in the request")
            return jsonify({'error': 'Missing inspection_id or transaction_header_number in the request'}), 400

        # Additional validation: Check if sum of accepted_quantity and rejected_quantity matches transaction_quantity
        transaction_quantity = data.get('transaction_quantity')
        accepted_quantity = data.get('accepted_quantity')
        rejected_quantity = data.get('rejected_quantity')
        logger.debug(
            f"{USER_ID} --> {MODULE_NAME}: Received update request for inspection_id {inspection_id}. "
            f"Transaction Quantity: {transaction_quantity}, Accepted Quantity: {accepted_quantity}, Rejected Quantity: {rejected_quantity}"
            )
        if (accepted_quantity + rejected_quantity) != transaction_quantity:
            logger.warning(
                f"{USER_ID} --> {MODULE_NAME}: Sum of accepted_quantity and rejected_quantity does not match transaction_quantity. "
                f"Request variables: {data}"
            )
            return jsonify({'error': 'Sum of accepted_quantity and rejected_quantity does not match transaction_quantity.'}), 400
        logger.debug(
            f"{USER_ID} --> {MODULE_NAME}: Validation successful. Sum of accepted_quantity and rejected_quantity matches transaction_quantity."
            )

        # Construct the update query
        update_query = """
            UPDATE inv.inspection
            SET
                inspection_name = %s,
                accepted_quantity = %s,
                rejected_quantity = %s,
                status = %s,
                accepted_qty_details = %s,
                rejected_qty_details = %s,
                comments = %s,
                updated_at = NOW(),  -- Use appropriate function for your database
                updated_by = %s
            WHERE inspection_id = %s
                AND transaction_number = %s
                AND transaction_type = %s
                AND transaction_header_number = %s  -- Include transaction_header_number in the WHERE clause
        """

        # Assuming you have the updated values in the request data
        values = (
            data.get('inspection_name'),
            data.get('accepted_quantity'),
            data.get('rejected_quantity'),
            data.get('status'),
            data.get('accepted_qty_details'),
            data.get('rejected_qty_details'),
            data.get('comments'),
            current_userid,
            inspection_id,
            data.get('transaction_number'),
            data.get('transaction_type'),
            transaction_header_number  # Include transaction_header_number in the values tuple
        )

        mycursor.execute(update_query, values)

        # Check if the update query is executed successfully
        if mycursor.rowcount > 0:
            mydb.commit()
            logger.info("Inspection data updated successfully")

            # Call the update_receipt_and_po_status function
            if update_receipt_and_po(USER_ID, MODULE_NAME, mydb, transaction_number, transaction_header_number, transaction_status, transaction_type,accepted_quantity):
                return jsonify({'message': 'Inspection data updated successfully'}), 200
            else:
                return jsonify({'error': 'Failed to update receipt and po status'}), 500

        else:
            # Handle the case where no rows were affected
            logger.warning("No rows were affected. Inspection data might not have been updated.")
            return jsonify({'message': 'No rows were affected. Inspection data might not have been updated.'}), 200
        
    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error updating inspection data - {str(e)}, Request variables: {data}")
        return jsonify({'error': 'Internal Server Error'}), 500
    finally:
        mycursor.close()
        mydb.close()
