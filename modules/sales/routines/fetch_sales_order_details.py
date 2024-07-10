
from modules.utilities.logger import logger  # Import your logger module

def fetch_sales_order_details(USER_ID, MODULE_NAME, mydb, header_id):
    try:
        mycursor = mydb.cursor(dictionary=True)  # Use dictionary cursor to fetch results as dictionaries
        logger.debug(f"Fetching shipping details for sales order with Header ID: {header_id}")

        # Query to fetch specific fields based on header_id
        query = "SELECT shipping_method, shipping_address FROM sal.sales_order_headers WHERE header_id = %s"
        mycursor.execute(query, (header_id,))
        result = mycursor.fetchone()

        if result:
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: Successfully fetched shipping details for Header ID {header_id}")

            # Return specific fields
            return result
        else:
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: No details found for Header ID {header_id}")
            return None

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error fetching shipping details for Header ID {header_id} - {str(e)}")
        return None

    finally:
        mycursor.close()
