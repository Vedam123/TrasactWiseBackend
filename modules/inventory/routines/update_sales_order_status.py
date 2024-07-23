from modules.utilities.logger import logger
from flask import jsonify

def update_sales_order_status(sales_header_id, full_qty_alloc_status, part_qty_alloc_status, mydb, current_userid, MODULE_NAME):
    try:
        logger.debug(f"Updating Sales Order Status for Header ID: {sales_header_id}")
        query = """
        SELECT status
        FROM sal.sales_order_lines
        WHERE header_id = %s;
        """
        mycursor = mydb.cursor()
        mycursor.execute(query, (sales_header_id,))
        sales_line_statuses = mycursor.fetchall()

        new_status = None

        logger.debug(f"{current_userid} --> {MODULE_NAME}:Sales Line Statuses: {sales_line_statuses}")

        if all(status[0] == full_qty_alloc_status for status in sales_line_statuses):
            new_status = full_qty_alloc_status
        elif any(status[0] == full_qty_alloc_status for status in sales_line_statuses):
            new_status = part_qty_alloc_status
        elif any(status[0] == part_qty_alloc_status for status in sales_line_statuses):
            new_status = part_qty_alloc_status
        else:
            new_status = None  # Default if no statuses match

        logger.debug(f"New Status for Sales Header ID {sales_header_id}: {new_status}")

        if new_status is not None:  # Execute update only if new_status is not None
            update_query = """
            UPDATE sal.sales_order_headers
            SET status = %s, updated_by = %s, updated_at = CURRENT_TIMESTAMP
            WHERE header_id = %s;
            """
            mycursor.execute(update_query, (new_status, current_userid, sales_header_id))
            mydb.commit()
            logger.debug(f"Updated Sales Order Header ID {sales_header_id} with Status {new_status}")
            return jsonify(message='Process completed Sales Order, Lines statuses are updated and available inventory allocated'), 200
        else:
            logger.debug(f"No status update needed for Sales Header ID {sales_header_id} as new_status is None")
            return jsonify(message='Process completed Some of the Sales Order headers are not processed'), 200

    except Exception as e:
        logger.error(f"Error occurred during sales order status update: {str(e)}")
        return jsonify(message='Process completed With Error '), 500
    finally:
        mycursor.close()