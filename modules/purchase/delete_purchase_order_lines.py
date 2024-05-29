from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

# Define the Blueprint
delete_purchase_order_lines_api = Blueprint('delete_purchase_order_lines_api', __name__)

# Define the route
@delete_purchase_order_lines_api.route('/delete_purchase_order_lines', methods=['DELETE'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def delete_purchase_order_lines():
    try:
        # Get the user ID from the token
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header) if authorization_header else None
        USER_ID = token_results["username"] if token_results else ""
        MODULE_NAME = __name__
        message = ""

        # Log entry point
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'delete_purchase_order_lines' function")

        # Get the request data
        data = request.get_json()

        # Check if header_id is provided
        header_id = int(data.get('header_id')) if 'header_id' in data else None
        if header_id is None:
            raise ValueError("header_id is required.")

        # Get the database connection
        mydb = get_database_connection(USER_ID, MODULE_NAME)

        # Get the current user ID from the token
        current_userid = decode_token(authorization_header.replace('Bearer ', '')).get('Userid') if authorization_header.startswith('Bearer ') else None

        line_ids = data.get('line_ids', [])  # Accepting zero or more line_ids,
        print("What is the Line id value ",line_ids)

        # Log the received data
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Received data: {data}")

        deleted_line_ids = []
        undeleted_line_ids = []
        deleted_all_lines_of_header= False
        success = False

        if not line_ids:
            deleted_all_lines_of_header = delete_all_lines_for_header(mydb, header_id, deleted_all_lines_of_header)
        else:
            # Delete individual lines
            for line_id in line_ids:
                if delete_line_from_database(mydb, header_id, int(line_id)):
                    deleted_line_ids.append(line_id)
                else:
                    undeleted_line_ids.append(line_id)

        if deleted_all_lines_of_header and not line_ids:
            response_message =  f"All the Purchase Order lines of the header: {header_id} are deleted successfully"
            success = True
        elif undeleted_line_ids and deleted_line_ids:
            response_message = f"Some lines are deleted: {deleted_line_ids} and some line_ids could not be deleted nor found: {undeleted_line_ids}."
            success = True
        elif deleted_line_ids and not undeleted_line_ids:
            response_message = f"All the given {deleted_line_ids} purchase order lines of the header: {header_id} are deleted successfully"
            success = True
        elif not undeleted_line_ids and not deleted_line_ids:
            response_message = "No lines are found so none deleted."
            success = False
        else:
            response_message = "No lines are found so none deleted."
            success = False

        logger.info(f"{USER_ID} --> {MODULE_NAME}: {response_message}")

        # Close the database connection
        mydb.close()

        response_data = {'success': success, 'message': response_message}

        return jsonify(response_data), 200

    except Exception as e:
        error_message = str(e)
        if "header_id is required" in error_message:
            return jsonify({'error': "header_id is required for deleting lines."}), 400
        elif "cannot access local variable 'mycursor'" in error_message:
            return jsonify({'error': "An error occurred while accessing the database. Please try again later."}), 500
        else:
            # Check if specific line_ids couldn't be deleted
            if undeleted_line_ids:
                return jsonify({'error': f"Some line_ids could not be deleted: {undeleted_line_ids}. Error: {error_message}"}), 500
            else:
                return jsonify({'error': f"An error occurred while deleting purchase order lines. Error: {error_message}"}), 500


def delete_all_lines_for_header(mydb, header_id, deleted_all_lines_of_header):
    try:
        # Delete query for all lines with the given header_id
        delete_query = """
            DELETE FROM pur.purchase_order_line
            WHERE header_id = %s
        """

        # Initialize the cursor
        mycursor = mydb.cursor()

        # Execute the delete query
        mycursor.execute(delete_query, (header_id,))

        # Check if any rows were deleted
        if mycursor.rowcount > 0:
            deleted_all_lines_of_header = True
        mydb.commit()
        update_totalamount(mydb, header_id)
        return deleted_all_lines_of_header  # Return the updated value

    except Exception as e:
        raise e

    finally:
        # Close the cursor
        mycursor.close()


# Function to check if a record exists in the database
def record_exists_in_database(mydb, header_id, line_id):
    try:
        # Query to check if a record exists with the given parameters
        select_query = """
            SELECT COUNT(*) 
            FROM pur.purchase_order_line 
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

#Function to delete a line from the database
def delete_line_from_database(mydb, header_id, line_id):
    mycursor = None  # Initialize mycursor outside of try block
    try:
        # Check if the line exists in the database
        if not record_exists_in_database(mydb, header_id, line_id):
            return False  # Line does not exist, return False
        
        # Delete query
        delete_query = """
            DELETE FROM pur.purchase_order_line
            WHERE header_id = %s AND line_id = %s
        """

        # Initialize the cursor
        mycursor = mydb.cursor()

        # Execute the delete query
        mycursor.execute(delete_query, (header_id, line_id))
        mydb.commit()

        # Update total amount after deletion
        update_totalamount(mydb, header_id)

        return True  # Line was successfully deleted

    except Exception as e:
        raise e

    finally:
        # Close the cursor if it was initialized
        if mycursor:
            mycursor.close()

# Function to update total amount after deletion
def update_totalamount(mydb, header_id):
    try:
        # Total amount query
        total_amount_query = """
            SELECT SUM(line_total) AS total_amount
            FROM pur.purchase_order_line
            WHERE header_id = %s
        """

        # Update query
        update_query = """
            UPDATE pur.purchase_order_header
            SET total_amount = %s
            WHERE header_id = %s
        """

        # Initialize the cursor
        mycursor = mydb.cursor()

        # Execute the total amount query
        mycursor.execute(total_amount_query, (header_id,))
        total_amount_result = mycursor.fetchone()
        total_amount = total_amount_result[0] if total_amount_result[0] else 0

        # Update total amount in pur.purchase_order_header table
        mycursor.execute(update_query, (total_amount, header_id))
        mydb.commit()

    except Exception as e:
        raise e

    finally:
        # Close the cursor
        mycursor.close()
