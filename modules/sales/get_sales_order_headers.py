from flask import abort, Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

get_sales_order_headers_api = Blueprint('get_sales_order_headers_api', __name__)

def column_exists(cursor, table_name, column_name):
    cursor.execute(f"""
        SELECT COUNT(*)
        FROM information_schema.columns
        WHERE table_name = %s AND column_name = %s
    """, (table_name, column_name))
    return cursor.fetchone()[0] > 0

@get_sales_order_headers_api.route('/get_sales_order_headers', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_sales_order_headers():
    MODULE_NAME = __name__
    USER_ID = ""

    try:
        authorization_header = request.headers.get('Authorization')
        if authorization_header:
            token_results = get_user_from_token(authorization_header)
            if token_results:
                USER_ID = token_results["username"]

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'get sales order headers' function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)
        mycursor = mydb.cursor()



        query_params = {f"param_{param}": request.args.get(param) for param in request.args}

        try:
            json_data = request.get_json()
            if json_data:
                for key, value in json_data.items():
                    query_params[f"param_{key}"] = value
        except Exception as json_error:
            logger.error(f"{USER_ID} --> {MODULE_NAME}: Error extracting JSON input - {str(json_error)}")

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Extracted query parameters - {query_params}")

        where_clauses = []
        for param, value in query_params.items():
            if value is not None:
                if param.startswith('param_header_id'):
                    where_clauses.append(f"(soh.header_id = %({param})s)")
                elif param.startswith('param_company_id'):
                    where_clauses.append(f"(soh.company_id = %({param})s)")
                elif param.startswith('param_department_id'):
                    where_clauses.append(f"(soh.department_id = %({param})s)")
                elif param.startswith('param_customer_id'):
                    where_clauses.append(f"(soh.customer_id = %({param})s)")
                elif param.startswith('param_so_date'):
                    where_clauses.append(f"(soh.so_date = %({param})s)")
                elif param.startswith('param_status'):
                    where_clauses.append(f"(soh.status = %({param})s)")
                elif param.startswith('param_so_num'):
                    where_clauses.append(f"(soh.so_num = %({param})s)")
                else:
                    logger.error(f"{USER_ID} --> {MODULE_NAME}: Invalid parameter - {param}")
                    return jsonify({'error': 'Invalid Parameters'}), 400

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Constructed WHERE clause - {where_clauses}")

        where_clause = ' AND '.join(where_clauses) if where_clauses else '1'

        # Check if promotion_id and discount_id columns exist
        promotion_id_exists = column_exists(mycursor, 'sales_order_headers', 'promotion_id')
        discount_id_exists = column_exists(mycursor, 'sales_order_headers', 'discount_id')

        join_promotion = """
            LEFT JOIN sal.promotions p ON soh.promotion_id = p.promotion_id
        """ if promotion_id_exists else ""

        join_discount = """
            LEFT JOIN sal.discounts d ON soh.discount_id = d.discount_id
        """ if discount_id_exists else ""

        select_promotion = ", p.promotion_name" if promotion_id_exists else ""
        select_discount = ", d.discount_name" if discount_id_exists else ""

        query = f"""
            SELECT 
                soh.*, 
                c.name AS company_name, 
                c.description AS company_description, 
                dept.department_name, 
                dept.manager_id, 
                cu.currencycode, 
                cu.currencysymbol, 
                bp.partnername,
                bp.contactperson,
                bp.email,
                bp.phone,
                bp.address,
                bp.city,
                bp.state,
                bp.postalcode,
                bp.country,
                t.tax_code,
                t.tax_rate,
                t.tax_type
            FROM 
                sal.sales_order_headers soh
                LEFT JOIN com.company c ON soh.company_id = c.id
                LEFT JOIN com.department dept ON soh.department_id = dept.id
                LEFT JOIN com.currency cu ON soh.currency_id = cu.currency_id
                LEFT JOIN com.businesspartner bp ON soh.customer_id = bp.partnerid
                LEFT JOIN com.tax t ON soh.tax_id = t.tax_id
            WHERE 
                {where_clause}
        """



        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Constructed query - {query}")
        mycursor.execute(query, query_params)

        result = mycursor.fetchall()
        sales_order_headers_list = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        if not result:
            logger.warning(f"{USER_ID} --> {MODULE_NAME}: No results found for the given parameters.")
            return jsonify({'error': 'No results found'}), 404

        for row in result:
            sales_order_headers_dict = {column: row[column_indices[column]] for column in columns}
            sales_order_headers_list.append(sales_order_headers_dict)

        mycursor.close()
        mydb.close()

        if not sales_order_headers_list:
            logger.info(f"{USER_ID} --> {MODULE_NAME}: No sales order header data found for the given parameters.")
            return jsonify({'error': 'No data found'}), 404

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Successfully retrieved sales order header data")
        return jsonify(sales_order_headers_list), 200

    except Exception as e:
        error_message = str(e)
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error retrieving sales order header data - {error_message}")
        return jsonify({'error': 'Internal Server Error', 'message': error_message}), 500
