from flask import jsonify, request, Blueprint
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger
from modules.inventory.create_inspection import create_inspection_logic  # Import the perform_inspection function

create_receipt_api = Blueprint('create_receipt_api', __name__)

# ... (Previous imports and code)

@create_receipt_api.route('/create_receipt', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_receipt():
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
        inspection_location_id = data.get('inspection_location_id')  # Added field

        update_comments = " ( " +receipt_name + ") - (" + str(transaction_number)+ ") - (" + comments + ")"

                # Print statements
        print(f"Receiving Location ID: {receiving_location_id}")
        print(f"Type Short: {type_short}")
        print(f"Quantity: {quantity}")
        print(f"UOM ID: {uom_id}")
        print(f"Comments: {update_comments}")
        print(f"Item ID: {item_id}")
        print(f"Receipt Name: {receipt_name}")
        print(f"Inspect: {inspect}")
        print(f"Transaction Number: {transaction_number}")
        print(f"Transaction Status: {transaction_status}")
        print(f"Accepted Quantity: {accepted_qty}")
        print(f"Rejected Quantity: {rejected_qty}")
        print(f"Inspection ID: {inspection_id}")
        print(f"Inspection Location ID: {inspection_location_id}")

        # Log parsed data
        logger.debug(f"{USER_ID} --> {__name__}: Parsed Receiving Location ID: {receiving_location_id}")
        # ... (Log other parsed data)

        mycursor = mydb.cursor()

        try:
            # Start a database transaction
            mycursor.execute("START TRANSACTION")

            # Insert data into inv.receipts
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

            # Retrieve the last inserted ID (receipt_id)
            receipt_id = mycursor.lastrowid

            # Log success
            logger.info(f"{USER_ID} --> {__name__}: Receipt data created successfully with receipt_id: {receipt_id}")

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
                    "transaction_number": receipt_id,  # Use the obtained receipt_id here
                    "transaction_type": type_short,
                    "accepted_qty_details": "Details for accepted quantity",
                    "rejected_qty_details": "Details for rejected quantity"
                }

                # Call the perform_inspection function directly
                result, status_code = create_inspection_logic(inspection_data, USER_ID, current_userid, mydb)

                if status_code == 200:
                    logger.info(f"{USER_ID} --> {__name__}: Receipt data created successfully, and inspection performed. status code {status_code} and Result {result}")
                else:
                    # Roll back the entire transaction if an error occurs in perform_inspection_logic
                    mycursor.execute("ROLLBACK")
                    logger.error(f"{USER_ID} --> {__name__}: Receipt data creation successful, but inspection failed with status code {status_code} and Result {result}. Transaction rolled back.")
                    return jsonify({'error': f"Inspection failed with status code {status_code} and Result {result}."}), 500

            # Commit the entire transaction
            mycursor.execute("COMMIT")

            # Close the cursor and connection
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Receipt data created successfully'}), 200

        except Exception as e:
            # Roll back the entire transaction if an error occurs
            mycursor.execute("ROLLBACK")
            # Log the error and close the cursor and connection
            logger.error(f"{USER_ID} --> {__name__}: Unable to create receipt data: {str(e)}")
            mycursor.close() 
            mydb.close()
            return jsonify({'error': str(e)}), 500

    except Exception as e:
        # Log any exceptions
        logger.error(f"{USER_ID} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
