from flask import jsonify, request, Blueprint
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import READ_ACCESS_TYPE
from modules.utilities.logger import logger

get_receipts_api = Blueprint('get_receipts_api', __name__)

@get_receipts_api.route('/get_receipts', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_receipts():
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

        logger.debug(f"{appuser} --> {MODULE_NAME}: Entered the 'get receipts' function")

        mycursor = mydb.cursor()

        query_params = {
            'receipt_id': request.args.get('receipt_id'),
            'receiving_location_id': request.args.get('receiving_location_id'),
            'transaction_number': request.args.get('transaction_number'),
            'transaction_header_number': request.args.get('transaction_header_number'),  # Include new parameter
            # Add other parameters as needed
        }

        query = """
            SELECT r.*, l.location_name, u.uom_name, u.abbreviation, i.item_code, i.item_name,
                   r.created_at, r.updated_at, r.created_by, r.updated_by,
                   r.inspect, r.transaction_number, r.status,
                   r.accepted_qty, r.rejected_qty, r.inspection_id, r.transaction_header_number  
            FROM inv.receipts r
            JOIN inv.locations l ON r.receiving_location_id = l.location_id
            JOIN com.uom u ON r.uom_id = u.uom_id
            JOIN com.items i ON r.item_id = i.item_id
            WHERE (%(receipt_id)s IS NULL OR r.receipt_id = %(receipt_id)s)
              AND (%(receiving_location_id)s IS NULL OR r.receiving_location_id = %(receiving_location_id)s)
              AND (%(transaction_number)s IS NULL OR r.transaction_number = %(transaction_number)s)
              AND (%(transaction_header_number)s IS NULL OR r.transaction_header_number = %(transaction_header_number)s) 
              -- Add other conditions using query_params
        """

        mycursor.execute(query, query_params)

        result = mycursor.fetchall()
        receipts_list = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        for row in result:
            receipt_dict = {}

            for column in columns:
                receipt_dict[column] = row[column_indices[column]]

            receipts_list.append(receipt_dict)

        mycursor.close()
        mydb.close()

        logger.debug(f"{appuser} --> {MODULE_NAME}: Successfully retrieved receipts data")

        return jsonify({'receipts_list': receipts_list})

    except Exception as e:
        logger.error(f"{appuser} --> {MODULE_NAME}: Error retrieving receipts data - {str(e)}")
        return jsonify({'error': 'Internal Server Error'}), 500