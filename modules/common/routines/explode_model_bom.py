from modules.utilities.logger import logger  # Import the logger module

def explode_bom_internal(mycursor, model_item, revision, required_quantity,appuser, module_file):
    """
    Function to generate the exploded BOM based on the provided model_item, required_quantity, and revision.
    """

    logger.debug(f"{appuser} --> {module_file}: Entered in the  explode_bom_internal function for {model_item}, Revision: {revision} -> quantity {required_quantity}")
    results = []
    queue = [(model_item, revision, 1)]  # Start with the root item in the queue
    
    while queue:
        current_item, current_revision, current_level = queue.pop(0)
        
        # SQL query to fetch the components from the BOM table for the given model_item and revision
        query = f"""
            SELECT ComponentItem, Quantity, uom, level
            FROM com.bom
            WHERE ModelItem = {current_item} AND Revision = '{current_revision}'
        """
        mycursor.execute(query)
        result = mycursor.fetchall()
        
        # Process each row in the result set
        if result:
            for row in result:
                sub_component_item, quantity, uom, level = row
                fetched_qty = quantity
                quantity = float(quantity) * required_quantity  # Calculate required quantity
                results.append({
                    'Item': sub_component_item,
                    "Quantity": fetched_qty,
                    "Model": current_item,
                    'Required Qty for Model': quantity,
                    'UOM': uom,
                    'Level': level
                })
            queue.append((sub_component_item, current_revision, current_level + 1))

    return results

def get_exploded_bom_data(model_item, required_quantity, mydb,appuser,module_file):
    """
    This function retrieves the exploded BOM for a given model_item and required_quantity, 
    without Flask-specific request/response or authorization logic.
    """
    try:
        logger.debug(f": {model_item}")

        logger.debug(f"{appuser} --> {module_file}: Entered into get_exploded_bom_data function for Model Item: {model_item}")
        logger.debug(f"{appuser} --> {module_file}: Entered into get_exploded_bom_data function for the quantity: {required_quantity}")

        # Start a cursor to execute the SQL queries
        mycursor = mydb.cursor()

        # Check if the BOM exists for the given model_item and revision "A"
        revision = "A"
        check_query = f"SELECT COUNT(*) FROM com.bom WHERE ModelItem = {model_item} AND Revision = '{revision}'"
        mycursor.execute(check_query)
        count = mycursor.fetchone()[0]
        logger.debug(f"{appuser} --> {module_file}: Checking BOM count for Model Item: {model_item}, Revision: {revision} -> {count}")
        
        if count == 0:
            mycursor.close()
            logger.debug(f"No BOM defined for this item and revision {model_item}, {revision}")
            return {'message': 'No BOM defined for this item and revision'}
        
        logger.debug(f"{appuser} --> {module_file}: Calling the explode_bom_internal function for {model_item}, Revision: {revision} -> quantity {required_quantity}")

        # Get the exploded BOM data using the 'explode_bom' function
        exploded_bom = explode_bom_internal(mycursor, model_item, revision, required_quantity,appuser,module_file)

        logger.debug(f"{appuser} --> {module_file}: The response from  the explode_bom_internal function for {model_item}, Revision: {revision} -> is  {exploded_bom}")

        # Close the cursor
        mycursor.close()

        # Return the exploded BOM data
        logger.debug(f"Successfully retrieved exploded BOM data for Model Item: {model_item}")
        return {'exploded_bom': exploded_bom}

    except Exception as e:
        logger.error(f"Error while retrieving exploded BOM for Model Item {model_item}: {str(e)}")
        return {'error': str(e)}
