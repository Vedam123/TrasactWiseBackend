from flask import jsonify
from modules.utilities.logger import logger  # Ensure the logger is properly configured and accessible

def pickrelease_update_inv(input_params, result_params, mydb, appuser, MODULE_NAME, created_by, updated_by):
    try:
        # Log entry point
        logger.info(f"{appuser} --> {MODULE_NAME}: Entered pickrelease_update_inv function")

        # Begin the transaction
        
        if result_params['remainder_quantity'] == 0:
            logger.debug(f"{appuser} --> {MODULE_NAME}: Remainder quantity is 0: {result_params['remainder_quantity']}")

            update_query = """
                UPDATE inv.item_inventory
                SET quantity = %s, uom_id = %s, additional_info = CONCAT(additional_info, %s), updated_by = %s, status = 'Yes', subject = %s
                WHERE inventory_id = %s AND transaction_id = %s AND item_id = %s AND transaction_type = %s AND uom_id = %s
            """
            update_params = (
                result_params['target_quantity'],
                input_params['input_target_uom_id'],
                "Packed",
                updated_by,
                input_params['sales_header_id'],
                input_params['input_inventory_id'],
                input_params['input_transaction_id'],
                input_params['input_item_id'],
                input_params['input_transaction_type'],
                input_params['input_source_uom_id']
            )
            mycursor = mydb.cursor()

            try:
                mycursor.execute(update_query, update_params)
                # No need to commit here, as we're still within the transaction
                # Log success for update
                mydb.commit()
                logger.info(f"{appuser} --> {MODULE_NAME}: Update successful")
            except Exception as update_error:
                # Rollback the transaction in case of failure
                mydb.rollback()
                # Log error details for update
                logger.error(f"{appuser} --> {MODULE_NAME}: Error during update operation: {str(update_error)}")
                return 'Update Operation failed', 400
            
            finally:
                mycursor.close()

            return 'Update Operation Successful', 200
        else:
            logger.debug(f"{appuser} --> {MODULE_NAME}: Remainder quantity is greater than 0: {result_params['remainder_quantity']}")

            update_query = """
                UPDATE inv.item_inventory
                SET quantity = %s, additional_info = CONCAT(additional_info, %s), updated_by = %s
                WHERE inventory_id = %s AND transaction_id = %s AND item_id = %s
            """
            update_params = (
                result_params['remainder_quantity'],
                "Split for Pick Release",
                updated_by,     
                input_params['input_inventory_id'],
                input_params['input_transaction_id'],
                input_params['input_item_id']
            )
            mycursor = mydb.cursor()

            try:
                mycursor.execute(update_query, update_params)
                packed = 'Created new pack from Inventory id ' + str(input_params['input_inventory_id'])
                insert_query = """
                    INSERT INTO inv.item_inventory (transaction_id, item_id, 
                    transaction_type, uom_id, quantity, bin_id, rack_id, row_id,
                    aisle_id, zone_id, location_id, warehouse_id, additional_info, created_by, updated_by, status, subject)
                    SELECT 
                        transaction_id,
                        item_id,
                        transaction_type,
                        %s AS uom_id,
                        %s AS quantity,
                        bin_id,
                        rack_id,
                        row_id,
                        aisle_id,
                        zone_id,
                        location_id,
                        warehouse_id,
                        CONCAT(additional_info, %s) AS additional_info,
                        %s AS created_by,
                        %s AS updated_by,
                        'Yes' AS status,
                        %s AS subject
                    FROM inv.item_inventory
                    WHERE inventory_id = %s
                """
                insert_params = (
                    input_params['input_target_uom_id'],                    
                    result_params['target_quantity'],
                    packed,
                    created_by,
                    updated_by,
                    input_params['sales_header_id'],
                    input_params['input_inventory_id'],
                )

                mycursor.execute(insert_query, insert_params)
                # Commit the transaction after successful insert and update
                mydb.commit()
                # Log success for both insert and update
                logger.info(f"{appuser} --> {MODULE_NAME}: Insert and Update successful")
            except Exception as operation_error:
                # Rollback the transaction in case of failure
                mydb.rollback()
                # Log error details for either update or insert
                logger.error(f"{appuser} --> {MODULE_NAME}: Error during database operation: {str(operation_error)}")
                return 'Update Operation failed', 400 

            finally:
                mycursor.close()
    except Exception as e:
        # Log error details
        logger.error(f"{appuser} --> {MODULE_NAME}: An error occurred during inventory update: {str(e)}")
        # Return failure for any other case
        return 'Update Operation failed', 400 

    # Return success if the function reaches this point
    return 'Update operation is successful', 200 

