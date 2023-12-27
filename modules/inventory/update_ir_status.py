from flask import jsonify, request, Blueprint
from modules.security.permission_required import permission_required
from modules.admin.databases.mydb import get_database_connection
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

update_ir_status_api = Blueprint('update_ir_status_api', __name__)

@update_ir_status_api.route('/update_transaction_status', methods=['PUT'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def update_ir_status():
    MODULE_NAME = __name__

    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'update transaction status' function")

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

        # Extract the transaction_id, transaction_type, and target_status from the request data
        transaction_id = data.get('transaction_id')
        transaction_type = data.get('transaction_type')
        target_status = data.get('target_status')

        # Check if transaction_id, transaction_type, and target_status are provided
        if transaction_id is None or transaction_type is None or target_status is None:
            logger.error(f"{USER_ID} --> {MODULE_NAME}: Missing required parameters in the request")
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
            logger.error(f"{USER_ID} --> {MODULE_NAME}: Invalid transaction_type provided in the request")
            return jsonify({'error': 'Invalid transaction_type provided in the request'}), 400

        # Assuming you have the updated values in the request data
        values = (
            target_status,
            current_userid,
            transaction_id
        )

        mycursor.execute(update_query, values)

        # Check if the update query is executed successfully
        if mycursor.rowcount > 0:
            mydb.commit()
            logger.info(
                f"{USER_ID} --> {MODULE_NAME}: Successfully updated transaction status. "
                f"transaction_id: {transaction_id}, "
                f"Updated values: {', '.join(f'{key}={value}' for key, value in zip(('status', 'updated_by'), values[:-2]))}, "
                f"Request variables: {data}"
            )
            return jsonify({'message': 'Transaction status updated successfully'})
        else:
            logger.warning(
                f"{USER_ID} --> {MODULE_NAME}: No rows were affected. Transaction status might not have been updated. "
                f"Request variables: {data}"
            )
            return jsonify({'message': 'No rows were affected. Transaction status might not have been updated.'}), 200

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error updating transaction status - {str(e)}")
        return jsonify({'error': 'Internal Server Error'}), 500
    finally:
        mycursor.close()
        mydb.close()
