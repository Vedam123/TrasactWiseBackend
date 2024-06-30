from flask import jsonify, request, Blueprint
from itertools import zip_longest
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from modules.admin.databases.mydb import get_database_connection
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.inventory.routines.move_inventory import move_inventory
from modules.utilities.logger import logger

move_item_inventory_api = Blueprint('move_item_inventory_api', __name__)

@move_item_inventory_api.route('/move_item_inventory', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def move_item_inventory():
    MODULE_NAME = __name__
    mydb = None
    mycursor = None

    try:
        data = request.get_json(silent=True)
        current_userid = None
        authorization_header = request.headers.get('Authorization', '')
        if authorization_header.startswith('Bearer '):
            token = authorization_header.replace('Bearer ', '')
            decoded_token = decode_token(token)
            current_userid = decoded_token.get('Userid')

        token_results = get_user_from_token(authorization_header)
        USER_ID = token_results["username"] if token_results else ""
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: User ID from Token: {USER_ID}")
        logger.info(f"{USER_ID} --> {MODULE_NAME}: Received request: {request.method} {request.url}")

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
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: The source inventory and Target inventory are not matching so it's okay: {USER_ID}")
        else:
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: The source inventory and Target inventory are matching so not possible to move: {USER_ID}")
            return 'Error: It is not possible to Move inventory to the same Location', 400

        # Log database connection
        with get_database_connection(USER_ID, MODULE_NAME) as mydb:
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: Database Connection established for User ID: {USER_ID}")

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
            
            # 'existing_inventory' is now accessible outside the 'with' block

            if not existing_inventory:
                logger.debug(f"{USER_ID} --> {MODULE_NAME}: Source inventory with inventory_id {source_inventory_id} does not exist")
                return 'Error: Source inventory does not exist', 400

        # Log database connection
        with get_database_connection(USER_ID, MODULE_NAME) as mydb:
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: Database Connection established for User ID: {USER_ID}")
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
                    'mydb': mydb,
                    'USER_ID': USER_ID,
                    'MODULE_NAME': MODULE_NAME,
                    'created_by': current_userid,
                    'updated_by': current_userid
                }

                result, status_code = move_inventory(input_params)

        if status_code == 200:
            logger.info(f"{USER_ID} --> {MODULE_NAME}: Inventory moved successfully")
            return 'Success : Inventory moved successfully', status_code
        else:
            logger.error(f"{USER_ID} --> {MODULE_NAME}: Inventory is not moved ")
            return 'Error : Inventory moved successfully', status_code

    except Exception as e:
        # Log exception details
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error occurred: {str(e)}")
        return 'Error Internal Server Error', 500
