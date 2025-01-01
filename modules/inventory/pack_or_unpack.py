from flask import jsonify, request, Blueprint
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.inventory.routines.convert_pack_and_split import convert_pack_and_split
from modules.utilities.logger import logger

pack_or_unpack_api = Blueprint('pack_or_unpack_api', __name__)

@pack_or_unpack_api.route('/pack_or_unpack_api', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def pack_or_unpack():
    MODULE_NAME = __name__
    mydb = None
    mycursor = None

    try:
        # Log request details
        logger.info(f"Received request: {request.method} {request.url}")

        # Extract authorization token from the request header
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

        # Extract input data from the request body
        data = request.get_json()
        logger.debug(f"Request Data: {data}")

        # Extract individual input parameters
        input_inventory_id = data.get('input_inventory_id')
        input_transaction_id = data.get('input_transaction_id')
        input_item_id = data.get('input_item_id')
        input_transaction_type = data.get('input_transaction_type')
        input_source_uom_id = data.get('input_source_uom_id')
        input_target_uom_id = data.get('input_target_uom_id')

        # Log individual input parameters
        logger.debug(f"Input Inventory ID: {input_inventory_id}")
        logger.debug(f"Input Transaction ID: {input_transaction_id}")
        logger.debug(f"Input Item ID: {input_item_id}")
        logger.debug(f"Input Transaction Type: {input_transaction_type}")
        logger.debug(f"Input Source UOM ID: {input_source_uom_id}")
        logger.debug(f"Input Target UOM ID: {input_target_uom_id}")

        input_params = {
            'input_inventory_id': input_inventory_id,
            'input_transaction_id': input_transaction_id,
            'input_item_id': input_item_id,
            'input_transaction_type': input_transaction_type,
            'input_source_uom_id': input_source_uom_id,
            'input_target_uom_id': input_target_uom_id
        }

        print("Input Parameters ",input_params)

        # Validate mandatory parameters
        if not (input_inventory_id and input_transaction_id and input_item_id and input_transaction_type and input_source_uom_id and input_target_uom_id):
            logger.error(f"Missing mandatory parameters in the request")
            return f'Missing Mandatory Inputs, please check {input_item_id} {input_target_uom_id}', 400
        
        if  (input_source_uom_id == input_target_uom_id):
            logger.error(f"Both Input and Target UOM should not be same")
            return f'Both Input and Target UOM are Same, conversion is not possible {input_item_id} {input_target_uom_id}', 400

        logger.debug(f"Database Connection established for User ID: {appuser}")

        mycursor = mydb.cursor()

        # Log SQL query execution
        inventory_query = """
            SELECT * 
            FROM inv.item_inventory
            WHERE 
                inventory_id = %s 
                AND transaction_id = %s 
                AND item_id = %s 
                AND transaction_type = %s 
                AND uom_id = %s
                AND (status IS NULL OR TRIM(LOWER(status)) != 'yes')
        """

        mycursor.execute(inventory_query, (input_inventory_id, input_transaction_id, input_item_id, input_transaction_type, input_source_uom_id))
        fetched_row = mycursor.fetchone()
        if fetched_row is None:
            logger.info("No row found for the specified parameters")
            return f'No data found for the given Input {input_item_id} {input_target_uom_id}', 400
        input_quantity = fetched_row[5]
        logger.debug(f"Fetched Row from Inventory table: {input_quantity}")

        # Log function call
        result, status_code = convert_pack_and_split(input_params, input_quantity, mydb, appuser, MODULE_NAME,appuserid,appuserid)
        logger.debug(f"The return results of convert pack and split function: {result}")
        mycursor.close()
        mydb.close()
        if status_code == 200 : 
            logger.info("Request processed successfully")  
            return f'Item {input_item_id} UOM conversion is Successful to {input_target_uom_id}', 200
        
        return f'Item {input_item_id} UOM conversion is not successful to {input_target_uom_id}', 422 

    except Exception as e:
        # Log exception details
        logger.error(f"Error occurred: {str(e)}")
        logger.error(f"Error processing - {str(e)}, Request variables: {data}")
        return f'Item {input_item_id} UOM conversion is NOT Successful to {input_target_uom_id}', 422 

    finally:
        if mycursor:
            mycursor.close()
        if mydb:
            mydb.close()
