from modules.utilities.logger import logger
from flask import jsonify
from decimal import Decimal
from modules.sales.routines.log_pick_release import log_pick_release

def update_sales_order_lines_status(execution_id, sales_header_id, sales_order_line_id, full_qty_alloc_status, 
                                    part_qty_alloc_status, total_allocated, shipping_method,shipping_address,sales_item_id,
                                    ship_status,picker_id,pick_status, mydb, current_userid, MODULE_NAME):
    try:
        mycursor = mydb.cursor(dictionary=True)  # Use dictionary cursor to fetch results as dictionaries
        logger.debug(f"Updating Sales Order Line Status and Picked Quantity for Line ID: {sales_order_line_id}")

        # Fetch current picked_quantity and quantity from sales_order_lines table
        select_query = """
            SELECT picked_quantity, quantity, base_uom_id, base_quantity,status
            FROM sal.sales_order_lines
            WHERE header_id = %s and line_id = %s
        """
        mycursor.execute(select_query, (sales_header_id,sales_order_line_id))
        result = mycursor.fetchone()

        if not result:
            logger.error(f"No sales order line found with header id , line id: {sales_header_id} {sales_order_line_id}")
            return f"No Sales Order line found with {sales_header_id} {sales_order_line_id}", 400

        
        picked_quantity = Decimal(result['picked_quantity'] or 0)  # Access elements using string keys
        quantity = Decimal(result['quantity'])
        base_uom_id = int(result['base_uom_id'])
        base_quantity = Decimal(result['base_quantity'])
        current_sales_line_status = result['status']
        total_allocated = Decimal(total_allocated)

        logger.debug(f"Current Picked Quantity: {picked_quantity}, Current Quantity: {quantity}")

        # Calculate new picked_quantity based on allocated quantities
        new_picked_quantity = picked_quantity + total_allocated

        logger.debug(f"New Picked Quantity after allocation: {new_picked_quantity}")
        logger.debug(f"Total Allocated : {total_allocated}")
        logger.debug(f"Sales Lines quantity : {quantity}")
        logger.debug(f"Sales Lines base quantity : {base_quantity}")
        logger.debug(f"Sales Lines base uom id : {base_uom_id}")

        # Update picked_quantity in sales_order_lines table

        logger.debug(f"Before updating sales order lines picked quanity : {new_picked_quantity}")
        update_query = """
            UPDATE sal.sales_order_lines
            SET picked_quantity = %s,
                updated_at = NOW(),
                updated_by = %s
            WHERE line_id = %s
        """
        mycursor.execute(update_query, (new_picked_quantity, current_userid, sales_order_line_id))
        #mydb.commit()

        logger.debug(f"Picked quantity updated successfully for Line ID: {sales_order_line_id}")

        # Determine status based on picked_quantity
        logger.debug(f"Before Assiging the status value to update in sales order lines new picked quanity : {new_picked_quantity}")
        logger.debug(f"Before Assiging the status value to update in sales order lines quantity : {quantity}")
        if round(new_picked_quantity,0) == round(base_quantity,0):
            status = full_qty_alloc_status
        elif new_picked_quantity < base_quantity:
            status = part_qty_alloc_status
        else:
            logger.error(f"Picked quantity exceeds quantity in sales order line: {new_picked_quantity} > {base_quantity}")
            raise Exception("Picked quantity exceeds quantity in sales order line")

        # Update status in sales_order_lines table
        logger.debug(f"Status to update in sales order lines: {status}")
        update_status_query = """
            UPDATE sal.sales_order_lines
            SET status = %s,
                updated_at = NOW(),
                updated_by = %s
            WHERE line_id = %s
        """
        mycursor.execute(update_status_query, (status, current_userid, sales_order_line_id))
        #mydb.commit()

        logger.debug(f"Sales Order Line status updated to: {status} for Line ID: {sales_order_line_id}")

        log_pick_release(execution_id, sales_header_id, sales_order_line_id, current_sales_line_status, 
                     None, new_picked_quantity, pick_status, current_userid, mydb)
              
        response = {
            "message": f"Sales Order line {sales_order_line_id} is updated successfully with the status {status}",
            "status": status  # Optionally return the status itself in the JSON response
        }
        return jsonify(response), 200

    except Exception as e:
        logger.error(f"{current_userid} --> {MODULE_NAME}: Error in updating sales order line status and picked quantity: {str(e)}")
    finally:
        if mycursor:
            mycursor.close()