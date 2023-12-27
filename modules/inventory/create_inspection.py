from flask import jsonify, request, Blueprint
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

create_inspection_api = Blueprint('create_inspection_api', __name__)

# ... (Previous imports and code)

def create_inspection_logic(data, USER_ID, current_userid,mydb):
    try:
        # Extract additional fields from the data
        inspection_location_id = data['inspection_location_id']
        receipt_name = data['receipt_name']
        item_id = data['item_id']
        uom_id = data['uom_id']
        transaction_quantity = data.get('transaction_quantity')
        accepted_quantity = data.get('accepted_quantity', 0)  # Default to 0 if not present
        rejected_quantity = data.get('rejected_quantity', 0)  # Default to 0 if not present
        status = data.get('status', '')
        comments = data.get('comments', '')
        transaction_number = data.get('transaction_number')
        transaction_type = data.get('transaction_type')
        accepted_qty_details = data.get('accepted_qty_details', '')
        rejected_qty_details = data.get('rejected_qty_details', '')

        # Log parsed data
        logger.debug(f"{USER_ID} --> {__name__}: Parsed Inspection Location ID: {inspection_location_id}")
        logger.debug(f"{USER_ID} --> {__name__}: Parsed Item ID: {item_id}")
        logger.debug(f"{USER_ID} --> {__name__}: Parsed UOM ID: {uom_id}")
        logger.debug(f"{USER_ID} --> {__name__}: Parsed Transaction Quantity: {transaction_quantity}")
        # ... (Other log statements)

        mycursor = mydb.cursor()

        try:
            query = """
                INSERT INTO inv.inspection (item_id, inspection_name, inspection_location_id, transaction_quantity, accepted_quantity, rejected_quantity, uom_id, status, comments, transaction_number, transaction_type, accepted_qty_details, rejected_qty_details, created_by, updated_by)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """
            values = (
                item_id,
                receipt_name,
                inspection_location_id,
                transaction_quantity,
                accepted_quantity,
                rejected_quantity,
                uom_id,
                status,
                comments,
                transaction_number,
                transaction_type,
                accepted_qty_details,
                rejected_qty_details,
                current_userid,
                current_userid
            )

            mycursor.execute(query, values)
            mydb.commit()

            # Log success
            logger.info(f"{USER_ID} --> {__name__}: Inspection data created successfully")
            return {'message': 'Inspection data created successfully'}, 200

        except Exception as e:
            # Log the error
            logger.error(f"{USER_ID} --> {__name__}: Unable to create inspection data: {str(e)}")
            return {'error': str(e)}, 500

    except Exception as e:
        # Log any exceptions
        logger.error(f"{USER_ID} --> {__name__}: An error occurred: {str(e)}")
        return {'error': str(e)}, 500


@create_inspection_api.route('/create_inspection', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_inspection():
    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        # Log entry point
        logger.debug(f"{USER_ID} --> {__name__}: Entered in the create inspection function")

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

        result, status_code = perform_inspection_logic(data, USER_ID, current_userid,mydb)

        # Close the cursor and connection
        mydb.close()

        return jsonify(result), status_code

    except Exception as e:
        # Log any exceptions
        logger.error(f"{USER_ID} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500

