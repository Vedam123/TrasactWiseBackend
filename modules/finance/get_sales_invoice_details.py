from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import READ_ACCESS_TYPE
from modules.utilities.logger import logger

get_sales_invoice_details_api = Blueprint('get_sales_invoice_details_api', __name__)

@get_sales_invoice_details_api.route('/get_sales_invoice_details', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_sales_invoice_details():
    

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

        logger.debug(f"{appuser} --> {__name__}: Entered the 'get_sales_invoice_details' function")

        invalid_params_present = any(param for param in request.args.keys() if param not in ['header_id', 'invoice_number', 'partnerid', 'invoicedate', 'status', 'tax_id', 'company_id', 'currency_id', 'department_id', 'transaction_source'])
        if invalid_params_present:
            return jsonify({'error': 'Invalid query parameter(s) detected'}), 400

        header_id_str = request.args.get('header_id')
        header_id = int(header_id_str.strip('"')) if header_id_str is not None else None
        invoice_number_str = request.args.get('invoice_number')
        invoice_number = int(invoice_number_str.strip('"')) if invoice_number_str is not None else None
        partnerid_str = request.args.get('partnerid')
        partnerid = int(partnerid_str.strip('"')) if partnerid_str is not None else None
        invoicedate = request.args.get('invoicedate')
        status_list = request.args.getlist('status')
        tax_id_str = request.args.get('tax_id')
        tax_id = int(tax_id_str.strip('"')) if tax_id_str is not None else None
        company_id_str = request.args.get('company_id')
        company_id = int(company_id_str.strip('"')) if company_id_str is not None else None
        currency_id_str = request.args.get('currency_id')
        currency_id = int(currency_id_str.strip('"')) if currency_id_str is not None else None
        department_id_str = request.args.get('department_id')
        department_id = int(department_id_str.strip('"')) if department_id_str is not None else None
        transaction_source_str = request.args.get('transaction_source')
        
        mycursor = mydb.cursor()

        query = """
            SELECT 
                s.header_id, s.invoice_number, s.partnerid, s.invoicedate, s.totalamount, s.status, 
                s.payment_terms, s.payment_duedate, s.tax_id, s.currency_id, s.department_id, s.company_id, 
                s.transaction_source,
                s.created_at, s.updated_at, s.created_by, s.updated_by,
                b.partnername, b.email, b.phone, b.address, b.city, b.state, b.postalcode, b.country,
                d.department_name, d.manager_id,
                c.name AS company_name, c.id AS company_id,
                cur.currencycode, cur.currencyname, cur.currencysymbol
            FROM fin.salesinvoice s
            LEFT JOIN com.businesspartner b ON s.partnerid = b.partnerid
            LEFT JOIN com.department d ON s.department_id = d.id
            LEFT JOIN com.company c ON s.company_id = c.id
            LEFT JOIN com.currency cur ON s.currency_id = cur.currency_id
            WHERE 1=1
        """

        if header_id:
            query += f" AND s.header_id = {header_id}"
        if invoice_number:
            query += f" AND s.invoice_number = {invoice_number}"
        if partnerid:
            query += f" AND s.partnerid = {partnerid}"
        if invoicedate:
            query += f" AND s.invoicedate = '{invoicedate}'"
        if status_list:
            status_conditions = " OR ".join([f"s.status = '{status}'" for status in status_list])
            query += f" AND ({status_conditions})"
        if tax_id:
            query += f" AND s.tax_id = {tax_id}"
        if company_id:
            query += f" AND s.company_id = {company_id}"
        if currency_id:
            query += f" AND s.currency_id = {currency_id}"
        if department_id:
            query += f" AND s.department_id = {department_id}"
        if transaction_source_str:
            query += f" AND s.transaction_source = '{transaction_source_str}'" 

        mycursor.execute(query)

        result = mycursor.fetchall()
        sales_invoice_headers= []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        for row in result:
            sales_invoice_details_dict = {}

            for column in columns:
                sales_invoice_details_dict[column] = row[column_indices[column]]

            sales_invoice_headers.append(sales_invoice_details_dict)

        mycursor.close()
        mydb.close()

        logger.debug(f"{appuser} --> {__name__}: Successfully retrieved sales invoice details data")

        return jsonify({'sales_invoice_headers': sales_invoice_headers})

    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Error retrieving sales invoice details data - {str(e)}")
        import traceback
        traceback.print_exc()  # Add this line to print the full stack trace
        return jsonify({'error': 'Internal Server Error'}), 500
