from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

update_purchase_invoice_api = Blueprint('update_purchase_invoice_api', __name__)

@update_purchase_invoice_api.route('/update_purchase_invoice', methods=['PUT'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def update_purchase_invoice():
    MODULE_NAME = __name__
    try:
        # Count the number of parameters sent
        parameter_count = sum(1 for param in ['header_id', 'invoice_number', 'transaction_source'] if request.args.get(param) is not None)

        # Ensure at least one parameter is sent
        if parameter_count == 0:
            raise ValueError("At least one of 'header_id', 'invoice_number', or 'transaction_source' must be provided.")
        
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'update update purchase Invoice' function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)
        mycursor = mydb.cursor()

        current_userid = None
        authorization_header = request.headers.get('Authorization', '')
        if authorization_header.startswith('Bearer '):
            token = authorization_header.replace('Bearer ', '')
            decoded_token = decode_token(token)
            current_userid = decoded_token.get('Userid')
            print("decoded user id ",current_userid)

        print("Current user id ",authorization_header,current_userid, USER_ID)

        # Log entry point
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'update_purchase_invoice' function")

        ##mydb = get_database_connection(USER_ID, MODULE_NAME)

        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        # Log the received data
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Received data: {data}")

        # Typecast fields to appropriate types
        partnerid = int(data.get('partnerid'))
        invoicedate = data.get('invoicedate')
        totalamount = float(data.get('totalamount'))
        status = data.get('status')
        payment_terms = data.get('payment_terms')
        payment_duedate = data.get('payment_duedate')
        tax_id = int(data.get('tax_id'))
        currency_id = int(data.get('currency_id'))
        department_id = int(data.get('department_id'))
        company_id = int(data.get('company_id'))

        # Construct the update query
        update_query = """
            UPDATE fin.purchaseinvoice
            SET partnerid = %s, invoicedate = %s, totalamount = %s, status = %s,
                payment_terms = %s, payment_duedate = %s, tax_id = %s, currency_id = %s,
                department_id = %s, company_id = %s, updated_by = %s
            WHERE 1=1
        """

        ##mycursor = mydb.cursor()

        try:
            # Building the WHERE clause dynamically based on input parameters
            where_clause = ""

            # List to store values for the update query
            update_values = [
                partnerid, invoicedate, totalamount, status, payment_terms, payment_duedate,
                tax_id, currency_id, department_id, company_id, current_userid  # updated_by
            ]

            # Add header_id condition if provided
            header_id = request.args.get('header_id')
            if header_id is not None:
                where_clause += " AND header_id = %s "
                update_values.append(header_id)

            # Add invoice_number condition if provided
            invoice_number = request.args.get('invoice_number')
            if invoice_number is not None:
                invoice_number = int(invoice_number)  # Type-cast to number
                where_clause += " AND invoice_number = %s "
                update_values.append(invoice_number)

            # Add transaction_source condition if provided
            transaction_source = request.args.get('transaction_source')
            if transaction_source is not None:
                where_clause += " AND transaction_source = %s "
                update_values.append(transaction_source)

            # Remove the leading " OR "
            where_clause = where_clause.lstrip(" OR ")
            update_query += where_clause

            print("update_query", update_query)
            print("Vlues",update_values)

          # Execute the update query
            mycursor.execute(update_query, update_values)
            # Commit the transaction
            mydb.commit()

            # Check if any row was affected by the update
            if mycursor.rowcount > 0:
                # Log success
                logger.info(f"{USER_ID} --> {MODULE_NAME}: Updated purchase invoice")
                # Close the cursor and connection
                mycursor.close()
                mydb.close()
                # Return success message
                return jsonify({'status': True, 'message': 'Purchase Invoice updated successfully'}), 200
            else:
                # Log that no rows were updated
                logger.warning(f"{USER_ID} --> {MODULE_NAME}: No rows were updated by the query")
                # Close the cursor and connection
                mycursor.close()
                mydb.close()
                # Return appropriate message
                return jsonify({'status': False, 'message': 'No rows were updated by the query'}), 404


        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{USER_ID} --> {MODULE_NAME}: Unable to update purchase invoice: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500

    except Exception as e:
        # Log any exceptions
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
