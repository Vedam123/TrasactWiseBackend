from flask import jsonify, request, Blueprint
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

shipments_api = Blueprint('shipments_api', __name__)

# ... (Previous imports and code)

@shipments_api.route('/shipments', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_shipment():
    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        logger.debug(f"{USER_ID} --> {__name__}: Entered in the create shipment function")

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

        logger.debug(f"{USER_ID} --> {__name__}: Received data: {data}")

        item_id = data['item_id']
        shipment_name = data['shipment_name']
        staging_location_id = data['staging_location_id']
        quantity = data['quantity']
        uom_id = data['uom_id']
        comments = data.get('comments', '')
        inspect = data.get('inspect', False)
        transaction_number = data.get('transaction_number')
        transaction_status = data.get('status')

        logger.debug(f"{USER_ID} --> {__name__}: Parsed Item ID: {item_id}")
        logger.debug(f"{USER_ID} --> {__name__}: Parsed Shipment Name: {shipment_name}")
        logger.debug(f"{USER_ID} --> {__name__}: Parsed Staging Location ID: {staging_location_id}")
        logger.debug(f"{USER_ID} --> {__name__}: Parsed Quantity: {quantity}")
        logger.debug(f"{USER_ID} --> {__name__}: Parsed UOM ID: {uom_id}")
        logger.debug(f"{USER_ID} --> {__name__}: Parsed Comments: {comments}")
        logger.debug(f"{USER_ID} --> {__name__}: Parsed Inspect: {inspect}")
        logger.debug(f"{USER_ID} --> {__name__}: Parsed Transaction Number: {transaction_number}")
        logger.debug(f"{USER_ID} --> {__name__}: Parsed status: {transaction_status}")

        mycursor = mydb.cursor()

        try:
            query = """
                INSERT INTO inv.shipments (item_id, shipment_name, staging_location_id, quantity, uom_id, comments, inspect, transaction_number, created_by, updated_by, status)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """
            values = (
                item_id,
                shipment_name,
                staging_location_id,
                quantity,
                uom_id,
                comments,
                inspect,
                transaction_number,
                current_userid,
                current_userid,
                transaction_status
            )

            mycursor.execute(query, values)
            mydb.commit()

            logger.info(f"{USER_ID} --> {__name__}: Shipment data created successfully")
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Shipment data created successfully'}), 200

        except Exception as e:
            logger.error(f"{USER_ID} --> {__name__}: Unable to create shipment data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500

    except Exception as e:
        logger.error(f"{USER_ID} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
