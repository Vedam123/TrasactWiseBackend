from flask import Blueprint, request,jsonify
from modules.security.routines.get_user_and_db_details import get_user_and_db_details	
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger

# Validation functions
def is_company_id_valid(mydb, company_id):
    mycursor = mydb.cursor()
    query = "SELECT id FROM com.company WHERE id = %s"
    mycursor.execute(query, (company_id,))
    result = mycursor.fetchone()
    mycursor.close()
    return result is not None

def is_department_id_valid(mydb, department_id):
    mycursor = mydb.cursor()
    query = "SELECT id FROM com.department WHERE id = %s"
    mycursor.execute(query, (department_id,))
    result = mycursor.fetchone()
    mycursor.close()
    return result is not None

def is_customer_id_valid(mydb, customer_id):
    mycursor = mydb.cursor()
    query = "SELECT partnerid FROM com.businesspartner WHERE partnerid = %s"
    mycursor.execute(query, (customer_id,))
    result = mycursor.fetchone()
    mycursor.close()
    return result is not None

def is_currency_id_valid(mydb, currency_id):
    mycursor = mydb.cursor()
    query = "SELECT currency_id FROM com.currency WHERE currency_id = %s"
    mycursor.execute(query, (currency_id,))
    result = mycursor.fetchone()
    mycursor.close()
    return result is not None

def is_tax_id_valid(mydb, tax_id):
    mycursor = mydb.cursor()
    query = "SELECT tax_id FROM com.tax WHERE tax_id = %s"
    mycursor.execute(query, (tax_id,))
    result = mycursor.fetchone()
    mycursor.close()
    return result is not None

create_sales_order_header_api = Blueprint('create_sales_order_header_api', __name__)

@create_sales_order_header_api.route('/create_sales_order_header', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_sales_order_header():
    

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
            f"{appuser} --> {__name__}: Entered the 'create sales order header' function")

        mycursor = mydb.cursor()

        # Extract data from JSON input
        try:
            json_data = request.get_json()
            if not json_data:
                return 'error: No JSON data provided', 400

            # Extracting fields from JSON input
            so_num = int(json_data.get('so_num'))
            opportunity_id = int(json_data.get('opportunity_id')) if json_data.get('opportunity_id') is not None else None
            company_id = int(json_data.get('company_id'))
            department_id = int(json_data.get('department_id'))
            customer_id = int(json_data.get('customer_id'))
            so_date = json_data.get('so_date')
            type_ = json_data.get('type')
            status = json_data.get('status')
            payment_terms = json_data.get('payment_terms')
            shipping_method = json_data.get('shipping_method')
            billing_address = json_data.get('billing_address')
            shipping_address = json_data.get('shipping_address')
            rep_id = int(json_data.get('rep_id')) if json_data.get('rep_id') is not None else None
            total_amount = float(json_data.get('total_amount'))
            currency_id = int(json_data.get('currency_id'))
            comments = json_data.get('comments')
            tax_id = int(json_data.get('tax_id')) if json_data.get('tax_id') is not None else None

            # Perform validations
            if not is_company_id_valid(mydb, company_id):
                return 'error: Invalid company ID', 400
            if not is_department_id_valid(mydb, department_id):
                return 'error: Invalid department ID', 400
            if not is_customer_id_valid(mydb, customer_id):
                return 'error: Invalid customer ID', 400
            if not is_currency_id_valid(mydb, currency_id):
                return 'error: Invalid currency ID', 400
            if tax_id is not None and not is_tax_id_valid(mydb, tax_id):
                return 'error: Invalid tax ID', 400

       # Perform the insertion
            query = """
                INSERT INTO sal.sales_order_headers (
                    so_num, opportunity_id, company_id, department_id, customer_id, so_date,
                    type, status, payment_terms, shipping_method, billing_address, shipping_address,
                    rep_id, total_amount, currency_id, comments, tax_id,
                    created_by, updated_by
                ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);
            """
            values = (
                so_num, opportunity_id, company_id, department_id, customer_id, so_date,
                type_, status, payment_terms, shipping_method, billing_address, shipping_address,
                rep_id, total_amount, currency_id, comments, tax_id,
                appuserid, appuserid
            )

            logger.debug(f"Query: {query}")
            logger.debug(f"Values: {values}")

            mycursor.execute(query, values)

            # Get the generated header_id
            header_id = mycursor.lastrowid

            # Commit the transaction
            mydb.commit()

            logger.debug(
                f"{appuser} --> {__name__}: Successfully created sales order header")

            response = {
                'success': True,
                'message': 'Sales order created successfully',
                'so_num': so_num,
                'header_id': header_id,
                'currency_id': currency_id
            }

            return response, 201

        except Exception as json_error:
            logger.error(
                f"{appuser} --> {__name__}: Error processing JSON input - {str(json_error)}")
            return 'error: Invalid JSON input', 400

    except Exception as e:
        logger.error(
            f"{appuser} --> {__name__}: Error creating sales order header - {str(e)}")
        mydb.rollback()
        return 'error: Internal Server Error', 500

    finally:
        mycursor.close()
        mydb.close()
