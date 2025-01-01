from flask import jsonify
from modules.utilities.logger import logger

def pack_or_unpack_quantity(input_params, qty, uom_id):
    appuser = input_params.get('appuser', '')
    MODULE_NAME = input_params.get('MODULE_NAME', '')
    logger.info(f"{appuser} --> {MODULE_NAME}: Entered pack_or_unpack_quantity function")
    mydb = input_params.get('mydb', None)
    mycursor = mydb.cursor()

    try:
        logger.debug(f"{appuser} --> {MODULE_NAME}: Constructing SQL query and parameters {input_params}")
        logger.debug(f"{appuser} --> {MODULE_NAME}: Input Parameters received  {input_params}")
        logger.debug(f"{appuser} --> {MODULE_NAME}: Quantity and UOM Id received {qty} --> {uom_id}")

        # Replace empty strings with None
        bin_id = input_params.get('input_bin_id', '') or None
        rack_id = input_params.get('input_rack_id', '') or None
        row_id = input_params.get('input_row_id', '') or None
        aisle_id = input_params.get('input_aisle_id', '') or None
        zone_id = input_params.get('input_zone_id', '') or None
        location_id = input_params.get('input_location_id', '') or None
        warehouse_id = input_params.get('input_warehouse_id', '') or None

        insert_query = """
            INSERT INTO inv.item_inventory (transaction_id, item_id, 
            transaction_type, uom_id, quantity, bin_id, rack_id, row_id,
            aisle_id, zone_id, location_id, warehouse_id, additional_info, created_by, updated_by)
            VALUES (
            %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s
            )
            """
        print("Print the Input params in the pack or unpack qanty function ",input_params, qty, uom_id)
        print("Insert Query:", insert_query)

        insert_params = (
            input_params.get('input_transaction_id', '100001'),
            input_params.get('input_item_id', ''),
            input_params.get('input_transaction_type', ''),
            uom_id,
            qty,
            bin_id,
            rack_id,
            row_id,
            aisle_id,
            zone_id,
            location_id,
            warehouse_id,
            input_params.get('target_additional_info', ''),
            input_params.get('created_by', ''),
            input_params.get('updated_by', '')
        )

        logger.debug(f"{appuser} --> {MODULE_NAME}: Executing SQL query")
        print("Insert Params:", insert_params)

        mycursor.execute(insert_query, insert_params)
        mydb.commit()
        logger.info(f"{appuser} --> {MODULE_NAME}: Insert and Update successful")

    except Exception as operation_error:
        mydb.rollback()
        logger.error(f"{appuser} --> {MODULE_NAME}: Error during database operation: {str(operation_error)}")
        print("I entered into exception , not sure why ")
        return {'error': 'The Data insertion is failed in inv.item_inventory table'} , 400 

    finally:
        mycursor.close()
        logger.debug(f"{appuser} --> {MODULE_NAME}: Closing database cursor")

    return {'message': 'The Data insertion is successful in inv.item_inventory table'} , 200 
