
from modules.utilities.logger import logger  # Import your logger module

def fetch_sales_line_details(header_id, line_id, mydb):
    try:
        logger.debug(f"Fetching sales order line for Header ID: {header_id}, Line ID: {line_id}")
        
        query = """
        SELECT line_id, header_id, so_lnum, item_id, quantity, unit_price, line_total, 
               uom_id, notes, status, discount_id, promotion_id, base_uom_id, base_quantity, 
               picked_quantity, uom_conversion_factor, created_at, updated_at, created_by, updated_by
        FROM sal.sales_order_lines
        WHERE header_id = %s AND line_id = %s;
        """
        
        mycursor = mydb.cursor(dictionary=True)
        mycursor.execute(query, (header_id, line_id))
        sales_order_line = mycursor.fetchone()
        
        if sales_order_line:
            logger.debug(f"Sales Order Line Data: {sales_order_line}")
            return sales_order_line, 200  # Return the data and status code 200 for success
        else:
            logger.debug(f"No sales order line found for Header ID: {header_id}, Line ID: {line_id}")
            return None, 404  # Return None and status code 404 if no data found

    except Exception as e:
        logger.error(f"Error occurred while fetching sales order line: {str(e)}")
        return None, 500  # Return None and status code 500 for any exceptions

    finally:
        mycursor.close()