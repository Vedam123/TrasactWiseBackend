from flask import jsonify, request, Blueprint
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger
from modules.inventory.create_inspection import create_inspection_logic  
from modules.purchase.routines.update_po_statuses import update_po_statuses
from modules.utilities.logger import logger

create_receipt_api = Blueprint('create_receipt_api', __name__)

@create_receipt_api.route('/create_receipt', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_receipt():
    MODULE_NAME = __name__
    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        # Log entry point
        logger.debug(f"{USER_ID} --> {__name__}: Entered in the create receipt function")

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

        receiving_location_id = data['receiving_location_id']
        type_short = data['type_short']
        quantity = data['quantity']
        uom_id = data['uom_id']
        comments = data.get('comments')
        item_id = data['item_id']
        receipt_name = data['receipt_name']
        inspect = data.get('inspect')
        transaction_number = data.get('transaction_number')
        transaction_status = data.get('status')
        accepted_qty = data.get('accepted_qty')
        rejected_qty = data.get('rejected_qty')
        inspection_id = data.get('inspection_id')
        inspection_location_id = data.get('inspection_location_id')
        po_line_id = data.get('po_line_id')

        update_comments = " ( " +receipt_name + ") - (" + str(transaction_number)+ ") - (" + comments + ")"

        # Log the received data
        logger.debug(f"{USER_ID} --> {__name__}: Received data: {data}")

        logger.debug(f"{USER_ID} --> {__name__}: Receiving Location ID: {receiving_location_id}")
        logger.debug(f"{USER_ID} --> {__name__}: Type Short: {type_short}")
        logger.debug(f"{USER_ID} --> {__name__}: Quantity: {quantity}")
        logger.debug(f"{USER_ID} --> {__name__}: UOM ID: {uom_id}")
        logger.debug(f"{USER_ID} --> {__name__}: Comments: {update_comments}")
        logger.debug(f"{USER_ID} --> {__name__}: Item ID: {item_id}")
        logger.debug(f"{USER_ID} --> {__name__}: Receipt Name: {receipt_name}")
        logger.debug(f"{USER_ID} --> {__name__}: Inspect: {inspect}")
        logger.debug(f"{USER_ID} --> {__name__}: Transaction Number: {transaction_number}")
        logger.debug(f"{USER_ID} --> {__name__}: Transaction Status: {transaction_status}")
        logger.debug(f"{USER_ID} --> {__name__}: Accepted Quantity: {accepted_qty}")
        logger.debug(f"{USER_ID} --> {__name__}: Rejected Quantity: {rejected_qty}")
        logger.debug(f"{USER_ID} --> {__name__}: Inspection ID: {inspection_id}")
        logger.debug(f"{USER_ID} --> {__name__}: Inspection Location ID: {inspection_location_id}")

        mycursor = mydb.cursor()
        print("Before Inserting into receipts ")

        try:
            mycursor.execute("START TRANSACTION")
            query = """
                INSERT INTO inv.receipts (
                    receipt_id, 
                    transaction_number, 
                    item_id, 
                    receipt_name, 
                    receiving_location_id, 
                    quantity, 
                    uom_id, 
                    comments, 
                    inspect, 
                    accepted_qty, 
                    rejected_qty, 
                    inspection_id,
                    inspection_location_id,  -- Added field
                    status, 
                    created_by, 
                    updated_by
                )
                VALUES (
                    NULL, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
                )
            """
            values = (
                transaction_number, 
                item_id, 
                receipt_name, 
                receiving_location_id, 
                quantity, 
                uom_id, 
                update_comments, 
                inspect, 
                accepted_qty, 
                rejected_qty, 
                inspection_id, 
                inspection_location_id,  # Added field
                transaction_status, 
                current_userid, 
                current_userid
            )

            mycursor.execute(query, values)
            print("After Inserting into receipts ")
            # Retrieve the last inserted ID (receipt_id)
            receipt_id = mycursor.lastrowid

            # Log success
            logger.info(f"{USER_ID} --> {__name__}: Receipt data created successfully with receipt_id: {receipt_id}")
            print("Before Inspect check of receipts ")
            # Check if transaction_status is true and inspect flag is true, then call perform_inspection API
            if inspect:
                # Prepare data for perform_inspection
                inspection_data = {
                    "inspection_location_id": inspection_location_id,
                    "receipt_name": receipt_name,
                    "item_id": item_id,
                    "uom_id": uom_id,
                    "transaction_quantity": quantity,
                    "accepted_quantity": accepted_qty,
                    "rejected_quantity": rejected_qty,
                    "status": "New",
                    "comments": update_comments ,
                   # "transaction_number": receipt_id,  # Use the obtained receipt_id here
                    "transaction_number" : transaction_number,
                    "transaction_type": type_short,
                    "accepted_qty_details": "Details for accepted quantity",
                    "rejected_qty_details": "Details for rejected quantity"
                }
                print("Printing inspection data ",inspection_data)
                # Call the perform_inspection function directly
                result, status_code = create_inspection_logic(inspection_data, USER_ID, current_userid, mydb)

                if status_code == 200:
                    logger.info(f"{USER_ID} --> {__name__}: Receipt data created successfully, and inspection performed. status code {status_code} and Result {result}")
                else:
                    # Roll back the entire transaction if an error occurs in perform_inspection_logic
                    mycursor.execute("ROLLBACK")
                    logger.error(f"{USER_ID} --> {__name__}: Receipt data creation successful, but inspection failed with status code {status_code} and Result {result}. Transaction rolled back.")
                    return jsonify({'error': f"Inspection failed with status code {status_code} and Result {result}."}), 500
            print("after inpsect check and before Po UPDATE check of receipts ",po_line_id)    
            
            if po_line_id is not None and po_line_id > 0:
                success = update_po_statuses(USER_ID, MODULE_NAME, mydb, po_line_id, transaction_status)
                print("In PO line update if statement ",po_line_id)  
                if success:
                    logger.debug(
                        f"{USER_ID} --> {MODULE_NAME}: Successfully updated purchase order line status for po_line_id: {po_line_id}"
                    )
                else:
                    mydb.rollback()
                    logger.error(
                        f"{USER_ID} --> {MODULE_NAME}: Failed to update status for purchase order line with po_line_id: {po_line_id}"
                    )
            print("After PO line update",po_line_id)  
            
            mycursor.execute("COMMIT")
            mycursor.close()
            mydb.commit()
            mydb.close()
            return jsonify({'message': 'Receipt data created successfully'}), 200

        except Exception as e:
            # Roll back the entire transaction if an error occurs
            mycursor.execute("ROLLBACK")
            mydb.rollback()
            logger.error(f"{USER_ID} --> {__name__}: Unable to create receipt data: {str(e)}")
            mydb.close()
            return jsonify({'error': str(e)}), 500

    except Exception as e:
        # Log any exceptions
        mycursor.execute("ROLLBACK")
        mydb.rollback()
        logger.error(f"{USER_ID} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
