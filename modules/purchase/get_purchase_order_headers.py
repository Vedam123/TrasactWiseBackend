from flask import abort, Blueprint, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

get_purchase_order_headers_api = Blueprint('get_purchase_order_headers_api', __name__)

@get_purchase_order_headers_api.route('/get_purchase_order_headers', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_purchase_order_headers():
    MODULE_NAME = __name__

    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        logger.debug(
            f"{USER_ID} --> {MODULE_NAME}: Entered the 'get purchase order headers' function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)
        mycursor = mydb.cursor()

        # Extract all parameters from the request args
        query_params = {f"param_{param}": request.args.get(param) for param in request.args}

        if not query_params:
            query_params = {}

        # Extract po_num from JSON input
        try:
            json_data = request.get_json()
            if json_data and 'po_num' in json_data:
                query_params['param_po_num'] = json_data['po_num']
            if json_data and 'status' in json_data:
                query_params['param_status'] = json_data['status']
        except Exception as json_error:
            logger.error(
                f"{USER_ID} --> {MODULE_NAME}: Error extracting po_num from JSON input - {str(json_error)}")

        logger.debug(
            f"{USER_ID} --> {MODULE_NAME}: Extracted query parameters - {query_params}")

        # Create a dynamic WHERE clause
        where_clauses = []
        for param, value in query_params.items():
            if value is not None:
                if param.startswith('param_header_id'):
                    where_clauses.append(f"(poh.header_id = %({param})s)")
                elif param.startswith('param_company_id'):
                    where_clauses.append(f"(poh.company_id = %({param})s)")
                elif param.startswith('param_department_id'):
                    where_clauses.append(f"(poh.department_id = %({param})s)")
                elif param.startswith('param_rfq_header_id'):
                    where_clauses.append(f"(poh.rfq_header_id = %({param})s)")
                elif param.startswith('param_supplier_id'):
                    where_clauses.append(f"(poh.supplier_id = %({param})s)")
                elif param.startswith('param_tax_id'):
                    where_clauses.append(f"(poh.tax_id = %({param})s)")
                elif param.startswith('param_currency_id'):
                    where_clauses.append(f"(poh.currency_id = %({param})s)")
                elif param.startswith('param_po_num'):
                    where_clauses.append(f"(poh.po_num = %({param})s)")
                elif param.startswith('param_status'):
                    where_clauses.append(f"(poh.status = %({param})s)")
                else:
                    logger.error(
                        f"{USER_ID} --> {MODULE_NAME}: Invalid parameter - {param}")
                    return 'error: Invalid Parameters', 400

        logger.debug(
            f"{USER_ID} --> {MODULE_NAME}: Constructed WHERE clause - {where_clauses}")

        # Construct the final query
        where_clause = ' AND '.join(where_clauses) if where_clauses else '1'
        query = f"""
            SELECT poh.*, 
                c.name AS company_name, 
                c.description AS company_description, 
                d.department_name, 
                d.manager_id, 
                cu.currencycode, 
                cu.currencysymbol, 
                t.tax_code, 
                t.tax_type, 
                t.tax_rate,
                bp.partnername,
                bp.contactperson,
                bp.email,
                bp.phone,
                bp.address,
                bp.city,
                bp.state,
                bp.postalcode,
                bp.country
            FROM pur.purchase_order_header poh
            LEFT JOIN com.company c ON poh.company_id = c.id
            LEFT JOIN com.department d ON poh.department_id = d.id
            LEFT JOIN com.currency cu ON poh.currency_id = cu.currency_id
            LEFT JOIN com.tax t ON poh.tax_id = t.tax_id
            LEFT JOIN com.businesspartner bp ON poh.supplier_id = bp.partnerid
            WHERE {where_clause}
        """

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Constructed query - {query}")
        mycursor.execute(query, query_params)

        result = mycursor.fetchall()
        purchase_order_headers_list = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        if not result:
            logger.warning(
                f"{USER_ID} --> {MODULE_NAME}: No results found for the given parameters.")
            return 'error: No results found', 404

        for row in result:
            purchase_order_headers_dict = {}

            for column in columns:
                purchase_order_headers_dict[column] = row[column_indices[column]]

            purchase_order_headers_list.append(purchase_order_headers_dict)

        mycursor.close()
        mydb.close()

        if not purchase_order_headers_list:
            logger.info(
                f"{USER_ID} --> {MODULE_NAME}: No purchase order header data found for the given parameters.")
            return 'error: No data found', 404
        else:
            logger.debug(
                f"{USER_ID} --> {MODULE_NAME}: Successfully retrieved purchase order header data")

        return purchase_order_headers_list, 200

    except Exception as e:
        logger.error(
            f"{USER_ID} --> {MODULE_NAME}: Error retrieving purchase order header data - {str(e)}")
        return 'error: Internal Server Error', 500
