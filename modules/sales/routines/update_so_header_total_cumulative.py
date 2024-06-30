from decimal import Decimal  # Import the Decimal type
from modules.utilities.logger import logger

def update_so_header_total_cumulative(USER_ID, MODULE_NAME, mydb, header_id, sum_of_line_total):
    try:
        mycursor = mydb.cursor()
        logger.debug(f"Update SO header with Cumulative Total - Header ID: {header_id}, Sum of Line Total: {sum_of_line_total}")

        # Update the total_amount in the sales_order_headers table
        #update_query = "UPDATE sal.sales_order_headers SET total_amount = total_amount + %s WHERE header_id = %s"
        update_query = "UPDATE sal.sales_order_headers SET total_amount = %s WHERE header_id = %s"
        mycursor.execute(update_query, (sum_of_line_total, header_id))

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Successfully updated total_amount for header_id {header_id}")

        # Return success
        return True

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error updating total_amount - {str(e)}")
        return False

    finally:
        mycursor.close()
