from flask import jsonify, request, Blueprint
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger

create_inspection_api = Blueprint('create_inspection_api', __name__)

def create_inspection_logic(data, appuser, appuserid, mydb):
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
        transaction_header_number = data.get('transaction_header_number')  # Include new field
        transaction_type = data.get('transaction_type')
        accepted_qty_details = data.get('accepted_qty_details', '')
        rejected_qty_details = data.get('rejected_qty_details', '')

        # Log parsed data
        logger.debug(f"{appuser} --> {__name__}: Parsed Inspection Location ID: {inspection_location_id}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Item ID: {item_id}")
        logger.debug(f"{appuser} --> {__name__}: Parsed UOM ID: {uom_id}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Transaction Quantity: {transaction_quantity}")
        # ... (Other log statements)

        mycursor = mydb.cursor()

        try:
            query = """
                INSERT INTO inv.inspection (item_id, inspection_name, inspection_location_id, transaction_quantity, accepted_quantity, rejected_quantity, uom_id, status, comments, transaction_number, transaction_header_number, transaction_type, accepted_qty_details, rejected_qty_details, created_by, updated_by)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
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
                transaction_header_number,  # Include new field
                transaction_type,
                accepted_qty_details,
                rejected_qty_details,
                appuserid,
                appuserid
            )

            mycursor.execute(query, values)
            mydb.commit()

            # Log success
            logger.info(f"{appuser} --> {__name__}: Inspection data created successfully")
            return {'message': 'Inspection data created successfully'}, 200

        except Exception as e:
            # Log the error
            logger.error(f"{appuser} --> {__name__}: Unable to create inspection data: {str(e)}")
            return {'error': str(e)}, 500

    except Exception as e:
        # Log any exceptions
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)}")
        return {'error': str(e)}, 500


@create_inspection_api.route('/create_inspection', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_inspection():
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
        logger.debug(f"{appuser} --> {__name__}: Entered in the create inspection function")

        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        # Log the received data
        logger.debug(f"{appuser} --> {__name__}: Received data: {data}")

        result, status_code = create_inspection_logic(data, appuser, appuserid, mydb)

        # Close the cursor and connection
        mydb.close()

        return jsonify(result), status_code

    except Exception as e:
        # Log any exceptions
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
