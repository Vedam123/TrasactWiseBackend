from flask import jsonify, request, Blueprint
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger

update_ir_status_api = Blueprint('update_ir_status_api', __name__)

@update_ir_status_api.route('/update_transaction_status', methods=['PUT'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def update_ir_status():
    MODULE_NAME = __name__

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

        logger.debug(f"{appuser} --> {MODULE_NAME}: Entered the 'update transaction status' function")

        mycursor = mydb.cursor()
        # Assuming you receive the updated data as JSON in the request body
        data = request.get_json()

        # Extract the transaction_id, transaction_type, and target_status from the request data
        transaction_id = data.get('transaction_id')
        transaction_type = data.get('transaction_type')
        target_status = data.get('target_status')

        # Check if transaction_id, transaction_type, and target_status are provided
        if transaction_id is None or transaction_type is None or target_status is None:
            logger.error(f"{appuser} --> {MODULE_NAME}: Missing required parameters in the request")
            return jsonify({'error': 'Missing required parameters in the request'}), 400

        # Construct the update query based on transaction_type
        if transaction_type == 'Receipts':
            update_query = """
                UPDATE inv.receipts
                SET
                    status = %s,
                    updated_at = NOW(),  -- Use appropriate function for your database
                    updated_by = %s
                WHERE receipt_id = %s
            """
        elif transaction_type == 'Inspections':
            update_query = """
                UPDATE inv.inspection
                SET
                    status = %s,
                    updated_at = NOW(),  -- Use appropriate function for your database
                    updated_by = %s
                WHERE inspection_id = %s
            """
        else:
            logger.error(f"{appuser} --> {MODULE_NAME}: Invalid transaction_type provided in the request")
            return jsonify({'error': 'Invalid transaction_type provided in the request'}), 400

        # Assuming you have the updated values in the request data
        values = (
            target_status,
            appuserid,
            transaction_id
        )

        mycursor.execute(update_query, values)

        # Check if the update query is executed successfully
        if mycursor.rowcount > 0:
            mydb.commit()
            logger.info(
                f"{appuser} --> {MODULE_NAME}: Successfully updated transaction status. "
                f"transaction_id: {transaction_id}, "
                f"Updated values: {', '.join(f'{key}={value}' for key, value in zip(('status', 'updated_by'), values[:-2]))}, "
                f"Request variables: {data}"
            )
            return jsonify({'message': 'Transaction status updated successfully'})
        else:
            logger.warning(
                f"{appuser} --> {MODULE_NAME}: No rows were affected. Transaction status might not have been updated. "
                f"Request variables: {data}"
            )
            return jsonify({'message': 'No rows were affected. Transaction status might not have been updated.'}), 200

    except Exception as e:
        logger.error(f"{appuser} --> {MODULE_NAME}: Error updating transaction status - {str(e)}")
        return jsonify({'error': 'Internal Server Error'}), 500
    finally:
        mycursor.close()
        mydb.close()
