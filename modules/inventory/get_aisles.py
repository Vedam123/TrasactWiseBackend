from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import READ_ACCESS_TYPE
from modules.utilities.logger import logger

aisles_api = Blueprint('aisles_api', __name__)

@aisles_api.route('/get_aisles', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
# Update the get_aisles function in get_aisles.py
# Update the get_aisles function in get_aisles.py
def get_aisles():
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

        logger.debug(f"{appuser} --> {MODULE_NAME}: Entered the 'get aisles' function")

        mycursor = mydb.cursor()

        aisle_id_param = request.args.get('aisle_id')
        zone_id_param = request.args.get('zone_id')
        aisle_name_param = request.args.get('aisle_name')
        zone_name_param = request.args.get('zone_name')
        location_name_param = request.args.get('location_name')  # Added location_name
        warehouse_name_param = request.args.get('warehouse_name')  # Added warehouse_name

        query_params = {
            'aisle_id_param': aisle_id_param,
            'zone_id_param': zone_id_param,
            'aisle_name_param': aisle_name_param,
            'zone_name_param': zone_name_param,
            'location_name_param': location_name_param,  # Added location_name
            'warehouse_name_param': warehouse_name_param  # Added warehouse_name
        }

        query = """
            SELECT a.aisle_id, a.zone_id, a.aisle_name, a.description, a.created_at, a.updated_at,
                   a.created_by, a.updated_by,
                   z.location_id, l.location_name, l.location_type,
                   l.warehouse_id, w.warehouse_name, w.description as warehouse_description,
                   z.zone_name
            FROM inv.aisles a
            LEFT JOIN inv.zones z ON a.zone_id = z.zone_id
            LEFT JOIN inv.locations l ON z.location_id = l.location_id
            LEFT JOIN inv.warehouses w ON l.warehouse_id = w.warehouse_id
            WHERE (%(aisle_id_param)s IS NULL OR a.aisle_id = %(aisle_id_param)s)
              AND (%(zone_id_param)s IS NULL OR a.zone_id = %(zone_id_param)s)
              AND (%(aisle_name_param)s IS NULL OR a.aisle_name REGEXP %(aisle_name_param)s)
              AND (%(zone_name_param)s IS NULL OR z.zone_name REGEXP %(zone_name_param)s)
              AND (%(location_name_param)s IS NULL OR l.location_name REGEXP %(location_name_param)s)
              AND (%(warehouse_name_param)s IS NULL OR w.warehouse_name REGEXP %(warehouse_name_param)s)
        """

        mycursor.execute(query, query_params)

        result = mycursor.fetchall()
        aisle_list = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        for row in result:
            aisle_dict = {}

            for column in columns:
                aisle_dict[column] = row[column_indices[column]]

            aisle_list.append(aisle_dict)

        mycursor.close()
        mydb.close()

        logger.debug(f"{appuser} --> {MODULE_NAME}: Successfully retrieved aisle data")

        return jsonify({'aisle_list': aisle_list})

    except Exception as e:
        logger.error(f"{appuser} --> {MODULE_NAME}: Error retrieving aisle data - {str(e)}")
        return jsonify({'error': 'Internal Server Error', 'details': str(e)}), 500
