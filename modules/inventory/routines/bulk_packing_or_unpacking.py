from flask import jsonify
from modules.inventory.routines.pack_or_unpack_quantity import pack_or_unpack_quantity
from modules.utilities.logger import logger  

def bulk_packing_or_unpacking(input_params, result_params):
    try:
        USER_ID = input_params.get('USER_ID', '')
        MODULE_NAME = input_params.get('MODULE_NAME', '')
        logger.info(f"{USER_ID} --> {MODULE_NAME}: Entered bulk_packing_or_unpacking function")
        
        # Extracting necessary variables
        input_target_uom_id = input_params.get('input_target_uom_id', '')
        input_source_uom_id = input_params.get('input_source_uom_id', '')
        target_quantity = result_params.get('target_quantity', 0)
        remainder_quantity = result_params.get('remainder_quantity', 0)

        # Logging variables
        logger.info(f"{USER_ID} --> {MODULE_NAME}: input_target_uom_id: {input_target_uom_id}")
        logger.info(f"{USER_ID} --> {MODULE_NAME}: target_quantity: {target_quantity}")
        logger.info(f"{USER_ID} --> {MODULE_NAME}: remainder_quantity: {remainder_quantity}")

        # Processing target quantity
        response, status_code = pack_or_unpack_quantity(input_params, target_quantity, input_target_uom_id)
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Target quantity is successfully inserted: {target_quantity}, {response}, {status_code}")
        print("the out put of the call pack_or_unpack_quantity result-->  ",response)
        # Processing remainder quantity
        if remainder_quantity > 0:
            response, status_code = pack_or_unpack_quantity(input_params, remainder_quantity, input_source_uom_id)
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: Remainder quantity is successfully inserted: {remainder_quantity}, {response}, {status_code}")
            print("the out put of the call pack_or_unpack_quantity result  ",response)
            print("the out put of the call pack_or_unpack_quantity status code ",status_code)
        # Check the response status and return accordingly
        if status_code == 200:
            return {'success': response}, 200
        else:
            return {'failure': response}, 400
          
    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred during inventory update: {str(e)}")
        return {'error': 'Failed to perform bulk packing or unpacking'}, 400
