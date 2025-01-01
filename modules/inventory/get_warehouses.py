from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import READ_ACCESS_TYPE
from modules.utilities.logger import logger

warehouse_api = Blueprint('warehouse_api', __name__)

@warehouse_api.route('/get_warehouses', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_warehouses():
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

        logger.debug(f"{appuser} --> {MODULE_NAME}: Entered the 'get warehouses' function")

        mycursor = mydb.cursor()

        warehouse_id_param = request.args.get('warehouse_id')
        warehouse_name_param = request.args.get('warehouse_name')

        query_params = {
            'warehouse_id_param': warehouse_id_param,
            'warehouse_name_param': warehouse_name_param,
        }

        query = """
            SELECT warehouse_id, warehouse_name, description, address_line1, address_line2,
                   city, state, postal_code, country, capacity, temperature_controlled,
                   security_level, created_at, updated_at
            FROM inv.warehouses
            WHERE (%(warehouse_id_param)s IS NULL OR warehouse_id = %(warehouse_id_param)s)
              AND (%(warehouse_name_param)s IS NULL OR warehouse_name REGEXP %(warehouse_name_param)s)
        """

        mycursor.execute(query, query_params)

        result = mycursor.fetchall()
        warehouse_list = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        for row in result:
            warehouse_dict = {}

            for column in columns:
                warehouse_dict[column] = row[column_indices[column]]

            warehouse_list.append(warehouse_dict)

        mycursor.close()
        mydb.close()

        logger.debug(f"{appuser} --> {MODULE_NAME}: Successfully retrieved warehouse data")

        return jsonify({'warehouse_list': warehouse_list})

    except Exception as e:
        logger.error(f"{appuser} --> {MODULE_NAME}: Error retrieving warehouse data - {str(e)}")
        return jsonify({'error': 'Internal Server Error'}), 500
