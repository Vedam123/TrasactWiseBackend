# invrows_routes.py
from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import READ_ACCESS_TYPE
from modules.utilities.logger import logger

invrows_api = Blueprint('invrows_api', __name__)

@invrows_api.route('/get_invrows', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_invrows():
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

        logger.debug(f"{appuser} --> {MODULE_NAME}: Entered the 'get invrows' function")

        mycursor = mydb.cursor()

        row_id_param = request.args.get('row_id')
        aisle_id_param = request.args.get('aisle_id')
        row_name_param = request.args.get('row_name')
        zone_id_param = request.args.get('zone_id')
        location_id_param = request.args.get('location_id')
        warehouse_id_param = request.args.get('warehouse_id')
        aisle_name_param = request.args.get('aisle_name')
        zone_name_param = request.args.get('zone_name')
        location_name_param = request.args.get('location_name')
        warehouse_name_param = request.args.get('warehouse_name')

        query_params = {
            'row_id_param': row_id_param,
            'aisle_id_param': aisle_id_param,
            'row_name_param': row_name_param,
            'zone_id_param': zone_id_param,
            'location_id_param': location_id_param,
            'warehouse_id_param': warehouse_id_param,
            'aisle_name_param': aisle_name_param,
            'zone_name_param': zone_name_param,
            'location_name_param': location_name_param,
            'warehouse_name_param': warehouse_name_param
        }

        query = """
            SELECT ir.row_id, ir.aisle_id, ir.row_name, ir.description, ir.created_at, ir.updated_at,
                   ir.created_by, ir.updated_by,
                   a.zone_id, z.zone_name, l.location_id, l.location_name,
                   w.warehouse_id, w.warehouse_name
            FROM inv.invrows ir
            LEFT JOIN inv.aisles a ON ir.aisle_id = a.aisle_id
            LEFT JOIN inv.zones z ON a.zone_id = z.zone_id
            LEFT JOIN inv.locations l ON z.location_id = l.location_id
            LEFT JOIN inv.warehouses w ON l.warehouse_id = w.warehouse_id
            WHERE (%(row_id_param)s IS NULL OR ir.row_id = %(row_id_param)s)
              AND (%(aisle_id_param)s IS NULL OR ir.aisle_id = %(aisle_id_param)s)
              AND (%(row_name_param)s IS NULL OR ir.row_name REGEXP %(row_name_param)s)
              AND (%(zone_id_param)s IS NULL OR a.zone_id = %(zone_id_param)s)
              AND (%(location_id_param)s IS NULL OR l.location_id = %(location_id_param)s)
              AND (%(warehouse_id_param)s IS NULL OR w.warehouse_id = %(warehouse_id_param)s)
              AND (%(aisle_name_param)s IS NULL OR a.aisle_name REGEXP %(aisle_name_param)s)
              AND (%(zone_name_param)s IS NULL OR z.zone_name REGEXP %(zone_name_param)s)
              AND (%(location_name_param)s IS NULL OR l.location_name REGEXP %(location_name_param)s)
              AND (%(warehouse_name_param)s IS NULL OR w.warehouse_name REGEXP %(warehouse_name_param)s)
        """

        mycursor.execute(query, query_params)

        result = mycursor.fetchall()
        invrows_list = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        for row in result:
            invrows_dict = {}

            for column in columns:
                invrows_dict[column] = row[column_indices[column]]

            invrows_list.append(invrows_dict)

        mycursor.close()
        mydb.close()

        logger.debug(f"{appuser} --> {MODULE_NAME}: Successfully retrieved invrows data")

        return jsonify({'invrows_list': invrows_list})

    except Exception as e:
        logger.error(f"{appuser} --> {MODULE_NAME}: Error retrieving invrows data - {str(e)}")
        return jsonify({'error': 'Internal Server Error', 'details': str(e)}), 500
