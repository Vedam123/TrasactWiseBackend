from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE, WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

zones_api = Blueprint('zones_api', __name__)

@zones_api.route('/get_zones', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_zones():
    MODULE_NAME = __name__

    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'get zones' function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)
        mycursor = mydb.cursor()

        zone_id_param = request.args.get('zone_id')
        location_id_param = request.args.get('location_id')
        zone_name_param = request.args.get('zone_name')
        location_name_param = request.args.get('location_name')

        query_params = {
            'zone_id_param': zone_id_param,
            'location_id_param': location_id_param,
            'zone_name_param': zone_name_param,
            'location_name_param': location_name_param,
        }

        query = """
            SELECT z.zone_id, z.location_id, z.zone_name, z.description, z.capacity,
                   z.created_at, z.updated_at, z.created_by, z.updated_by,
                   l.location_name
            FROM inv.zones z
            LEFT JOIN inv.locations l ON z.location_id = l.location_id
            WHERE (%(zone_id_param)s IS NULL OR z.zone_id = %(zone_id_param)s)
              AND (%(location_id_param)s IS NULL OR z.location_id = %(location_id_param)s)
              AND (%(zone_name_param)s IS NULL OR z.zone_name REGEXP %(zone_name_param)s)
              AND (%(location_name_param)s IS NULL OR l.location_name REGEXP %(location_name_param)s)
        """

        mycursor.execute(query, query_params)

        result = mycursor.fetchall()
        zone_list = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        for row in result:
            zone_dict = {}

            for column in columns:
                zone_dict[column] = row[column_indices[column]]

            zone_list.append(zone_dict)

        mycursor.close()
        mydb.close()

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Successfully retrieved zone data")

        return jsonify({'zone_list': zone_list})

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error retrieving zone data - {str(e)}")
        return jsonify({'error': 'Internal Server Error'}), 500