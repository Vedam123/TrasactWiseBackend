from flask import jsonify
from modules.utilities.logger import logger  # Ensure the logger is properly configured and accessible

def fetch_uom_data_by_id(mydb, uom_id, USER_ID, MODULE_NAME):
    try:
        query = "SELECT uom_id, uom_name, abbreviation, conversion_factor, base_unit FROM com.uom WHERE uom_id = %s"
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Executing query: %s", query)
        
        mycursor = mydb.cursor()
        mycursor.execute(query, (uom_id,))
        row = mycursor.fetchone()
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Fetched row: %s", row)
        mycursor.close()

        if row:
            return {
                'uom_id': row[0],
                'uom_name': row[1],
                'abbreviation': row[2],
                'conversion_factor': row[3],
                'base_unit': row[4]
            }
        else:
            logger.warning(f"{USER_ID} --> {MODULE_NAME}: UOM not found.")
            return None

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error fetching UOM data: %s", e)
        return None

def uom_conversion(source_uom_id, source_quantity, target_uom_id, mydb, USER_ID, MODULE_NAME):
    try:
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: source_uom_id: {source_uom_id}, source_quantity: {source_quantity}, target_uom_id: {target_uom_id}")

        # Fetch conversion factor and base unit for source UOM
        source_uom_data = fetch_uom_data_by_id(mydb, source_uom_id, USER_ID, MODULE_NAME)

        if source_uom_data:
            # Access individual values
            source_uom_name = source_uom_data['uom_name']
            source_abbreviation = source_uom_data['abbreviation']
            source_conversion_factor = source_uom_data['conversion_factor']
            source_base_unit = source_uom_data['base_unit']

            # Now you can use these values as needed
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: Source UOM Name: {source_uom_name}")
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: Source Abbreviation: {source_abbreviation}")
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: Source Conversion Factor: {source_conversion_factor}")
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: Source Base Unit: {source_base_unit}")

        target_uom_data = fetch_uom_data_by_id(mydb, target_uom_id, USER_ID, MODULE_NAME)

        if target_uom_data:
            # Access individual values
            target_uom_name = target_uom_data['uom_name']
            target_abbreviation = target_uom_data['abbreviation']
            target_conversion_factor = target_uom_data['conversion_factor']
            target_base_unit = target_uom_data['base_unit']

            # Now you can use these values as needed
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: Target UOM Name: {target_uom_name}")
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: Target Abbreviation: {target_abbreviation}")
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: Target Conversion Factor: {target_conversion_factor}")
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: Target Base Unit: {target_base_unit}")

            # Calculate converted_quantity and remainder based on scenarios
            if source_uom_id == target_uom_id:
                converted_quantity = source_quantity
                remainder = 0
            elif source_base_unit == target_uom_id:
                converted_quantity = source_quantity * source_conversion_factor
                remainder = 0
            elif target_base_unit == source_uom_id and source_quantity >= target_conversion_factor:
                quotient = source_quantity // target_conversion_factor
                converted_quantity = quotient
                remainder = source_quantity % target_conversion_factor
            else:
                logger.debug("Debug: Conversion not possible, invalid scenario")
                return {'message': 'Conversion not possible, invalid scenario'}, 422 

            logger.debug("Debug: Conversion successful")
            return {
                'source_uom_id': source_uom_id,
                'source_uom_name': source_uom_name,
                'source_abbreviation': source_abbreviation,
                'source_quantity': source_quantity,
                'source_conversion_factor': source_conversion_factor,
                'target_uom_id': target_uom_id,
                'target_uom_name': target_uom_name,
                'target_abbreviation': target_abbreviation,
                'target_conversion_factor': target_conversion_factor,
                'target_quantity': converted_quantity,
                'remainder_quantity': remainder
            }, 200
    except Exception as e:
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return {'error': str(e)}, 400

# Add logger.info statements for debugging
logger.info("Debug: Conversion API Blueprint registered")
