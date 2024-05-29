from decimal import Decimal  # Import the Decimal type
from modules.utilities.logger import logger

def update_po_header_total_cumulative(USER_ID, MODULE_NAME, mydb, header_id, sum_of_line_total):
    try:
        mycursor = mydb.cursor()
        sum_of_line_total = Decimal(str(sum_of_line_total))
        # Update the total_amount in the purchase_order_header table
        update_query = "UPDATE pur.purchase_order_header SET total_amount = %s WHERE header_id = %s"
        mycursor.execute(update_query, (sum_of_line_total, header_id))

        logger.debug(
            f"{USER_ID} --> {MODULE_NAME}: Successfully updated total_amount for header_id {header_id}")

        # Return success
        return True

    except Exception as e:
        logger.error(
            f"{USER_ID} --> {MODULE_NAME}: Error updating total_amount - {str(e)}")
        #mydb.rollback()
        return False

    finally:
        mycursor.close()
