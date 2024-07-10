from modules.utilities.logger import logger  # Ensure the logger is properly configured and accessible

def get_conversion_factor(inv_uom_id, sales_base_uom_id, mydb, current_userid, MODULE_NAME):
    try:
        logger.debug(f"Parameter value for inv_uom_id: {inv_uom_id}")
        logger.debug(f"Parameter value for sales_base_uom_id: {sales_base_uom_id}")

        def find_conversion_factor_and_base_unit(uom_id, mycursor):
            conversion_factor = 1.0
            visited = set()
            base_unit = None
            lowest_base_unit = None
            lowest_conversion_factor = 1.0

            while uom_id and uom_id not in visited:
                visited.add(uom_id)
                query = """
                    SELECT uom_id, conversion_factor, base_unit 
                    FROM com.uom 
                    WHERE uom_id = %s
                """
                logger.debug(f"Executing Query: {query} with UOM ID: {uom_id}")
                mycursor.execute(query, (uom_id,))
                result = mycursor.fetchone()
                logger.debug(f"Fetched UOM Data: {result}")
                
                if not result:
                    return None, None, None, None

                uom_id, factor, base_unit = result['uom_id'], result['conversion_factor'], result['base_unit']
                conversion_factor *= factor

                logger.debug(f"Conversion Factor: {conversion_factor}")

                if lowest_base_unit is None or base_unit == uom_id:
                    lowest_base_unit = base_unit
                    lowest_conversion_factor = conversion_factor

                if uom_id == base_unit:
                    break

                uom_id = base_unit

            logger.debug(f"Final Conversion Factor: {conversion_factor}, Base Unit: {base_unit}")
            return conversion_factor, base_unit, lowest_base_unit, lowest_conversion_factor

        mycursor = mydb.cursor(dictionary=True)

        # Find conversion factors and base units for both inv_uom_id and sales_base_uom_id
        inv_to_base_factor, inv_base_unit, inv_lowest_base_unit, inv_lowest_conversion_factor = find_conversion_factor_and_base_unit(inv_uom_id, mycursor)
        sales_to_base_factor, sales_base_unit, sales_lowest_base_unit, sales_lowest_conversion_factor = find_conversion_factor_and_base_unit(sales_base_uom_id, mycursor)
        
        logger.debug(f"Conversion Factor for inv_uom_id: {inv_to_base_factor}, Base Unit: {inv_base_unit}, Lowest Base Unit: {inv_lowest_base_unit}, Lowest Conversion Factor: {inv_lowest_conversion_factor}")
        logger.debug(f"Conversion Factor for sales_base_uom_id: {sales_to_base_factor}, Base Unit: {sales_base_unit}, Lowest Base Unit: {sales_lowest_base_unit}, Lowest Conversion Factor: {sales_lowest_conversion_factor}")

        # If either conversion factor or base unit is None, return None
        if inv_to_base_factor is None or sales_to_base_factor is None or inv_base_unit != sales_base_unit:
            logger.debug("Conversion factors or base units are not valid or do not match.")
            return None

        # Compute the final conversion factor
        conversion_factor = inv_to_base_factor / sales_to_base_factor
        logger.debug(f"FINAL CONVERSION FACTOR --> Computed Conversion Factor: {conversion_factor}")
        return {
            'conversion_factor': conversion_factor,
            'lowest_base_unit': inv_lowest_base_unit,
            'lowest_conversion_factor': inv_lowest_conversion_factor
        }

    except Exception as e:
        logger.error(f"{current_userid} --> {MODULE_NAME}: Error in fetching conversion factor: {str(e)}")
        return None

    finally:
        if mycursor:
            mycursor.close()
