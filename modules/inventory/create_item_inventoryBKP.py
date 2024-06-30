# modules/inventory/create_item_inventory.py

from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

create_item_inventory_api = Blueprint('create_item_inventory_api', __name__)

@create_item_inventory_api.route('/create_item_inventory', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_item_inventory():
    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
            token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None

        # Log entry point
        logger.debug(f"{USER_ID} --> {__name__}: Entered in the create item inventory function")

        mydb = get_database_connection(USER_ID, __name__)

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
        logger.debug(f"{USER_ID} --> {__name__}: Received data: {data}")

        item_id = data['item_id']
        bin_id = data['bin_id']
        uom_id = data['uom_id']
        quantity = data['quantity']
        transaction_id = data['transaction_id']
        transaction_type = data['transaction_type']
        created_by = current_userid
        updated_by = current_userid

        # Log parsed data
        logger.debug(f"{USER_ID} --> {__name__}: Parsed Item ID: {item_id}")
        logger.debug(f"{USER_ID} --> {__name__}: Parsed Bin ID: {bin_id}")
        logger.debug(f"{USER_ID} --> {__name__}: Parsed UOM ID: {uom_id}")
        logger.debug(f"{USER_ID} --> {__name__}: Parsed Quantity: {quantity}")
        logger.debug(f"{USER_ID} --> {__name__}: Parsed Transaction ID: {transaction_id}")
        logger.debug(f"{USER_ID} --> {__name__}: Parsed Transaction Type: {transaction_type}")

        mycursor = mydb.cursor()

        try:
            query = """
                INSERT INTO inv.item_inventory (item_id, bin_id, uom_id, quantity, transaction_id, transaction_type, created_by, updated_by)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
            """
            values = (item_id, bin_id, uom_id, quantity, transaction_id, transaction_type, created_by, updated_by)

            mycursor.execute(query, values)
            mydb.commit()

            # Log success and close the cursor and connection
            logger.info(f"{USER_ID} --> {__name__}: Item inventory data created successfully")
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Item inventory data created successfully'}), 200

        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{USER_ID} --> {__name__}: Unable to create item inventory data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500
    except Exception as e:
        # Log any exceptions
        logger.error(f"{USER_ID} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
