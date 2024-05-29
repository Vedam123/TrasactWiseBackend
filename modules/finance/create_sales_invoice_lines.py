from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

sales_invoice_lines_api = Blueprint('sales_invoice_lines_api', __name__)

@sales_invoice_lines_api.route('/create_sales_invoice_lines', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_sales_invoice_lines():
    try:
        authorization_header = request.headers.get('Authorization')
        token_results = ""
        USER_ID = ""
        MODULE_NAME = __name__
        if authorization_header:
            token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
            token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None

        # Log entry point
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'create_sales_invoice_lines' function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)

        current_userid = None
        authorization_header = request.headers.get('Authorization', '')
        if authorization_header.startswith('Bearer '):
            token = authorization_header.replace('Bearer ', '')
            decoded_token = decode_token(token)
            current_userid = decoded_token.get('Userid')

        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        # Log the received data
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Received data: {data}")

        # Assuming your salesinvoicelines table has columns like header_id, item_id, etc.
        insert_query = """
            INSERT INTO fin.salesinvoicelines (line_number, header_id, item_id, quantity, unit_price, line_total, uom_id, created_by, updated_by)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        """

        mycursor = mydb.cursor()

        try:
            response_lines = []

            for line_data in data:
                # Assuming the data dictionary contains the necessary keys for each line
                insert_values = (
                    line_data.get('line_number'),
                    line_data.get('header_id'),
                    line_data.get('item_id'),
                    line_data.get('quantity'),
                    line_data.get('unit_price'),
                    line_data.get('line_total'),
                    line_data.get('uom_id'),
                    current_userid,  # created_by
                    current_userid   # updated_by
                )

                mycursor.execute(insert_query, insert_values)
                mydb.commit()

                line_id = mycursor.lastrowid  # Get the ID of the inserted row
                line_number = line_data.get('line_number')  # Get the line number from the request data
                line_total = line_data.get('line_total')  # Get the line total from the request data

                response_lines.append({
                    'line_id': line_id,
                    'line_number': line_number,
                    'line_total': line_total
                })

            # Get the header_id of the inserted line
            header_id = line_data.get('header_id')

             # Calculate total amount for the header_id
            total_amount_query = """
                SELECT SUM(line_total) AS total_amount
                FROM fin.salesinvoicelines
                WHERE header_id = %s
            """

            mycursor.execute(total_amount_query, (header_id,))
            total_amount_result = mycursor.fetchone()
            total_amount = total_amount_result[0]  # Access the total_amount using index 0 from the tuple

            # Update totalamount in fin.salesinvoice table for the corresponding header_id
            update_query = """
                UPDATE fin.salesinvoice
                SET totalamount = %s
                WHERE header_id = %s
            """

            mycursor.execute(update_query, (total_amount, header_id))
            mydb.commit()

                # Log success
            logger.info(f"{USER_ID} --> {MODULE_NAME}: Updated totalamount for header_id: {header_id} to {total_amount}")

            # Close the cursor and connection
            mycursor.close()
            mydb.close()

            # Construct response with additional data
            response = {
                'success': True,
                'message': 'Sales Invoice Lines created successfully',
                'lines': response_lines
            }

            return response, 200

        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{USER_ID} --> {MODULE_NAME}: Unable to create sales invoice lines data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500

    except Exception as e:
        # Log any exceptions
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
