from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger

create_item_inventory_api = Blueprint('create_item_inventory_api', __name__)

@create_item_inventory_api.route('/create_item_inventory', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_item_inventory():
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
        logger.debug(f"{appuser} --> {__name__}: Entered in the create item inventory function")

        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        # Log the received data
        logger.debug(f"{appuser} --> {__name__}: Received data: {data}")

        item_id = data['item_id']
        bin_id = data['bin_id']
        uom_id = data['uom_id']
        quantity = data['quantity']
        transaction_id = data['transaction_id']
        transaction_type = data['transaction_type']
        created_by = appuserid
        updated_by = appuserid
        status = 'No'  # Set status to 'No'

        # Log parsed data
        logger.debug(f"{appuser} --> {__name__}: Parsed Item ID: {item_id}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Bin ID: {bin_id}")
        logger.debug(f"{appuser} --> {__name__}: Parsed UOM ID: {uom_id}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Quantity: {quantity}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Transaction ID: {transaction_id}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Transaction Type: {transaction_type}")

        mycursor = mydb.cursor()

        try:
            query = """
                INSERT INTO inv.item_inventory (item_id, bin_id, uom_id, quantity, transaction_id, transaction_type, status, created_by, updated_by)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
            """
            values = (item_id, bin_id, uom_id, quantity, transaction_id, transaction_type, status, created_by, updated_by)

            mycursor.execute(query, values)
            mydb.commit()

            # Log success and close the cursor and connection
            logger.info(f"{appuser} --> {__name__}: Item inventory data created successfully")
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Item inventory data created successfully'}), 200

        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{appuser} --> {__name__}: Unable to create item inventory data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500
    except Exception as e:
        # Log any exceptions
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
