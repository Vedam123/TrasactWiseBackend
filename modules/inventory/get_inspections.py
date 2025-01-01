from flask import jsonify, request, Blueprint
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import READ_ACCESS_TYPE
from modules.utilities.logger import logger

get_inspections_api = Blueprint('get_inspections_api', __name__)

@get_inspections_api.route('/get_inspections', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_inspections():
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

        logger.debug(f"{appuser} --> {MODULE_NAME}: Entered the 'get inspections' function")

        mycursor = mydb.cursor()

        query_params = {
            'inspection_id_param': request.args.get('inspection_id_param'),
            'inspection_location_id_param': request.args.get('inspection_location_id_param'),
            'transaction_type_param': request.args.get('transaction_type_param'),
            'item_name_param': request.args.get('item_name_param'),
            'transaction_number_param': request.args.get('transaction_number_param'),
            'status_param': request.args.get('status_param'),  # Add status parameter
            # Add other parameters as needed
        }

        print(query_params)

        query = """
            SELECT i.*, l.location_name, l.location_type, l.warehouse_id, u.uom_name, u.abbreviation, it.item_code, it.item_name,
                   i.created_at, i.updated_at, i.created_by, i.updated_by,
                   i.accepted_qty_details, i.rejected_qty_details  -- Include new fields
            FROM inv.inspection i
            JOIN inv.locations l ON i.inspection_location_id = l.location_id
            JOIN com.uom u ON i.uom_id = u.uom_id
            JOIN com.items it ON i.item_id = it.item_id
            WHERE (%(inspection_id_param)s IS NULL OR i.inspection_id = %(inspection_id_param)s)
              AND (%(inspection_location_id_param)s IS NULL OR i.inspection_location_id = %(inspection_location_id_param)s)
              AND (%(transaction_type_param)s IS NULL OR i.transaction_type = %(transaction_type_param)s)
              AND (%(item_name_param)s IS NULL OR it.item_name = %(item_name_param)s)
              AND (%(transaction_number_param)s IS NULL OR i.transaction_number = %(transaction_number_param)s)
              AND (%(status_param)s IS NULL OR i.status = %(status_param)s)  -- Include status condition
              -- Add other conditions using query_params
        """

        mycursor.execute(query, query_params)

        result = mycursor.fetchall()
        inspections_list = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        for row in result:
            inspection_dict = {}

            for column in columns:
                inspection_dict[column] = row[column_indices[column]]

            inspections_list.append(inspection_dict)

        mycursor.close()
        mydb.close()

        logger.debug(f"{appuser} --> {MODULE_NAME}: Successfully retrieved inspections data")

        return jsonify({'inspections_list': inspections_list})

    except Exception as e:
        logger.error(f"{appuser} --> {MODULE_NAME}: Error retrieving inspections data - {str(e)}")
        return jsonify({'error': 'Internal Server Error'}), 500
