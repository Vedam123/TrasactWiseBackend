from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import READ_ACCESS_TYPE
from modules.utilities.logger import logger

purchase_invoice_lines_api = Blueprint('purchase_invoice_lines_api', __name__)

@purchase_invoice_lines_api.route('/get_purchase_invoice_lines', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_purchase_invoice_lines():
    

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

        logger.debug(f"{appuser} --> {__name__}: Entered the 'get_purchase_invoice_lines' function")

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
                pil.line_id, pil.line_number, pil.header_id, pil.item_id, pil.quantity, pil.unit_price, 
                pil.line_total, pil.uom_id, pil.created_at, pil.updated_at, pil.created_by, pil.updated_by,
                pi.invoice_number, pi.tax_id, pi.currency_id, 
                cur.currencysymbol, cur.currencycode, u.uom_name, u.abbreviation,
                i.item_name, i.item_code
            FROM fin.purchaseinvoicelines pil
            LEFT JOIN fin.purchaseinvoice pi ON pil.header_id = pi.header_id
            LEFT JOIN com.uom u ON pil.uom_id = u.uom_id
            LEFT JOIN com.items i ON pil.item_id = i.item_id
            LEFT JOIN com.currency cur ON pi.currency_id = cur.currency_id
            WHERE 1=1
        """

        # Adding conditions based on input parameters
        if line_id:
            query += f" AND pil.line_id = {line_id}"
        if line_number:
            query += f" AND pil.line_number = '{line_number}'"
        if header_id:
            query += f" AND pil.header_id = {header_id}"
        if item_id:
            query += f" AND pil.item_id = {item_id}"
        if quantity:
            query += f" AND pil.quantity = {quantity}"
        if uom_id:
            query += f" AND pil.uom_id = {uom_id}"

        mycursor.execute(query)

        result = mycursor.fetchall()
        purchase_invoice_lines = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        for row in result:
            purchase_invoice_line_dict = {}

            for column in columns:
                purchase_invoice_line_dict[column] = row[column_indices[column]]

            purchase_invoice_lines.append(purchase_invoice_line_dict)

        mycursor.close()
        mydb.close()

        logger.debug(f"{appuser} --> {__name__}: Successfully retrieved purchase invoice lines data")

        return jsonify({'purchase_invoice_lines': purchase_invoice_lines})

    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Error retrieving purchase invoice lines data - {str(e)}")
        import traceback
        traceback.print_exc()  # Add this line to print the full stack trace
        return jsonify({'error': 'Internal Server Error'}), 500
