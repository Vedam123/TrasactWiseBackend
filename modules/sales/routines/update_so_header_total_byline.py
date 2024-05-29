from decimal import Decimal  # Import the Decimal type
from modules.utilities.logger import logger

def update_so_header_total_by_line(USER_ID, MODULE_NAME, mydb, header_id, sum_of_line_total):
    try:
        mycursor = mydb.cursor()
        logger.debug(f"Update SO header with Total - Header ID: {header_id}, Sum of Line Total: {sum_of_line_total}")

        # Retrieve the existing total_amount for the specified header_id
        query = "SELECT total_amount FROM sal.sales_order_headers WHERE header_id = %s"
        mycursor.execute(query, (header_id,))
        current_total_amount = mycursor.fetchone()[0]

        # Calculate the new total_amount
        current_total_amount = Decimal(str(current_total_amount))
        sum_of_line_total = Decimal(str(sum_of_line_total))
        new_total_amount = current_total_amount + sum_of_line_total

        # Update the total_amount in the sales_order_headers table
        update_query = "UPDATE sal.sales_order_headers SET total_amount = %s WHERE header_id = %s"
        mycursor.execute(update_query, (new_total_amount, header_id))

        # Commit the transaction
        mydb.commit()

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Successfully updated total_amount for header_id {header_id}")

        # Return success
        return True

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error updating total_amount - {str(e)}")
        mydb.rollback()
        return False

    finally:
        mycursor.close()
