from flask import jsonify
from modules.utilities.logger import logger

def move_inventory(input_params):
    try:
        appuser = input_params.get('appuser', '')
        MODULE_NAME = input_params.get('MODULE_NAME', '')
        logger.info(f"{appuser} --> {MODULE_NAME}: Entered move_inventory function")

        # Extracting necessary variables
        source_item_id = input_params.get('source_item_id', '')
        source_uom_id = input_params.get('source_uom_id', '')
        source_inventory_id = input_params.get('source_inventory_id', '')
        source_quantity = input_params.get('source_quantity', 0)
        target_quantity = input_params.get('target_quantity', 0)
        source_transaction_id = input_params.get('source_transaction_id', '')
        source_transaction_type = input_params.get('source_transaction_type', '')
        source_status = input_params.get('source_status', '')
        source_subject = input_params.get('source_subject', '')
        # source_bin_id = input_params.get('source_bin_id', None)
        # source_rack_id = input_params.get('source_rack_id', None)
        # source_row_id = input_params.get('source_row_id', None)
        # source_aisle_id = input_params.get('source_aisle_id', None)
        # source_zone_id = input_params.get('source_zone_id', None)
        # source_location_id = input_params.get('source_location_id', None)
        # source_warehouse_id = input_params.get('source_warehouse_id', None)
        target_bin_id = input_params.get('target_bin_id', None)
        target_rack_id = input_params.get('target_rack_id', None)
        target_row_id = input_params.get('target_row_id', None)
        target_aisle_id = input_params.get('target_aisle_id', None)
        target_zone_id = input_params.get('target_zone_id', None)
        target_location_id = input_params.get('target_location_id', None)
        target_warehouse_id = input_params.get('target_warehouse_id', None)
        source_additional_info = input_params.get('source_additional_info', '')

        # Validate source_quantity against target_quantity
        if source_quantity < target_quantity:
            logger.error(f"{appuser} --> {MODULE_NAME}: Not possible to Move More quantity than what is available in the warehouse")
            return 'Not possible to Move More quantity than what is available in the warehouse', 400

        logger.info(f"{appuser} --> {MODULE_NAME}: Source quantity is greater than target quantity so it is fine to proceed")
        #input_params_tuple = (
        #    source_item_id, source_uom_id, source_transaction_id,
        #    target_bin_id, target_rack_id, target_row_id,
        #    target_aisle_id, target_zone_id, target_location_id
        #)

        input_params_tuple = (
            source_item_id, source_uom_id, source_transaction_id
        )

        existing_record_query = """
            SELECT *
            FROM inv.item_inventory
            WHERE
                item_id = %s
                AND uom_id = %s
                AND transaction_id = %s
                {0}  -- Dynamic conditions placeholder
        """

        # List of optional parameters and their corresponding database columns
        optional_params = [
            ('bin_id', target_bin_id),
            ('rack_id', target_rack_id),
            ('row_id', target_row_id),
            ('aisle_id', target_aisle_id),
            ('zone_id', target_zone_id),
            ('location_id', target_location_id),
        ]

        # Build the dynamic conditions
        dynamic_conditions = []
        dynamic_values = []  # Create a list to store values for dynamic conditions

        for param, value in optional_params:
            if value is not None:
                dynamic_conditions.append(f"AND {param} = %s")
                dynamic_values.append(value)  # Add the value to the list
            else:
                dynamic_conditions.append(f"AND {param} IS NULL")

        # If there are dynamic conditions, add them to the query
        if dynamic_conditions:
            dynamic_conditions_clause = " ".join(dynamic_conditions)
            existing_record_query = existing_record_query.format(dynamic_conditions_clause)

        logger.info(f"{appuser} --> {MODULE_NAME}: Find data with the parameters {input_params_tuple}")

        # with input_params['mydb'].cursor() as mycursor:
        #    print("Entered with condition")
        #    mycursor.execute(existing_record_query, input_params_tuple)

        with input_params['mydb'].cursor() as mycursor:
            # Add values for dynamic conditions to the input_params_tuple
            input_params_tuple += tuple(dynamic_values)
            mycursor.execute(existing_record_query, input_params_tuple)
            existing_record = mycursor.fetchone()
            result_set = mycursor.fetchall()
            logger.info(f"{appuser} --> {MODULE_NAME}: Is there more than one record present ?  {result_set}")
            logger.info(f"{appuser} --> {MODULE_NAME}: Fetch only the first one   {existing_record}")

            try:
                if existing_record:
                    logger.info(
                        f"{appuser} --> {MODULE_NAME}: As an existing record is found entered If condition with the data    {existing_record[0]}")
                    update_query = (
                        "UPDATE inv.item_inventory "
                        "SET quantity = quantity + %s, updated_by = %s "
                        "WHERE inventory_id = %s"
                    )
                    update_params = (target_quantity, input_params['updated_by'], existing_record[0])
                    mycursor.execute(update_query, update_params)
                    logger.info(
                        f"{appuser} --> {MODULE_NAME}: Quantity is added to the existing record   {update_params}")
                else:
                    logger.info(
                        f"{appuser} --> {MODULE_NAME}: New Record is going to be created as there is no existing record  ")
                    insert_query = (
                        "INSERT INTO inv.item_inventory "
                        "(transaction_id, transaction_type, item_id, uom_id, quantity, additional_info, "
                        "bin_id, rack_id, row_id, aisle_id, zone_id, location_id, warehouse_id, status, subject,created_by, updated_by) "
                        "VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s,%s,%s)"
                    )
                    insert_params = (
                        source_transaction_id, source_transaction_type, source_item_id, source_uom_id, target_quantity,
                        source_additional_info,
                        target_bin_id, target_rack_id, target_row_id, target_aisle_id, target_zone_id, target_location_id,
                        target_warehouse_id,source_status, source_subject,
                        input_params['created_by'], input_params['updated_by']
                    )
                    mycursor.execute(insert_query, insert_params)
                    logger.info(
                        f"{appuser} --> {MODULE_NAME}: Insert is done with the parameters ?  {insert_params}")
                if source_quantity == target_quantity:
                    logger.info(
                        f"{appuser} --> {MODULE_NAME}: Both source and target quantities are the same delete the source inventory_id  {source_inventory_id}")
                    delete_query = "DELETE FROM inv.item_inventory WHERE inventory_id = %s"
                    mycursor.execute(delete_query, (source_inventory_id,))
                    logger.info(
                        f"{appuser} --> {MODULE_NAME}: Data deleted for the source inventory id  {source_inventory_id}")
                elif source_quantity > target_quantity:
                    logger.info(
                        f"{appuser} --> {MODULE_NAME}: source quantity {source_quantity} is more than target quantity {target_quantity} so update the source Inventory id  {source_inventory_id}")
                    update_query = (
                        "UPDATE inv.item_inventory "
                        "SET quantity = quantity - %s, updated_by = %s "
                        "WHERE inventory_id = %s"
                    )
                    update_params = (target_quantity, input_params['updated_by'], source_inventory_id)
                    mycursor.execute(update_query, update_params)
                    logger.info(
                        f"{appuser} --> {MODULE_NAME}: quantity is updated for the inventory id  {source_inventory_id}")
                # Commit the changes
                input_params['mydb'].commit()

                logger.info(f"{appuser} --> {MODULE_NAME}: Inventory moved successfully")
                return 'Inventory moved successfully', 200
            except Exception as e:
                logger.error(
                    f"{appuser} --> {MODULE_NAME}: Database operation failed: {str(e)}")
                return 'Failed to move inventory. Database operation failed.', 500

    except Exception as e:
        logger.error(
            f"{appuser} --> {MODULE_NAME}: An error occurred during inventory movement: {str(e)}")
        return 'Failed to move inventory', 500
