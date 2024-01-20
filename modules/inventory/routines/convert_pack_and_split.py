from flask import jsonify
from modules.products.routines.uom_conversion import uom_conversion
from modules.inventory.routines.update_packed_inventory import update_packed_inventory
from modules.utilities.logger import logger 

def convert_pack_and_split(input_params, input_quantity, mydb, USER_ID, MODULE_NAME,created_by,updated_by):
    try:
        # Log entry point
        logger.info(f"{USER_ID} --> {MODULE_NAME}: Entered convert_pack_and_split function")

        # Log input parameters
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Input Parameters: {input_params}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Input Quantity: {input_quantity}")

        # Call uom_conversion function and log the result
        result, status_code = uom_conversion(input_params['input_source_uom_id'], input_quantity, input_params['input_target_uom_id'], mydb, USER_ID, MODULE_NAME)

        if status_code == 200:
            result_params = {
                'target_quantity': result['target_quantity'],
                'remainder_quantity': result['remainder_quantity']
            }
        else:
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: There is an issue in the conversion : {result}")
            return 'There is an issue in the conversion',status_code
        
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: UOM Conversion Result: {result_params}")
        result, status_code  = update_packed_inventory(input_params, result_params, mydb, USER_ID, MODULE_NAME,created_by,updated_by)

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Update Packed Inventory Result: {result}")
        if status_code != 200:
               logger.debug(f"{USER_ID} --> {MODULE_NAME}: Some issue in the response from update packaed inventory function: {result}")
               return (result),status_code 

        return (result), 200

    except Exception as e:
        # Log error details
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred during inventory update: {str(e)}")
        # Return failure for any other case
        return ('Update failed'), 400
