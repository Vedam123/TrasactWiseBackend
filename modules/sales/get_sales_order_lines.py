from flask import abort, Blueprint, request, jsonify
from modules.security.routines.get_user_and_db_details import get_user_and_db_details	
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.utilities.logger import logger

get_sales_order_lines_api = Blueprint('get_sales_order_lines_api', __name__)

@get_sales_order_lines_api.route('/get_sales_order_lines', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_sales_order_lines():
    
    appuser = ""

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

        logger.debug(
            f"{appuser} --> {__name__}: Entered the 'get sales order line' function")

        mycursor = mydb.cursor()

        logger.debug(
            f"{appuser} --> {__name__}: Database connection established")

        # Extract header_id from query parameters
        header_id = request.args.get('header_id')

        if not header_id:
            logger.error(
                f"{appuser} --> {__name__}: header_id parameter is required")
            return 'error: header_id parameter is required', 400

        logger.debug(
            f"{appuser} --> {__name__}: header_id extracted from query parameters - {header_id}")

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
            f"{appuser} --> {__name__}: Constructed query - {query}")

        # Execute the query
        mycursor.execute(query, {'param_header_id': header_id})

        logger.debug(
            f"{appuser} --> {__name__}: Query executed successfully")

        result = mycursor.fetchall()
        sales_order_line_list = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        if not result:
            logger.warning(
                f"{appuser} --> {__name__}: No results found for the given header_id - {header_id}")
            return 'error: No results found', 404

        logger.debug(
            f"{appuser} --> {__name__}: Results fetched successfully")

        for row in result:
            sales_order_line_dict = {}

            for column in columns:
                sales_order_line_dict[column] = row[column_indices[column]]

            sales_order_line_list.append(sales_order_line_dict)

        logger.debug(
            f"{appuser} --> {__name__}: Formatted result data")

        mycursor.close()
        mydb.close()

        logger.debug(
            f"{appuser} --> {__name__}: Database connection closed")

        if not sales_order_line_list:
            logger.info(
                f"{appuser} --> {__name__}: No sales order line data found for the given header_id - {header_id}")
            return 'error: No data found', 404

        logger.debug(
            f"{appuser} --> {__name__}: Successfully retrieved sales order line data")

        return jsonify(sales_order_line_list), 200

    except Exception as e:
        logger.error(
            f"{appuser} --> {__name__}: Error retrieving sales order line data - {str(e)}")
        return 'error: Internal Server Error', 500
