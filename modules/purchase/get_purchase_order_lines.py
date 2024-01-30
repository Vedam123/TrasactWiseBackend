from flask import abort, Blueprint, request, jsonify
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

get_purchase_routes_api = Blueprint('get_purchase_routes_api', __name__)

@get_purchase_routes_api.route('/get_purchase_order_lines', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_purchase_order_lines():
    MODULE_NAME = __name__

    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        logger.debug(
            f"{USER_ID} --> {MODULE_NAME}: Entered the 'get purchase order line' function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)
        mycursor = mydb.cursor()

        # Extract all parameters from the request args
        query_params = {f"param_{param}": request.args.get(param) for param in request.args}

        if not query_params:
            query_params = {}

        logger.debug(
            f"{USER_ID} --> {MODULE_NAME}: Extracted query parameters - {query_params}")

        # Include po_lnum in the query parameters
        po_lnum = request.args.get('po_lnum')
        if po_lnum is not None:
            query_params['param_po_lnum'] = po_lnum

        # Include status in the query parameters
        status = request.args.get('status')
        if status is not None:
            query_params['param_status'] = status

        # Create a dynamic WHERE clause
        where_clauses = []
        for param, value in query_params.items():
            if value is not None:
                if param.startswith('param_header_id'):
                    where_clauses.append(f"(pol.header_id = %({param})s)")
                elif param.startswith('param_line_id'):
                    where_clauses.append(f"(pol.line_id = %({param})s)")
                elif param.startswith('param_item_id'):
                    where_clauses.append(f"(pol.item_id = %({param})s)")
                elif param.startswith('param_tax_id'):
                    where_clauses.append(f"(pol.tax_id = %({param})s)")
                elif param.startswith('param_po_lnum'):
                    where_clauses.append(f"(pol.po_lnum = %({param})s)")
                elif param.startswith('param_status'):
                    where_clauses.append(f"(pol.status = %({param})s)")
                else:
                    logger.error(
                        f"{USER_ID} --> {MODULE_NAME}: Invalid parameter - {param}")
                    return 'error: Invalid Parameters', 400

        logger.debug(
            f"{USER_ID} --> {MODULE_NAME}: Constructed WHERE clause - {where_clauses}")

        # Construct the final query
        where_clause = ' AND '.join(where_clauses) if where_clauses else '1'
        query = f"""
            SELECT pol.*, 
                t.tax_code, 
                t.tax_rate, 
                t.tax_type, 
                i.item_code, 
                i.item_name,
                uom.uom_name,
                uom.abbreviation
            FROM pur.purchase_order_line pol
            LEFT JOIN com.tax t ON pol.tax_id = t.tax_id
            LEFT JOIN com.items i ON pol.item_id = i.item_id
            LEFT JOIN com.uom uom ON pol.uom_id = uom.uom_id
            WHERE {where_clause}
        """

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Constructed query - {query}")
        mycursor.execute(query, query_params)

        result = mycursor.fetchall()
        purchase_order_line_list = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        if not result:
            logger.warning(
                f"{USER_ID} --> {MODULE_NAME}: No results found for the given parameters.")
            return 'error: No results found', 404

        for row in result:
            purchase_order_line_dict = {}

            for column in columns:
                purchase_order_line_dict[column] = row[column_indices[column]]

            purchase_order_line_list.append(purchase_order_line_dict)

        mycursor.close()
        mydb.close()

        if not purchase_order_line_list:
            logger.info(
                f"{USER_ID} --> {MODULE_NAME}: No purchase order line data found for the given parameters.")
            return 'error: No data found', 404
        else:
            logger.debug(
                f"{USER_ID} --> {MODULE_NAME}: Successfully retrieved purchase order line data")

        return jsonify(purchase_order_line_list), 200

    except Exception as e:
        logger.error(
            f"{USER_ID} --> {MODULE_NAME}: Error retrieving purchase order line data - {str(e)}")
        return 'error: Internal Server Error', 500
