from flask import jsonify, request, Blueprint
from itertools import zip_longest
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import WRITE_ACCESS_TYPE
from modules.inventory.routines.move_inventory import move_inventory
from modules.utilities.logger import logger

move_item_inventory_api = Blueprint('move_item_inventory_api', __name__)

@move_item_inventory_api.route('/move_item_inventory', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def move_item_inventory():
    MODULE_NAME = __name__
    mydb1 = None
    mycursor = None

    try:
        data = request.get_json(silent=True)
        authorization_header = request.headers.get('Authorization')

        try:
            company, instance, dbuser, mydb1, appuser, appuserid, user_info, employee_info = get_user_and_db_details(authorization_header)
            logger.debug(f"{appuser} --> {MODULE_NAME}: Successfully retrieved user details from the token.")
        except ValueError as e:
            logger.error(f"Failed to retrieve user details from token. Error: {str(e)}")
            return jsonify({"error": str(e)}), 401
        
        if not appuser:
            logger.error(f"Unauthorized access attempt: {appuser} --> {MODULE_NAME}: Application user not found.")
            return jsonify({"error": "Unauthorized. Username not found."}), 401
        
        logger.debug(f"{appuser} --> {MODULE_NAME}: User ID from Token: {appuser}")
        logger.info(f"{appuser} --> {MODULE_NAME}: Received request: {request.method} {request.url}")

        # Extract individual input parameters
        source_item_id = data.get('source_item_id')
        source_uom_id = data.get('source_uom_id')
        source_inventory_id = data.get('source_inventory_id')
        source_quantity = data.get('source_quantity', 0)
        target_quantity = data.get('target_quantity', 0)
        source_transaction_id = data.get('source_transaction_id')
        source_transaction_type = data.get('source_transaction_type')
        source_bin_id = data.get('source_bin_id', None)
        source_rack_id = data.get('source_rack_id', None)
        source_row_id = data.get('source_row_id', None)
        source_aisle_id = data.get('source_aisle_id', None)
        source_zone_id = data.get('source_zone_id', None)
        source_location_id = data.get('source_location_id', None)
        source_warehouse_id = data.get('source_warehouse_id', None)
        target_bin_id = data.get('target_bin_id', None)
        target_rack_id = data.get('target_rack_id', None)
        target_row_id = data.get('target_row_id', None)
        target_aisle_id = data.get('target_aisle_id', None)
        target_zone_id = data.get('target_zone_id', None)
        target_location_id = data.get('target_location_id', None)
        target_warehouse_id = data.get('target_warehouse_id', None)
        source_additional_info = data.get('source_additional_info', '')
        source_status = data.get('source_status', None)
        source_subject = data.get('source_subject', None)

        if source_quantity == 0:
             return 'Error: Move Quantity 0 cannot be moved', 400
        
        if target_quantity == 0:
             return 'Error: Move Quantity 0 cannot be moved', 400

        # Validate mandatory fields
        mandatory_fields = [
            source_item_id, source_uom_id, source_inventory_id,
            source_quantity, target_quantity, source_transaction_id,
            source_transaction_type, source_additional_info
        ]

        if any(field is None for field in mandatory_fields):
            return 'Error: Missing mandatory parameters in the request', 400

        # Validate at least one parameter from each group has a value
        source_group = [source_bin_id, source_rack_id, source_row_id, source_aisle_id, source_zone_id, source_location_id, source_warehouse_id]
        target_group = [target_bin_id, target_rack_id, target_row_id, target_aisle_id, target_zone_id, target_location_id,target_warehouse_id]

        if all(param is None for param in source_group) or all(param is None for param in target_group):
            return 'Error: At least one parameter from each group is required', 400
        
        # Check for one-to-one matching including None
        if any(src != tgt for src, tgt in zip_longest(source_group, target_group)):
            logger.debug(f"{appuser} --> {MODULE_NAME}: The source inventory and Target inventory are not matching so it's okay: {appuser}")
        else:
            logger.debug(f"{appuser} --> {MODULE_NAME}: The source inventory and Target inventory are matching so not possible to move: {appuser}")
            return 'Error: It is not possible to Move inventory to the same Location', 400

        # Log database connection
        try:
            with mydb1 as mydb:
                
                logger.debug(f"{appuser} --> {MODULE_NAME}: Database Connection established for User ID in with 1: {appuser}")

                # Check if the source_inventory_id exists
                check_inventory_query = """
                    SELECT *
                    FROM inv.item_inventory
                    WHERE
                        inventory_id = %s
                        AND item_id = %s
                        AND uom_id = %s
                        {0}  -- Dynamic conditions placeholder
                        AND quantity = %s
                """

                # List of optional parameters and their corresponding database columns
                optional_params = [
                    ('bin_id', source_bin_id),
                    ('rack_id', source_rack_id),
                    ('row_id', source_row_id),
                    ('aisle_id', source_aisle_id),
                    ('zone_id', source_zone_id),
                    ('location_id', source_location_id),
                    ('warehouse_id', source_warehouse_id),
                ]

                # Build the dynamic conditions
                dynamic_conditions = []
                dynamic_values = []  # Create a list to store values for dynamic conditions

                for param, value in optional_params:
                    if value is not None:
                        dynamic_conditions.append(f"AND ({param} IS NULL OR {param} = %s)")
                        dynamic_values.append(value)  # Add the value to the list
                    else:
                        dynamic_conditions.append(f"AND {param} IS NULL")

                # If there are dynamic conditions, add them to the query
                if dynamic_conditions:
                    check_inventory_query = check_inventory_query.format(" ".join(dynamic_conditions))

                with mydb.cursor() as mycursor:
                    mycursor.execute(check_inventory_query, (
                        source_inventory_id,
                        source_item_id,
                        source_uom_id,
                        *dynamic_values,
                        source_quantity
                    ))
                    existing_inventory = mycursor.fetchone()
                
                logger.debug(f"{appuser} --> {MODULE_NAME}: Inside with  1 end part: {appuser}")

                if not existing_inventory:
                    logger.debug(f"{appuser} --> {MODULE_NAME}: Source inventory with inventory_id {source_inventory_id} does not exist")
                    return 'Error: Source inventory does not exist', 400
        except Exception as e:
            logger.error(f"{appuser} --> {MODULE_NAME}: Error occurred while establishing DB connection with 1: {str(e)}")
            return 'Error: Could not establish a database connection with 1', 500

        logger.debug(f"{appuser} --> {MODULE_NAME}: Now start with 2 : {appuser}")



        try:
            company, instance, dbuser, mydb1, appuser, appuserid, user_info, employee_info = get_user_and_db_details(authorization_header)
            logger.debug(f"{appuser} --> {MODULE_NAME}: Successfully retrieved user details from the token.")
        except ValueError as e:
            logger.error(f"Failed to retrieve user details from token. Error: {str(e)}")
            return jsonify({"error": str(e)}), 401
        
        if not appuser:
            logger.error(f"Unauthorized access attempt: {appuser} --> {MODULE_NAME}: Application user not found.")
            return jsonify({"error": "Unauthorized. Username not found."}), 401
        
        logger.debug(f"{appuser} --> {MODULE_NAME}: User ID from Token: {appuser}")

        logger.info(f"{appuser} --> {MODULE_NAME}: Received request: {request.method} {request.url}")
        try:    # Log database connection
            with mydb1 as mydb:
                logger.debug(f"{appuser} --> {MODULE_NAME}: Database Connection established for User ID in with 2: {appuser}")
               
                with mydb.cursor() as mycursor:
                    input_params = {
                        'source_item_id': source_item_id,
                        'source_uom_id': source_uom_id,
                        'source_inventory_id': source_inventory_id,
                        'source_quantity': source_quantity,
                        'target_quantity': target_quantity,
                        'source_transaction_id': source_transaction_id,
                        'source_transaction_type': source_transaction_type,
                        'source_bin_id': source_bin_id,
                        'source_rack_id': source_rack_id,
                        'source_row_id': source_row_id,
                        'source_aisle_id': source_aisle_id,
                        'source_zone_id': source_zone_id,
                        'source_location_id': source_location_id,
                        'source_warehouse_id': source_warehouse_id,
                        'target_bin_id': target_bin_id,
                        'target_rack_id': target_rack_id,
                        'target_row_id': target_row_id,
                        'target_aisle_id': target_aisle_id,
                        'target_zone_id': target_zone_id,
                        'target_location_id': target_location_id,
                        'target_warehouse_id': target_warehouse_id,
                        'source_additional_info': source_additional_info,
                        'source_status': source_status,
                        'source_subject': source_subject,                    
                        'mydb': mydb,
                        'appuser': appuser,
                        'MODULE_NAME': MODULE_NAME,
                        'created_by': appuserid,
                        'updated_by': appuserid
                    }
                    logger.debug(f"{appuser} --> {MODULE_NAME}: Going to call the mov_inventory function in with 2: {appuser}")
                    result, status_code = move_inventory(input_params)
                    logger.debug(f"{appuser} --> {MODULE_NAME}: called the move inventory function in with 2: {appuser}")

            if status_code == 200:
                logger.info(f"{appuser} --> {MODULE_NAME}: Inventory moved successfully")
                return 'Success : Inventory moved successfully', status_code
            else:
                logger.error(f"{appuser} --> {MODULE_NAME}: Inventory is not moved ")
                return 'Error : Inventory moved successfully', status_code
        except Exception as e:
            logger.error(f"{appuser} --> {MODULE_NAME}: Error occurred while establishing DB connection in with 2: {str(e)}")
            return 'Error: Could not establish a database connection in with 2', 500

    except Exception as e:
        # Log exception details
        logger.error(f"{appuser} --> {MODULE_NAME}: Error occurred: {str(e)}")
        return 'Error Internal Server Error', 500
