import mysql.connector
from modules.utilities.logger import logger  # Ensure the logger is properly configured and accessible

def find_base_unit_uom_id(uom_id1, uom_id2, mydb, USER_ID, MODULE_NAME, return_value):
    try:
        logger.info(f"{USER_ID} --> {MODULE_NAME}: Comparing base_units for uom_id1={uom_id1} and uom_id2={uom_id2}")

        mycursor = mydb.cursor(dictionary=True)

        # Query to get base_unit for uom_id1
        query1 = "SELECT base_unit FROM uom WHERE uom_id = %s"
        mycursor.execute(query1, (uom_id1,))
        result1 = mycursor.fetchone()
        base_unit1 = result1['base_unit'] if result1 and result1['base_unit'] is not None else -1

        # Query to get base_unit for uom_id2
        query2 = "SELECT base_unit FROM uom WHERE uom_id = %s"
        mycursor.execute(query2, (uom_id2,))
        result2 = mycursor.fetchone()
        base_unit2 = result2['base_unit'] if result2 and result2['base_unit'] is not None else -1

        # Compare base_unit values
        if base_unit1 > base_unit2:
            logger.info(f"{USER_ID} --> {MODULE_NAME}: Base_unit for uom_id2={uom_id2} is chosen")
            return uom_id2, return_value
        else:
            logger.info(f"{USER_ID} --> {MODULE_NAME}: Base_unit for uom_id1={uom_id1} is chosen")
            return uom_id1, return_value

    except mysql.connector.Error as err:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: MySQL Error: {err}")
        return None, 'Error occurred in database operation'
    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error occurred: {str(e)}")
        return None, 'Unexpected error occurred'
    finally:
        if mycursor:
            mycursor.close()

# Example usage assuming you have a database connection `mydb` already established
# Replace `uom_id1` and `uom_id2` with actual IDs you want to compare
# Replace `USER_ID` and `MODULE_NAME` with actual values
# result_id, result_msg = compare_uom_base_units(uom_id1, uom_id2, mydb, USER_ID, MODULE_NAME, 'Comparison successful')
# print("Resulting uom_id:", result_id)
# print("Result message:", result_msg)
