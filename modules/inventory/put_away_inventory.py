from flask import jsonify, request, Blueprint
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger

put_away_inventory_api = Blueprint('put_away_inventory_api', __name__)

@put_away_inventory_api.route('/put_away_inventory', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def put_away_inventory():
    MODULE_NAME = __name__

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

        logger.debug(f"{appuser} --> {MODULE_NAME}: Entered the 'update item inventory' function")

        mycursor = mydb.cursor()

        # Assuming you receive the item inventory data as JSON in the request body
        data = request.get_json()

        # Extract required data from the request
        item_id = data.get('item_id')
        inventory_id = data.get('inventory_id')
        uom_id = data.get('uom_id')
        quantity = data.get('quantity')
        transaction_id = data.get('transaction_id')
        transaction_type = data.get('transaction_type')
        ids = {
            'bin_id': data.get('bin_id'),
            'rack_id': data.get('rack_id'),
            'row_id': data.get('row_id'),
            'aisle_id': data.get('aisle_id'),
            'zone_id': data.get('zone_id'),
            'location_id': data.get('location_id'),
            'warehouse_id': data.get('warehouse_id')
        }
        additional_info = data.get('additional_info', '')
        transaction_source = data.get('transaction_source_id')

        # Validate mandatory parameters
        if not (item_id and uom_id and quantity and transaction_id and transaction_type):
            logger.error(f"{appuser} --> {MODULE_NAME}: Missing mandatory parameters in the request")
            return f"Error :Missing mandatory parameters in the request ", 400
        
        # Check if at least one ID is provided
        if not any(ids.values()):
            logger.error(f"{appuser} --> {MODULE_NAME}: At least one ID (bin_id, rack_id, row_id, aisle_id, zone_id, location_id, warehouse_id) is mandatory for insert")
            return f"Error :At least one warehouse location is mandatory for put Away material ", 400

        # Check if the row with the given transaction_id already exists in inv.item_inventory
        if inventory_id is not None:
            select_query = "SELECT * FROM inv.item_inventory WHERE transaction_id = %s AND inventory_id = %s AND item_id = %s AND uom_id = %s"
            mycursor.execute(select_query, (transaction_id, inventory_id, item_id, uom_id))

            existing_row = mycursor.fetchone()

            if existing_row:
                # Row with the given transaction_id and inventory_id already exists, update the quantity
                update_query = """
                    UPDATE inv.item_inventory
                    SET quantity = %s, updated_at = NOW(), updated_by = %s, additional_info = %s
                    WHERE transaction_id = %s AND inventory_id = %s AND item_id = %s AND uom_id = %s
                """
                mycursor.execute(update_query, (quantity, appuserid, additional_info, transaction_id, inventory_id, item_id, uom_id))
                logger.info(f"{appuser} --> {MODULE_NAME}: Item inventory updated successfully. transaction_id: {transaction_id}, inventory_id: {inventory_id}, Quantity: {quantity}")
                mydb.commit()
                return f"Success:Item inventory Inserted at transaction id {transaction_id} in the inventory id {inventory_id}", 200
            else:
                return f"There is no combination of {transaction_id} in the inventory id {inventory_id} , uom_id {uom_id}, item_id {item_id}", 422
        
        # Insert a new row with status as 'No'
        insert_query = """
            INSERT INTO inv.item_inventory
            (item_id, uom_id, quantity, transaction_id, transaction_type, bin_id, rack_id, row_id, aisle_id, zone_id, location_id, warehouse_id, status, created_at, updated_at, created_by, updated_by, additional_info)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, 'No', NOW(), NOW(), %s, %s, %s)
        """
        mycursor.execute(insert_query, (
            item_id, uom_id, quantity, transaction_id, transaction_type,
            ids.get('bin_id'), ids.get('rack_id'), ids.get('row_id'),
            ids.get('aisle_id'), ids.get('zone_id'), ids.get('location_id'),
            ids.get('warehouse_id'), appuserid, appuserid, additional_info
        ))
        logger.info(f"{appuser} --> {MODULE_NAME}: New item inventory row inserted successfully. transaction_id: {transaction_id}, inventory_id: {inventory_id}")
        mydb.commit()
        return f"Success:Item inventory Inserted at transaction id {transaction_id} in the inventory id {inventory_id}", 200

    except Exception as e:
        logger.error(f"{appuser} --> {MODULE_NAME}: Error updating item inventory - {str(e)}, Request variables: {data}")
        return 'Internal Server Error', 500
    finally:
        mycursor.close()
        mydb.close()
