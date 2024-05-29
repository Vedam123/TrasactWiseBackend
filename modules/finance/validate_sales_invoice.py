from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

validate_sales_invoice_api = Blueprint('validate_sales_invoice_api', __name__)

@validate_sales_invoice_api.route('/validate_sales_invoice', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def validate_sales_invoice():
    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header) if authorization_header else None
        USER_ID = token_results["username"] if token_results else ""
        MODULE_NAME = __name__
        message = ""
    
        # Extract input parameters (header_id, invoice_number, or both)
        header_id = request.args.get('header_id')
        invoice_number = request.args.get('invoice_number')

        print("Invoice number and header id first ", invoice_number, header_id)

        # Get the database connection
        mydb = get_database_connection(USER_ID, MODULE_NAME)

        if not header_id and invoice_number:
            header_id = find_header_id_by_invoice_number(mydb, invoice_number)
            if header_id is None:
                # If header_id is None, return an error response
                mydb.close()
                return jsonify({'error': 'No invoice found for the given invoice number'}), 404
        else:
            invoice_number = find_invoice_by_header_id(mydb, header_id)
            if invoice_number is None:
                # If header_id is None, return an error response
                mydb.close()
                return jsonify({'error': 'No invoice found for the given header id'}), 404

        print("Invoice number and header id ", invoice_number, header_id)
        # Log entry point
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'update_sales_invoice_lines' function")

        current_userid = decode_token(authorization_header.replace('Bearer ', '')).get('Userid') if authorization_header.startswith('Bearer ') else None

        # Initialize error list to collect validation errors
        validation_errors = []

        print("Validation Error is initialized")

        # Validation 1: Check if the sum of line_total of a particular header_id of the table fin.salesinvoicelines
        # is not equal to totalamount of the table fin.salesinvoice
        if header_id:
            print("There is header id present", header_id)
            total_line_total_query = """
                SELECT SUM(line_total) AS total_line_total
                FROM fin.salesinvoicelines
                WHERE header_id = %s
            """
            mycursor = mydb.cursor()
            mycursor.execute(total_line_total_query, (header_id,))
            total_line_total_result = mycursor.fetchone()
            total_line_total = total_line_total_result[0] if total_line_total_result else 0
            print("total line total ", total_line_total)
            invoice_total_query = """
                SELECT totalamount
                FROM fin.salesinvoice
                WHERE header_id = %s
            """
            mycursor.execute(invoice_total_query, (header_id,))
            invoice_total_result = mycursor.fetchone()
            invoice_total = invoice_total_result[0] if invoice_total_result else 0
            print("total invoice total ", invoice_total)
            if total_line_total != invoice_total:
                validation_errors.append("Validation 1 failed: Total line total does not match total amount of the invoice")

        # Validation 2: Check if the sum of all lines' debitamount is not equal to the total of creditamount
        # of the table fin.salesinvoiceaccounts of a particular header_id
        if header_id:
            print("Header id present distribution check  ", header_id)
            total_debit_query = """
                SELECT SUM(debitamount) AS total_debit
                FROM fin.salesinvoiceaccounts
                WHERE header_id = %s
            """
            mycursor.execute(total_debit_query, (header_id,))
            total_debit_result = mycursor.fetchone()
            total_debit = total_debit_result[0] if total_debit_result else 0
            print("Total Debit amount  ", total_debit)
            total_credit_query = """
                SELECT SUM(creditamount) AS total_credit
                FROM fin.salesinvoiceaccounts
                WHERE header_id = %s
            """
            mycursor.execute(total_credit_query, (header_id,))
            total_credit_result = mycursor.fetchone()
            total_credit = total_credit_result[0] if total_credit_result else 0

            print("Total credit amount  ", total_credit)

            if total_debit != total_credit:
                validation_errors.append("Validation 2 failed: Total debit amount does not match total credit amount")

        # Validation 3: Check if the total of all lines debitamount of one header_id of the table fin.salesinvoiceaccounts
        # is not equal to totalamount of fin.salesinvoice table
        if header_id:
            total_debit_accounts_query = """
                SELECT SUM(debitamount) AS total_debit_accounts
                FROM fin.salesinvoiceaccounts
                WHERE header_id = %s
            """
            mycursor.execute(total_debit_accounts_query, (header_id,))
            total_debit_accounts_result = mycursor.fetchone()
            total_debit_accounts = total_debit_accounts_result[0] if total_debit_accounts_result else 0

            invoice_total_query = """
                SELECT totalamount
                FROM fin.salesinvoice
                WHERE header_id = %s
            """
            mycursor.execute(invoice_total_query, (header_id,))
            invoice_total_result = mycursor.fetchone()
            invoice_total = invoice_total_result[0] if invoice_total_result else 0

            if total_debit_accounts != invoice_total:
                validation_errors.append("Validation 3 failed: Total debit amount in accounts does not match total amount of the invoice")

        # Validation 4: Check if the total of all lines creditamount of one header_id of the table fin.salesinvoiceaccounts
        # is not equal to totalamount of fin.salesinvoice table
        if header_id:
            total_credit_accounts_query = """
                SELECT SUM(creditamount) AS total_credit_accounts
                FROM fin.salesinvoiceaccounts
                WHERE header_id = %s
            """
            mycursor.execute(total_credit_accounts_query, (header_id,))
            total_credit_accounts_result = mycursor.fetchone()
            total_credit_accounts = total_credit_accounts_result[0] if total_credit_accounts_result else 0

            invoice_total_query = """
                SELECT totalamount
                FROM fin.salesinvoice
                WHERE header_id = %s
            """
            mycursor.execute(invoice_total_query, (header_id,))
            invoice_total_result = mycursor.fetchone()
            invoice_total = invoice_total_result[0] if invoice_total_result else 0

            if total_credit_accounts != invoice_total:
                validation_errors.append("Validation 4 failed: Total credit amount in accounts does not match total amount of the invoice")
                print("All Validations are done invoice amount vs credit amount total  ", total_credit_accounts, invoice_total)
        # Close cursor and connection
        if 'mycursor' in locals():
            mycursor.close()
        mydb.close()

        # If any validation errors occurred, return them as response
        if validation_errors:
            return jsonify({'error': validation_errors}), 400

        # If all validations passed, return success response
        return jsonify({'message': 'Invoice validation successful'}), 200

    except Exception as e:
        # Log any exceptions
        logger.error(f"An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500

    
def find_header_id_by_invoice_number(mydb, invoice_number):
    try:
        # Define the query to select header_id based on invoice_number
        select_query = """
            SELECT header_id
            FROM fin.salesinvoice
            WHERE invoice_number = %s
        """

        # Initialize cursor
        mycursor = mydb.cursor()

        # Execute the query
        mycursor.execute(select_query, (invoice_number,))
        result = mycursor.fetchone()

        if result:
            # If a header_id is found, return it
            return result[0]
        else:
            # If no header_id is found, return None
            return None

    except Exception as e:
        # Handle any exceptions here, such as logging or raising
        raise e

    finally:
        # Close the cursor
        if mycursor:
            mycursor.close()

            
def find_invoice_by_header_id(mydb, header_id):
    try:
        # Define the query to select header_id based on invoice_number
        select_query = """
            SELECT invoice_number
            FROM fin.salesinvoice
            WHERE header_id = %s
        """

        # Initialize cursor
        mycursor = mydb.cursor()

        # Execute the query
        mycursor.execute(select_query, (header_id,))
        result = mycursor.fetchone()

        if result:
            # If a header_id is found, return it
            return result[0]
        else:
            # If no header_id is found, return None
            return None

    except Exception as e:
        # Handle any exceptions here, such as logging or raising
        raise e

    finally:
        # Close the cursor
        if mycursor:
            mycursor.close()
