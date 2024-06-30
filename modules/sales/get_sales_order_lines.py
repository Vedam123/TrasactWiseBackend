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
    USER_ID = ""

    try:
        authorization_header = request.headers.get('Authorization')

        if authorization_header:
            token_results = get_user_from_token(authorization_header)
            if token_results:
                USER_ID = token_results["username"]

        logger.debug(
            f"{USER_ID} --> {MODULE_NAME}: Entered the 'get sales order line' function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)
        mycursor = mydb.cursor()

        logger.debug(
            f"{USER_ID} --> {MODULE_NAME}: Database connection established")

        # Extract header_id from query parameters
        header_id = request.args.get('header_id')

        if not header_id:
            logger.error(
                f"{USER_ID} --> {MODULE_NAME}: header_id parameter is required")
            return 'error: header_id parameter is required', 400

        logger.debug(
            f"{USER_ID} --> {MODULE_NAME}: header_id extracted from query parameters - {header_id}")

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
            WHERE sol.header_id = %(param_header_id)s
        """

        logger.debug(
            f"{USER_ID} --> {MODULE_NAME}: Constructed query - {query}")

        # Execute the query
        mycursor.execute(query, {'param_header_id': header_id})

        logger.debug(
            f"{USER_ID} --> {MODULE_NAME}: Query executed successfully")

        result = mycursor.fetchall()
        sales_order_line_list = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        if not result:
            logger.warning(
                f"{USER_ID} --> {MODULE_NAME}: No results found for the given header_id - {header_id}")
            return 'error: No results found', 404

        logger.debug(
            f"{USER_ID} --> {MODULE_NAME}: Results fetched successfully")

        for row in result:
            sales_order_line_dict = {}

            for column in columns:
                sales_order_line_dict[column] = row[column_indices[column]]

            sales_order_line_list.append(sales_order_line_dict)

        logger.debug(
            f"{USER_ID} --> {MODULE_NAME}: Formatted result data")

        mycursor.close()
        mydb.close()

        logger.debug(
            f"{USER_ID} --> {MODULE_NAME}: Database connection closed")

        if not sales_order_line_list:
            logger.info(
                f"{USER_ID} --> {MODULE_NAME}: No sales order line data found for the given header_id - {header_id}")
            return 'error: No data found', 404

        logger.debug(
            f"{USER_ID} --> {MODULE_NAME}: Successfully retrieved sales order line data")

        return jsonify(sales_order_line_list), 200

    except Exception as e:
        logger.error(
            f"{USER_ID} --> {MODULE_NAME}: Error retrieving sales order line data - {str(e)}")
        return 'error: Internal Server Error', 500
