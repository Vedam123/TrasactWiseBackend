# modules/inventory/get_item_inventory.py

from flask import jsonify, request, Blueprint
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

get_item_inventory_api = Blueprint('get_item_inventory_api', __name__)
# ... (previous imports and code)

@get_item_inventory_api.route('/get_item_inventory', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_item_inventory():
    MODULE_NAME = __name__

    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        logger.debug(
            f"{USER_ID} --> {MODULE_NAME}: Entered the 'get item inventory' function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)
        mycursor = mydb.cursor()

        # Extract all parameters from the request args
        query_params = {f"param_{param}": request.args.get(param) for param in request.args}

        if not query_params:
            query_params = {'param_1': 1}

        print(query_params)

        # Create a dynamic WHERE clause
        where_clauses = []
        for param, value in query_params.items():
            if value is not None:
                if param.startswith('param_item_id'):
                    where_clauses.append(f"(ii.item_id = %({param})s)")
                elif param.startswith('param_bin_id'):
                    where_clauses.append(f"(ii.bin_id = %({param})s)")
                elif param.startswith('param_rack_id'):
                    where_clauses.append(f"(ii.rack_id = %({param})s)")
                elif param.startswith('param_row_id'):
                    where_clauses.append(f"(ii.row_id = %({param})s)")
                elif param.startswith('param_aisle_id'):
                    where_clauses.append(f"(ii.aisle_id = %({param})s)")
                elif param.startswith('param_zone_id'):
                    where_clauses.append(f"(ii.zone_id = %({param})s)")
                elif param.startswith('param_location_id'):
                    where_clauses.append(f"(ii.location_id = %({param})s)")
                elif param.startswith('param_warehouse_id'):
                    where_clauses.append(f"(ii.warehouse_id = %({param})s)")
                elif param.startswith('param_additional_info'):
                    where_clauses.append(f"(ii.additional_info REGEXP %({param})s)")
                else:
                    where_clauses.append(f"({param[len('param_') : ]} = %({param})s)")

        # Construct the final query
        where_clause = ' AND '.join(where_clauses)
        print(where_clause)
        query = f"""
            SELECT ii.*, 
                b.bin_name, 
                i.item_code, 
                i.item_name, 
                u.abbreviation as uom_abbreviation, 
                u.uom_name, 
                r.rack_name, 
                ir.row_name, 
                a.aisle_name, 
                z.zone_name, 
                l.location_name, 
                w.warehouse_name,
                ii.additional_info  # Include additional_info in the SELECT statement
            FROM inv.item_inventory ii
            JOIN com.uom u ON ii.uom_id = u.uom_id
            JOIN com.items i ON ii.item_id = i.item_id
            LEFT JOIN inv.bins b ON ii.bin_id = b.bin_id
            LEFT JOIN inv.racks r ON ii.rack_id = r.rack_id
            LEFT JOIN inv.invrows ir ON ii.row_id = ir.row_id
            LEFT JOIN inv.aisles a ON ii.aisle_id = a.aisle_id
            LEFT JOIN inv.zones z ON ii.zone_id = z.zone_id
            LEFT JOIN inv.locations l ON ii.location_id = l.location_id
            LEFT JOIN inv.warehouses w ON ii.warehouse_id = w.warehouse_id
            WHERE {where_clause}  # Dynamic WHERE clause
        """

        logger.debug(f"Constructed query: {query}")
        mycursor.execute(query, query_params)

        result = mycursor.fetchall()
        item_inventory_list = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index,
                          column in enumerate(columns)}

        if not result:
            logger.warning(f"{USER_ID} --> {MODULE_NAME}: No results found for the given parameters.")

        for row in result:
            item_inventory_dict = {}

            for column in columns:
                item_inventory_dict[column] = row[column_indices[column]]

            item_inventory_list.append(item_inventory_dict)

        mycursor.close()
        mydb.close()

        if not item_inventory_list:
            logger.info(f"{USER_ID} --> {MODULE_NAME}: No item inventory data found for the given parameters.")
        else:
            logger.debug(
                f"{USER_ID} --> {MODULE_NAME}: Successfully retrieved item inventory data")

        return jsonify({'item_inventory_list': item_inventory_list})

    except Exception as e:
        logger.error(
            f"{USER_ID} --> {MODULE_NAME}: Error retrieving item inventory data - {str(e)}")
        return jsonify({'error': 'Internal Server Error'}), 500
