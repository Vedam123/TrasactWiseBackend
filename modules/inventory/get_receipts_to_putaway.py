from flask import jsonify, request, Blueprint
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import READ_ACCESS_TYPE
from modules.utilities.logger import logger

get_receipts_api = Blueprint('get_receipts_api', __name__)

# ... (Previous imports and code)

@get_receipts_api.route('/get_receipts_to_putaway', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_receipts_to_putaway():
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

        status_param_string = request.args.get('status_param', '')
        status_params_list = [param.strip() for param in status_param_string.split(',')]
        status_param_string1 = ','.join(f"'{item}'" for item in status_params_list)
        transaction_number_param = request.args.get('transaction_number_param', 'NULL')
        receipt_id_param = request.args.get('receipt_id_param', 'NULL')
        print("Status param string ",status_param_string1)
        query_params = {
            'transaction_number': transaction_number_param,
            'receipt_id': receipt_id_param,
            'status_params_list': status_param_string1  # Use status_params_list here            
        }

        query = """
            SELECT r.*, l.location_name, u.uom_name, u.abbreviation, i.item_code, i.item_name,
                   r.created_at, r.updated_at, r.created_by, r.updated_by,
                   r.inspect, r.transaction_number, r.status,  -- Include new fields
                   r.accepted_qty, r.rejected_qty, r.inspection_id  -- Add the new fields
            FROM inv.receipts r
            JOIN inv.locations l ON r.receiving_location_id = l.location_id
            JOIN com.uom u ON r.uom_id = u.uom_id
            JOIN com.items i ON r.item_id = i.item_id
            WHERE (%(transaction_number)s IS NULL OR r.transaction_number = %(transaction_number)s)
            AND (%(receipt_id)s IS NULL OR r.receipt_id = %(receipt_id)s)
              -- Add other conditions using query_params
        """

        if status_param_string:
            query += f" AND BINARY r.status IN (%(status_params_list)s)"

        print("\nFull Query:")
        print(query)

        actual_query = query % query_params
        print("Actual query with values -->", actual_query)
        mycursor.execute(actual_query)  

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
