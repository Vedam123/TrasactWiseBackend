from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger

sales_invoice_lines_api = Blueprint('sales_invoice_lines_api', __name__)

@sales_invoice_lines_api.route('/create_sales_invoice_lines', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_sales_invoice_lines():
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
        logger.debug(f"{appuser} --> {__name__}: Entered the 'create_sales_invoice_lines' function")


        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        # Log the received data
        logger.debug(f"{appuser} --> {__name__}: Received data: {data}")

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
                    appuserid,  # created_by
                    appuserid   # updated_by
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
            logger.info(f"{appuser} --> {__name__}: Updated totalamount for header_id: {header_id} to {total_amount}")

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
            logger.error(f"{appuser} --> {__name__}: Unable to create sales invoice lines data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500

    except Exception as e:
        # Log any exceptions
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
