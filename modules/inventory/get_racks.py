from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

get_racks_api = Blueprint('get_racks_api', __name__)

@get_racks_api.route('/get_racks', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_racks():
    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        logger.debug(f"{USER_ID} --> {__name__}: Entered the 'get racks' function")

        mydb = get_database_connection(USER_ID, __name__)
        mycursor = mydb.cursor()

        rack_id_param = request.args.get('rack_id')
        rack_name_param = request.args.get('rack_name')
        row_id_param = request.args.get('row_id')
        aisle_id_param = request.args.get('aisle_id')
        zone_id_param = request.args.get('zone_id')
        location_id_param = request.args.get('location_id')
        warehouse_id_param = request.args.get('warehouse_id')
        row_name_param = request.args.get('row_name')
        aisle_name_param = request.args.get('aisle_name')
        zone_name_param = request.args.get('zone_name')
        location_name_param = request.args.get('location_name')
        warehouse_name_param = request.args.get('warehouse_name')

        query_params = {
            'rack_id_param': rack_id_param,
            'rack_name_param': rack_name_param,
            'row_id_param': row_id_param,
            'aisle_id_param': aisle_id_param,
            'zone_id_param': zone_id_param,
            'location_id_param': location_id_param,
            'warehouse_id_param': warehouse_id_param,
            'row_name_param': row_name_param,
            'aisle_name_param': aisle_name_param,
            'zone_name_param': zone_name_param,
            'location_name_param': location_name_param,
            'warehouse_name_param': warehouse_name_param,
        }

        query = """
            SELECT r.rack_id, r.rack_name, r.description, r.created_at, r.updated_at,
                   r.created_by, r.updated_by, ir.row_id, ir.row_name,
                   ir.description as row_description,
                   ir.created_at as row_created_at, ir.updated_at as row_updated_at,
                   ir.created_by as row_created_by, ir.updated_by as row_updated_by,
                   a.aisle_id, a.aisle_name, a.description as aisle_description,
                   a.created_at as aisle_created_at, a.updated_at as aisle_updated_at,
                   a.created_by as aisle_created_by, a.updated_by as aisle_updated_by,
                   z.zone_id, z.zone_name, z.description as zone_description,
                   z.created_at as zone_created_at, z.updated_at as zone_updated_at,
                   z.created_by as zone_created_by, z.updated_by as zone_updated_by,
                   l.location_id, l.location_name, l.location_type,
                   l.description as location_description,
                   l.capacity as location_capacity,
                   l.temperature_controlled as location_temperature_controlled,
                   l.security_level as location_security_level,
                   l.created_at as location_created_at, l.updated_at as location_updated_at,
                   l.created_by as location_created_by, l.updated_by as location_updated_by,
                   w.warehouse_id, w.warehouse_name, w.description as warehouse_description,
                   w.address_line1, w.address_line2, w.city, w.state, w.postal_code, w.country,
                   w.capacity as warehouse_capacity,
                   w.temperature_controlled as warehouse_temperature_controlled,
                   w.security_level as warehouse_security_level,
                   w.created_at as warehouse_created_at, w.updated_at as warehouse_updated_at,
                   w.created_by as warehouse_created_by, w.updated_by as warehouse_updated_by
            FROM inv.racks r
            JOIN inv.invrows ir ON r.row_id = ir.row_id
            JOIN inv.aisles a ON ir.aisle_id = a.aisle_id
            JOIN inv.zones z ON a.zone_id = z.zone_id
            JOIN inv.locations l ON z.location_id = l.location_id
            JOIN inv.warehouses w ON l.warehouse_id = w.warehouse_id
            WHERE (%(rack_id_param)s IS NULL OR r.rack_id = %(rack_id_param)s)
              AND (%(rack_name_param)s IS NULL OR r.rack_name REGEXP %(rack_name_param)s)
              AND (%(row_id_param)s IS NULL OR r.row_id = %(row_id_param)s)
              AND (%(aisle_id_param)s IS NULL OR ir.aisle_id = %(aisle_id_param)s)
              AND (%(zone_id_param)s IS NULL OR a.zone_id = %(zone_id_param)s)
              AND (%(location_id_param)s IS NULL OR z.location_id = %(location_id_param)s)
              AND (%(warehouse_id_param)s IS NULL OR l.warehouse_id = %(warehouse_id_param)s)
              AND (%(row_name_param)s IS NULL OR ir.row_name REGEXP %(row_name_param)s)
              AND (%(aisle_name_param)s IS NULL OR a.aisle_name REGEXP %(aisle_name_param)s)
              AND (%(zone_name_param)s IS NULL OR z.zone_name REGEXP %(zone_name_param)s)
              AND (%(location_name_param)s IS NULL OR l.location_name REGEXP %(location_name_param)s)
              AND (%(warehouse_name_param)s IS NULL OR w.warehouse_name REGEXP %(warehouse_name_param)s)
        """

        mycursor.execute(query, query_params)

        result = mycursor.fetchall()
        rack_list = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        for row in result:
            rack_dict = {}

            for column in columns:
                rack_dict[column] = row[column_indices[column]]

            rack_list.append(rack_dict)

        mycursor.close()
        mydb.close()

        logger.debug(f"{USER_ID} --> {__name__}: Successfully retrieved rack data")

        return jsonify({'rack_list': rack_list})

    except Exception as e:
        logger.error(f"{USER_ID} --> {__name__}: Error retrieving rack data - {str(e)}")
        return jsonify({'error': 'Internal Server Error'}), 500
