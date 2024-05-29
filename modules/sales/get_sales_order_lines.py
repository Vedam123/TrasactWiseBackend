from flask import abort, Blueprint, request, jsonify
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

get_sales_order_lines_api = Blueprint('get_sales_order_lines_api', __name__)

@get_sales_order_lines_api.route('/get_sales_order_lines', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_sales_order_lines():
    MODULE_NAME = __name__

    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        logger.debug(
            f"{USER_ID} --> {MODULE_NAME}: Entered the 'get sales order line' function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)
        mycursor = mydb.cursor()

        # Check if the request content type is 'application/json'
        if request.content_type != 'application/json':
            return 'error: Unsupported Media Type. Please send a JSON request with Content-Type: application/json', 415

        # Extract JSON parameters from the request
        json_data = request.get_json()
        if json_data:
            # Extract parameters from JSON data
            query_params = {f"param_{param}": json_data.get(param) for param in json_data}
        else:
            # If no JSON parameters are provided, initialize an empty dictionary
            query_params = {}

        logger.debug(
            f"{USER_ID} --> {MODULE_NAME}: Extracted query parameters - {query_params}")

        # Create a dynamic WHERE clause
        where_clauses = []
        for param, value in query_params.items():
            if value is not None:
                if param.startswith('param_header_id'):
                    where_clauses.append(f"(sol.header_id = %({param})s)")
                elif param.startswith('param_line_id'):
                    where_clauses.append(f"(sol.line_id = %({param})s)")
                elif param.startswith('param_item_id'):
                    where_clauses.append(f"(sol.item_id = %({param})s)")
                elif param.startswith('param_so_lnum'):
                    where_clauses.append(f"(sol.so_lnum = %({param})s)")
                elif param.startswith('param_status'):
                    where_clauses.append(f"(sol.status = %({param})s)")
                else:
                    logger.error(
                        f"{USER_ID} --> {MODULE_NAME}: Invalid parameter - {param}")
                    return 'error: Invalid Parameters', 400

        logger.debug(
            f"{USER_ID} --> {MODULE_NAME}: Constructed WHERE clause - {where_clauses}")

        # Construct the final WHERE clause
        where_clause = ' AND '.join(where_clauses) if where_clauses else '1=1'

        # Construct the final query
        query = f"""
            SELECT sol.*, 
                i.item_code, 
                i.item_name,
                uom.uom_name,
                uom.abbreviation
            FROM sal.sales_order_lines sol
            LEFT JOIN com.items i ON sol.item_id = i.item_id
            LEFT JOIN com.uom uom ON sol.uom_id = uom.uom_id
            WHERE {where_clause}
        """

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Constructed query - {query}")
        mycursor.execute(query, query_params)

        result = mycursor.fetchall()
        sales_order_line_list = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        if not result:
            logger.warning(
                f"{USER_ID} --> {MODULE_NAME}: No results found for the given parameters.")
            return 'error: No results found', 404

        for row in result:
            sales_order_line_dict = {}

            for column in columns:
                sales_order_line_dict[column] = row[column_indices[column]]

            sales_order_line_list.append(sales_order_line_dict)

        mycursor.close()
        mydb.close()

        if not sales_order_line_list:
            logger.info(
                f"{USER_ID} --> {MODULE_NAME}: No sales order line data found for the given parameters.")
            return 'error: No data found', 404
        else:
            logger.debug(
                f"{USER_ID} --> {MODULE_NAME}: Successfully retrieved sales order line data")

        return jsonify(sales_order_line_list), 200

    except Exception as e:
        logger.error(
            f"{USER_ID} --> {MODULE_NAME}: Error retrieving sales order line data - {str(e)}")
        return 'error: Internal Server Error', 500
