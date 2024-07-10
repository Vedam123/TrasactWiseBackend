from modules.utilities.logger import logger


def find_lowest_uom_and_cf(uom_id, mydb, current_userid, MODULE_NAME):
    try:
        mycursor = mydb.cursor(dictionary=True)
        logger.debug(f"{current_userid} --> {MODULE_NAME}: Starting find_lowest_uom_and_cf for uom_id: {uom_id}")
        
        def find_conversion_factor_and_base_unit(uom_id, mycursor):
            conversion_factor = 1.0
            visited = set()
            base_unit = None

            while uom_id and uom_id not in visited:
                visited.add(uom_id)
                query = """
                    SELECT uom_id, conversion_factor, base_unit 
                    FROM com.uom 
                    WHERE uom_id = %s
                """
                mycursor.execute(query, (uom_id,))
                result = mycursor.fetchone()
                
                if not result:
                    return None, None

                uom_id, factor, base_unit = result['uom_id'], result['conversion_factor'], result['base_unit']
                conversion_factor *= factor

                logger.debug(f"{current_userid} --> {MODULE_NAME}: UOM ID: {uom_id}, Conversion Factor: {conversion_factor}, Base Unit: {base_unit}")

                if uom_id == base_unit:
                    return conversion_factor, base_unit

                uom_id = base_unit

            return conversion_factor, base_unit

        conversion_factor, base_unit = find_conversion_factor_and_base_unit(uom_id, mycursor)

        # Navigate to the lowest unit in the hierarchy
       # while base_unit:
        #    query = """
         #       SELECT uom_id, base_unit
         #       FROM com.uom
        #        WHERE uom_id = %s
        #    """
        #    mycursor.execute(query, (base_unit,))
        #    result = mycursor.fetchone()

        #    if not result:
        #        break

        #    base_unit = result['base_unit']
        #    if base_unit == uom_id:
        #        break

        logger.debug(f"{current_userid} --> {MODULE_NAME}: Found Lowest Base Unit: {base_unit}, Final Conversion Factor: {conversion_factor}")

        return {'base_unit': base_unit, 'conversion_factor': conversion_factor}

    except Exception as e:
        logger.error(f"{current_userid} --> {MODULE_NAME}: Error in find_lowest_uom_and_cf: {str(e)}")
        return None

    finally:
        if mycursor:
            mycursor.close()
            logger.debug(f"{current_userid} --> {MODULE_NAME}: Closed database cursor")

# Example usage for uom_id 11 (Dozen2)
# result = find_lowest_uom_and_cf(11, mydb, current_userid, MODULE_NAME)
# if result:
#     print(f"Base Unit: {result['base_unit']}, Conversion Factor: {result['conversion_factor']}")
# else:
#     print("No valid conversion factor or base unit found.")
