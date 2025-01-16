from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger

create_sales_invoice_api = Blueprint('create_sales_invoice_api', __name__)

@create_sales_invoice_api.route('/create_sales_invoice', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_sales_invoice():
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
        # Log entry point
        logger.debug(f"{appuser} --> {__name__}: Entered the 'create_sales_invoice' function")

        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        print("Current User id to be inserted ",appuserid)

        # Log the received data
        logger.debug(f"{appuser} --> {__name__}: Received data: {data}")

        # Assuming your salesinvoice table has columns like partnerid, invoicedate, etc.
        insert_query = """
            INSERT INTO fin.salesinvoice (header_id, invoice_number, partnerid, invoicedate, totalamount, status, payment_terms, payment_duedate, tax_id, currency_id, department_id, company_id, transaction_source, created_by, updated_by)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """

        # Assuming the data dictionary contains the necessary keys
        insert_values = (
            data.get('header_id'),
            data.get('invoice_number'),
            data.get('partnerid'),
            data.get('invoicedate'),
            data.get('totalamount'),
            data.get('status'),
            data.get('payment_terms'),
            data.get('payment_duedate'),
            data.get('tax_id'),
            data.get('currency_id'),
            data.get('department_id'),
            data.get('company_id'),
            data.get('transaction_source'),  # Add transaction_source
            appuserid,  # created_by
            appuserid   # updated_by
        )

        mycursor = mydb.cursor()

        try:
            mycursor.execute(insert_query, insert_values)
            mydb.commit()
            header_id = mycursor.lastrowid  # Get the ID of the inserted row
            invoice_number = data.get('invoice_number')  # Get the invoice number from the request data
            totalamount = data.get('totalamount')  # Get the total amount from the request data
            status = data.get('status')  # Get the payment status from the request data

            # Log success and close the cursor and connection
            logger.info(f"{appuser} --> {__name__}: Sales invoice data created successfully")
            mycursor.close()
            mydb.close()
            
            # Construct response with additional data
            response = {
                'success': True,
                'message': 'Sales Invoice created successfully',
                'invoice_number': invoice_number,
                'header_id': header_id,
                'totalamount': totalamount,
                'status': status
            }
            
            return response, 200

        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{appuser} --> {__name__}: Unable to create sales invoice data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500

    except Exception as e:
        # Log any exceptions
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
