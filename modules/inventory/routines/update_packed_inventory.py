from modules.utilities.logger import logger

def update_packed_inventory(input_params, result_params, mydb, USER_ID, MODULE_NAME, created_by, updated_by):
    try:
        logger.info(f"{USER_ID} --> {MODULE_NAME}: Entered update_packed_inventory_for_sales_orders function")

        mycursor = mydb.cursor()
        
        try:
            if result_params['remainder_quantity'] == 0:
                logger.debug(f"{USER_ID} --> {MODULE_NAME}: Remainder quantity is 0")

                update_query = """
                    UPDATE inv.item_inventory
                    SET quantity = %s, uom_id = %s, additional_info = %s, status = 'Yes', updated_by = %s
                    WHERE inventory_id = %s AND transaction_id = %s AND item_id = %s AND transaction_type = %s AND uom_id = %s
                """
                update_params = (
                    result_params['target_quantity'],
                    input_params['input_target_uom_id'],
                    input_params['sales_header_id'],
                    updated_by,
                    input_params['input_inventory_id'],
                    input_params['input_transaction_id'],
                    input_params['input_item_id'],
                    input_params['input_transaction_type'],
                    input_params['input_source_uom_id']
                )
                mycursor.execute(update_query, update_params)
                mydb.commit()
                logger.info(f"{USER_ID} --> {MODULE_NAME}: Update successful for Sales Order ID {input_params['sales_header_id']}")
            else:
                logger.debug(f"{USER_ID} --> {MODULE_NAME}: Remainder quantity > 0")

                update_query = """
                    UPDATE inv.item_inventory
                    SET quantity = %s, additional_info = %s, status = 'Yes', updated_by = %s
                    WHERE inventory_id = %s AND transaction_id = %s AND item_id = %s
                """
                update_params = (
                    result_params['remainder_quantity'],
                    input_params['sales_header_id'],
                    updated_by,
                    input_params['input_inventory_id'],
                    input_params['input_transaction_id'],
                    input_params['input_item_id']
                )
                mycursor.execute(update_query, update_params)

                insert_query = """
                    INSERT INTO inv.item_inventory (transaction_id, item_id, transaction_type, uom_id, quantity, bin_id, rack_id, row_id, aisle_id, zone_id, location_id, warehouse_id, additional_info, created_by, updated_by, status)
                    SELECT transaction_id, item_id, transaction_type, %s AS uom_id, %s AS quantity, bin_id, rack_id, row_id, aisle_id, zone_id, location_id, warehouse_id, %s AS additional_info, %s AS created_by, %s AS updated_by, 'Yes' AS status
                    FROM inv.item_inventory
                    WHERE inventory_id = %s
                """
                insert_params = (
                    input_params['input_target_uom_id'],
                    result_params['target_quantity'],
                    f'Created new pack from Inventory id {input_params["input_inventory_id"]}',
                    created_by,
                    updated_by,
                    input_params['input_inventory_id']
                )
                mycursor.execute(insert_query, insert_params)
                mydb.commit()
                logger.info(f"{USER_ID} --> {MODULE_NAME}: Insert and Update successful for Sales Order ID {input_params['sales_header_id']}")

        except Exception as operation_error:
            mydb.rollback()
            logger.error(f"{USER_ID} --> {MODULE_NAME}: Error during DB operation: {str(operation_error)}")
            return 'Update Operation failed', 400
        
        finally:
            mycursor.close()
        
        return 'Update operation successful', 200

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return 'Update Operation failed', 400
