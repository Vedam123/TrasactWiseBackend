from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import READ_ACCESS_TYPE
from modules.utilities.logger import logger

sales_invoice_lines_api = Blueprint('sales_invoice_lines_api', __name__)

@sales_invoice_lines_api.route('/get_sales_invoice_lines', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_sales_invoice_lines():
    

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

        logger.debug(f"{appuser} --> {__name__}: Entered the 'get_sales_invoice_lines' function")

        # Fetching input parameters from the request
        line_id_str = request.args.get('line_id')
        line_id = int(line_id_str.strip('"')) if line_id_str is not None else None

        line_number_str = request.args.get('line_number')
        line_number = line_number_str.strip('"') if line_number_str is not None else None

        header_id_str = request.args.get('header_id')
        header_id = int(header_id_str.strip('"')) if header_id_str is not None else None

        item_id_str = request.args.get('item_id')
        item_id = int(item_id_str.strip('"')) if item_id_str is not None else None

        quantity_str = request.args.get('quantity')
        quantity = int(quantity_str.strip('"')) if quantity_str is not None else None

        uom_id_str = request.args.get('uom_id')
        uom_id = int(uom_id_str.strip('"')) if uom_id_str is not None else None

        mycursor = mydb.cursor()

        # Constructing the SQL query
        query = """
            SELECT 
                sil.line_id, sil.line_number, sil.header_id, sil.item_id, sil.quantity, sil.unit_price, 
                sil.line_total, sil.uom_id, sil.created_at, sil.updated_at, sil.created_by, sil.updated_by,
                si.invoice_number, si.tax_id, si.currency_id, 
                cur.currencysymbol, cur.currencycode, u.uom_name, u.abbreviation,
                i.item_name, i.item_code
            FROM fin.salesinvoicelines sil
            LEFT JOIN fin.salesinvoice si ON sil.header_id = si.header_id
            LEFT JOIN com.uom u ON sil.uom_id = u.uom_id
            LEFT JOIN com.items i ON sil.item_id = i.item_id
            LEFT JOIN com.currency cur ON si.currency_id = cur.currency_id
            WHERE 1=1
        """

        # Adding conditions based on input parameters
        if line_id:
            query += f" AND sil.line_id = {line_id}"
        if line_number:
            query += f" AND sil.line_number = '{line_number}'"
        if header_id:
            query += f" AND sil.header_id = {header_id}"
        if item_id:
            query += f" AND sil.item_id = {item_id}"
        if quantity:
            query += f" AND sil.quantity = {quantity}"
        if uom_id:
            query += f" AND sil.uom_id = {uom_id}"

        mycursor.execute(query)

        result = mycursor.fetchall()
        sales_invoice_lines = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        for row in result:
            sales_invoice_line_dict = {}

            for column in columns:
                sales_invoice_line_dict[column] = row[column_indices[column]]

            sales_invoice_lines.append(sales_invoice_line_dict)

        mycursor.close()
        mydb.close()

        logger.debug(f"{appuser} --> {__name__}: Successfully retrieved sales invoice lines data")

        return jsonify({'sales_invoice_lines': sales_invoice_lines})

    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Error retrieving sales invoice lines data - {str(e)}")
        import traceback
        traceback.print_exc()  # Add this line to print the full stack trace
        return jsonify({'error': 'Internal Server Error'}), 500
