from flask import abort, Blueprint, jsonify, request
from modules.security.routines.get_user_and_db_details import get_user_and_db_details	
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
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

        logger.debug(f"{appuser} --> {__name__}: Entered the 'get sales order headers' function")

        mycursor = mydb.cursor()

        query_params = {f"param_{param}": request.args.get(param) for param in request.args}

        try:
            json_data = request.get_json()
            if json_data:
                for key, value in json_data.items():
                    query_params[f"param_{key}"] = value
        except Exception as json_error:
            logger.error(f"{appuser} --> {__name__}: Error extracting JSON input - {str(json_error)}")

        logger.debug(f"{appuser} --> {__name__}: Extracted query parameters - {query_params}")

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
                    logger.error(f"{appuser} --> {__name__}: Invalid parameter - {param}")
                    return jsonify({'error': 'Invalid Parameters'}), 400

        logger.debug(f"{appuser} --> {__name__}: Constructed WHERE clause - {where_clauses}")

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



        logger.debug(f"{appuser} --> {__name__}: Constructed query - {query}")
        mycursor.execute(query, query_params)

        result = mycursor.fetchall()
        sales_order_headers_list = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        if not result:
            logger.warning(f"{appuser} --> {__name__}: No results found for the given parameters.")
            return jsonify({'error': 'No results found'}), 404

        for row in result:
            sales_order_headers_dict = {column: row[column_indices[column]] for column in columns}
            sales_order_headers_list.append(sales_order_headers_dict)

        mycursor.close()
        mydb.close()

        if not sales_order_headers_list:
            logger.info(f"{appuser} --> {__name__}: No sales order header data found for the given parameters.")
            return jsonify({'error': 'No data found'}), 404

        logger.debug(f"{appuser} --> {__name__}: Successfully retrieved sales order header data")
        return jsonify(sales_order_headers_list), 200

    except Exception as e:
        error_message = str(e)
        logger.error(f"{appuser} --> {__name__}: Error retrieving sales order header data - {error_message}")
        return jsonify({'error': 'Internal Server Error', 'message': error_message}), 500
