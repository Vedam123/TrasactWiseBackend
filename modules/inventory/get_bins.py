# modules/inventory/get_bins.py

from flask import jsonify, request, Blueprint
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import READ_ACCESS_TYPE
from modules.utilities.logger import logger

get_bins_api = Blueprint('get_bins_api', __name__)

@get_bins_api.route('/get_bins', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_bins():
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

        logger.debug(f"{appuser} --> {MODULE_NAME}: Entered the 'get bins' function")

        mycursor = mydb.cursor()

        bin_id_param = request.args.get('bin_id')
        rack_id_param = request.args.get('rack_id')
        row_id_param = request.args.get('row_id')
        aisle_id_param = request.args.get('aisle_id')
        zone_id_param = request.args.get('zone_id')
        location_id_param = request.args.get('location_id')
        warehouse_id_param = request.args.get('warehouse_id')
        bin_name_param = request.args.get('bin_name')
        
        # Allow regular expressions for these fields
        zone_name_param = request.args.get('zone_name', default='.*')
        location_name_param = request.args.get('location_name', default='.*')
        row_name_param = request.args.get('row_name', default='.*')
        rack_name_param = request.args.get('rack_name', default='.*')
        aisle_name_param = request.args.get('aisle_name', default='.*')
        warehouse_name_param = request.args.get('warehouse_name', default='.*')

        query_params = {
            'bin_id_param': bin_id_param,
            'rack_id_param': rack_id_param,
            'row_id_param': row_id_param,
            'aisle_id_param': aisle_id_param,
            'zone_id_param': zone_id_param,
            'location_id_param': location_id_param,
            'warehouse_id_param': warehouse_id_param,
            'bin_name_param': bin_name_param,
            'zone_name_param': zone_name_param,
            'location_name_param': location_name_param,
            'row_name_param': row_name_param,
            'rack_name_param': rack_name_param,
            'aisle_name_param': aisle_name_param,
            'warehouse_name_param': warehouse_name_param,
        }

        query = """
            SELECT b.*, r.rack_name, ir.row_name, a.aisle_name, z.zone_name,
                   l.location_name, w.warehouse_name
            FROM inv.bins b
            JOIN inv.racks r ON b.rack_id = r.rack_id
            JOIN inv.invrows ir ON r.row_id = ir.row_id
            JOIN inv.aisles a ON ir.aisle_id = a.aisle_id
            JOIN inv.zones z ON a.zone_id = z.zone_id
            JOIN inv.locations l ON z.location_id = l.location_id
            JOIN inv.warehouses w ON l.warehouse_id = w.warehouse_id
            WHERE (%(bin_id_param)s IS NULL OR b.bin_id = %(bin_id_param)s)
              AND (%(rack_id_param)s IS NULL OR b.rack_id = %(rack_id_param)s)
              AND (%(row_id_param)s IS NULL OR r.row_id = %(row_id_param)s)
              AND (%(aisle_id_param)s IS NULL OR a.aisle_id = %(aisle_id_param)s)
              AND (%(zone_id_param)s IS NULL OR z.zone_id = %(zone_id_param)s)
              AND (%(location_id_param)s IS NULL OR l.location_id = %(location_id_param)s)
              AND (%(warehouse_id_param)s IS NULL OR w.warehouse_id = %(warehouse_id_param)s)
              AND (%(bin_name_param)s IS NULL OR b.bin_name REGEXP %(bin_name_param)s)
              AND (%(zone_name_param)s IS NULL OR z.zone_name REGEXP %(zone_name_param)s)
              AND (%(location_name_param)s IS NULL OR l.location_name REGEXP %(location_name_param)s)
              AND (%(row_name_param)s IS NULL OR ir.row_name REGEXP %(row_name_param)s)
              AND (%(rack_name_param)s IS NULL OR r.rack_name REGEXP %(rack_name_param)s)
              AND (%(aisle_name_param)s IS NULL OR a.aisle_name REGEXP %(aisle_name_param)s)
              AND (%(warehouse_name_param)s IS NULL OR w.warehouse_name REGEXP %(warehouse_name_param)s)
        """

        mycursor.execute(query, query_params)

        result = mycursor.fetchall()
        bin_list = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        for row in result:
            bin_dict = {}

            for column in columns:
                bin_dict[column] = row[column_indices[column]]

            bin_list.append(bin_dict)

        mycursor.close()
        mydb.close()

        logger.debug(f"{appuser} --> {MODULE_NAME}: Successfully retrieved bin data")

        return jsonify({'bin_list': bin_list})

    except Exception as e:
        logger.error(f"{appuser} --> {MODULE_NAME}: Error retrieving bin data - {str(e)}")
        return jsonify({'error': 'Internal Server Error'}), 500
