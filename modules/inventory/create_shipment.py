from flask import jsonify, request, Blueprint
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger

shipments_api = Blueprint('shipments_api', __name__)

# ... (Previous imports and code)

@shipments_api.route('/shipments', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_shipment():
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

        logger.debug(f"{appuser} --> {__name__}: Entered in the create shipment function")

        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        logger.debug(f"{appuser} --> {__name__}: Received data: {data}")

        item_id = data['item_id']
        shipment_name = data['shipment_name']
        staging_location_id = data['staging_location_id']
        quantity = data['quantity']
        uom_id = data['uom_id']
        comments = data.get('comments', '')
        inspect = data.get('inspect', False)
        transaction_number = data.get('transaction_number')
        transaction_status = data.get('status')

        logger.debug(f"{appuser} --> {__name__}: Parsed Item ID: {item_id}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Shipment Name: {shipment_name}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Staging Location ID: {staging_location_id}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Quantity: {quantity}")
        logger.debug(f"{appuser} --> {__name__}: Parsed UOM ID: {uom_id}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Comments: {comments}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Inspect: {inspect}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Transaction Number: {transaction_number}")
        logger.debug(f"{appuser} --> {__name__}: Parsed status: {transaction_status}")

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
                appuserid,
                appuserid,
                transaction_status
            )

            mycursor.execute(query, values)
            mydb.commit()

            logger.info(f"{appuser} --> {__name__}: Shipment data created successfully")
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Shipment data created successfully'}), 200

        except Exception as e:
            logger.error(f"{appuser} --> {__name__}: Unable to create shipment data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500

    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
