from modules.products.routines.uom_conversion import uom_conversion
from modules.inventory.routines.pickrelease_update_inv import pickrelease_update_inv
from modules.utilities.logger import logger 

def pickrelease_conversion_inv(sales_order_lines, sales_header_id, mydb, appuser, MODULE_NAME, created_by, updated_by):
    try:
        logger.info(f"{appuser} --> {MODULE_NAME}: Entered pickrelease_conversion_inv function")

        for sales_order_line in sales_order_lines:
            logger.debug(f"{appuser} --> {MODULE_NAME}: Processing Sales Order Line: {sales_order_line}")

            input_params = {
                'sales_order_line_id': sales_order_line['sales_order_line_id'],
                'sales_order_line_number': sales_order_line['sales_order_line_number'],
                'sales_item_id': sales_order_line['sales_item_id'],
                'sales_uom_id': sales_order_line['sales_uom_id'],
                'sales_line_quantity': sales_order_line['sales_line_quantity'],
                'sales_header_id': sales_header_id  # Include sales_header_id
            }

            result, status_code = uom_conversion(input_params['sales_uom_id'], input_params['sales_line_quantity'], mydb, appuser, MODULE_NAME)

            if status_code == 200:
                result_params = {
                    'target_quantity': result['target_quantity'],
                    'remainder_quantity': result['remainder_quantity']
                }
            else:
                logger.debug(f"{appuser} --> {MODULE_NAME}: Issue in conversion: {result}")
                return f'Issue in conversion for Sales Order Line ID {input_params["sales_order_line_id"]}', status_code

            logger.debug(f"{appuser} --> {MODULE_NAME}: UOM Conversion Result: {result_params}")
            result, status_code = pickrelease_update_inv(input_params, result_params, mydb, appuser, MODULE_NAME, created_by, updated_by)

            if status_code != 200:
                logger.debug(f"{appuser} --> {MODULE_NAME}: Issue in updating inventory: {result}")
                return f'Update failed for Sales Order Line ID {input_params["sales_order_line_id"]}', status_code

        return 'All Sales Order Lines processed successfully', 200

    except Exception as e:
        logger.error(f"{appuser} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return 'Processing failed', 400
