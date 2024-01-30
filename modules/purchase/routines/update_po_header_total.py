from decimal import Decimal  # Import the Decimal type
from modules.utilities.logger import logger

def update_po_header_total(USER_ID, MODULE_NAME, mydb, header_id, sum_of_line_total):
    try:
        mycursor = mydb.cursor()
        print("Update PO header with Total", header_id, sum_of_line_total)
        # Retrieve the existing total_amount for the specified header_id
        query = "SELECT total_amount FROM pur.purchase_order_header WHERE header_id = %s"
        mycursor.execute(query, (header_id,))
        current_total_amount = mycursor.fetchone()[0]

        # Calculate the new total_amount

        current_total_amount = Decimal(str(current_total_amount))
        sum_of_line_total = Decimal(str(sum_of_line_total))
                                    
        new_total_amount = current_total_amount + sum_of_line_total

        # Update the total_amount in the purchase_order_header table
        update_query = "UPDATE pur.purchase_order_header SET total_amount = %s WHERE header_id = %s"
        mycursor.execute(update_query, (new_total_amount, header_id))

        # Commit the transaction
        ##mydb.commit()

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
