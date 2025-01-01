from flask import Blueprint, jsonify, request
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger

# Define the Blueprint
delete_purchase_orders_api = Blueprint('delete_purchase_orders_api', __name__)

# Define the route
@delete_purchase_orders_api.route('/delete_purchase_orders', methods=['DELETE'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def delete_purchase_orders():
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
    

        # Log entry point
        logger.debug(f"{appuser} --> {__name__}: Entered the 'delete_purchase_order_lines' function")

        # Get the request data
        data = request.get_json()

        # Check if po_nums and delete_lines_flag are provided
        po_nums = data.get('po_nums', [])
        delete_lines_flag = data.get('delete_lines_flag')

        if not po_nums or delete_lines_flag is None:
            raise ValueError("Both 'po_nums' and 'delete_lines_flag' are required.")


        # Initialize response message and success flag
        response_message = ""
        success = False

        if delete_lines_flag.lower() == 'yes':
            for po_num in po_nums:
                header_id = get_header_id_by_po_num(mydb, po_num)
                if header_id:
                    # Delete lines and header if lines are present
                    delete_lines_and_header(mydb, header_id)
                    response_message += f"The Purchase order {po_num} and its lines are deleted successfully.\n"
                    success = True
                else:
                    response_message += f"The purchase order {po_num} is not found .\n"
                    success = False
        elif delete_lines_flag.lower() == 'no':
            for po_num in po_nums:
                header_id = get_header_id_by_po_num(mydb, po_num)
                if header_id:
                    # Check if lines are present for the header
                    if lines_exist_for_header(mydb, header_id):
                        response_message += f"Lines are present for PO num {po_num}. Cannot delete header.\n"
                        success = False
                    else:
                        # No lines, delete header
                        delete_header(mydb, header_id)
                        response_message += f"There are no Lines for the Purchase Order {po_num} , hence the Order is deleted.\n"
                        success = True
                else:
                    response_message += f"The purchase order {po_num} is not found .\n"
                    success = False

        logger.info(f"{appuser} --> {__name__}: {response_message}")

        # Close the database connection
        mydb.close()

        response_data = {'success': success, 'message': response_message}

        return jsonify(response_data), 200

    except Exception as e:
        error_message = str(e)
        return jsonify({'error': error_message}), 500


def get_header_id_by_po_num(mydb, po_num):
    # Function to retrieve header_id based on po_num
    try:
        select_query = """
            SELECT header_id 
            FROM pur.purchase_order_header 
            WHERE po_num = %s
        """

        mycursor = mydb.cursor()
        mycursor.execute(select_query, (po_num,))
        result = mycursor.fetchone()
        if result:
            return result[0]
        else:
            return None

    except Exception as e:
        raise e

    finally:
        mycursor.close()


def delete_lines_and_header(mydb, header_id):
    # Function to delete lines and header for a given header_id
    try:
        delete_lines_query = """
            DELETE FROM pur.purchase_order_line
            WHERE header_id = %s
        """

        delete_header_query = """
            DELETE FROM pur.purchase_order_header
            WHERE header_id = %s
        """

        mycursor = mydb.cursor()
        mycursor.execute(delete_lines_query, (header_id,))
        mycursor.execute(delete_header_query, (header_id,))
        mydb.commit()

    except Exception as e:
        raise e

    finally:
        mycursor.close()


def lines_exist_for_header(mydb, header_id):
    # Function to check if lines exist for a given header_id
    try:
        select_query = """
            SELECT COUNT(*) 
            FROM pur.purchase_order_line 
            WHERE header_id = %s
        """

        mycursor = mydb.cursor()
        mycursor.execute(select_query, (header_id,))
        result = mycursor.fetchone()
        return result[0] > 0

    except Exception as e:
        raise e

    finally:
        mycursor.close()


def delete_header(mydb, header_id):
    # Function to delete header for a given header_id
    try:
        delete_header_query = """
            DELETE FROM pur.purchase_order_header
            WHERE header_id = %s
        """

        mycursor = mydb.cursor()
        mycursor.execute(delete_header_query, (header_id,))
        mydb.commit()

    except Exception as e:
        raise e

    finally:
        mycursor.close()
