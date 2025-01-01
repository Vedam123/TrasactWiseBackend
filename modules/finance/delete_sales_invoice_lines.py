from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger

# Define the Blueprint
delete_sales_invoice_lines_api = Blueprint('delete_sales_invoice_lines_api', __name__)

# Define the route
@delete_sales_invoice_lines_api.route('/delete_sales_invoice_lines', methods=['DELETE'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def delete_sales_invoice_lines():
    try:
        # Get the user ID from the token
       	
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
        
        message = ""

        # Log entry point
        logger.debug(f"{appuser} --> {__name__}: Entered the 'delete_sales_invoice_lines' function")

        # Get the request data
        data = request.get_json()

        header_id = int(data.get('header_id'))
        line_id = int(data.get('line_id'))

        # Log the received data
        logger.debug(f"{appuser} --> {__name__}: Received data: {data}")

        # Check if both header and line data exist
        if not record_exists_in_database(mydb, header_id, line_id):
            return jsonify({'error': 'No such line exists in the sale invoice.'}), 404

        # Delete the line
        delete_line_from_database(mydb, header_id, line_id)

        # Log success
        logger.info(f"{appuser} --> {__name__}: Deleted sale invoice line")

        # Close the database connection
        mydb.close()

        return jsonify({'success': True, 'message': 'Sale invoice line deleted successfully.'}), 200

    except Exception as e:
        # Log any exceptions
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500

def record_exists_in_database(mydb, header_id, line_id):
    try:
        # Query to check if a record exists with the given parameters
        select_query = """
            SELECT COUNT(*) 
            FROM fin.salesinvoicelines 
            WHERE header_id = %s AND line_id = %s
        """

        # Initialize the cursor
        mycursor = mydb.cursor()

        # Execute the select query
        mycursor.execute(select_query, (header_id, line_id))
        result = mycursor.fetchone()

        # Check if any record exists
        return result[0] > 0

    except Exception as e:
        raise e

    finally:
        # Close the cursor
        mycursor.close()

def delete_line_from_database(mydb, header_id, line_id):
    try:
        # Delete query
        delete_query = """
            DELETE FROM fin.salesinvoicelines
            WHERE header_id = %s AND line_id = %s
        """

        # Initialize the cursor
        mycursor = mydb.cursor()

        # Execute the delete query
        mycursor.execute(delete_query, (header_id, line_id))
        mydb.commit()
        
        update_totalamount(mydb, header_id)

    except Exception as e:
        raise e

    finally:
        # Close the cursor
        mycursor.close()

def update_totalamount(mydb, header_id):
    try:
        # Total amount query
        total_amount_query = """
            SELECT SUM(line_total) AS total_amount
            FROM fin.salesinvoicelines
            WHERE header_id = %s
        """

        # Update query
        update_query = """
            UPDATE fin.salesinvoice
            SET totalamount = %s
            WHERE header_id = %s
        """

        # Initialize the cursor
        mycursor = mydb.cursor()

        # Execute the total amount query
        mycursor.execute(total_amount_query, (header_id,))
        total_amount_result = mycursor.fetchone()
        total_amount = total_amount_result[0] if total_amount_result[0] else 0

        # Update totalamount in fin.salesinvoice table
        mycursor.execute(update_query, (total_amount, header_id))
        mydb.commit()

    except Exception as e:
        raise e

    finally:
        # Close the cursor
        mycursor.close()  

# You can continue defining other routes or functions as needed.
