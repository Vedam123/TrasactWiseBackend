from modules.sales.routines.fetch_sales_line_details import fetch_sales_line_details
from modules.utilities.logger import logger  # Import your logger module

def log_pick_release(execution_id, sales_header_id, sales_order_line_id, sales_line_prev_status, 
                     inventory_id, picked_quantity, created_by, mydb):
    try:
        # Fetch necessary data using fetch_sales_line_details function
        sales_order_line_data, status_code = fetch_sales_line_details(sales_header_id, sales_order_line_id, mydb)
        
        if status_code != 200 or not sales_order_line_data:
            # Handle the case where sales order line data could not be fetched
            logger.error(f"Failed to fetch sales order line data for header_id: {sales_header_id}, line_id: {sales_order_line_id}")
            return
        
        mycursor = mydb.cursor()

        # Prepare the INSERT query
        query = """
            INSERT INTO sal.pick_release_log (
                execution_id, sales_header_id, sales_order_line_id, sales_item_id, sales_uom_id, 
                sales_uom_id_quantity, sales_base_uom_id, sales_base_uom_quantity, 
                already_picked_quantity, sales_line_status, sales_line_new_status, inventory_id, 
                picked_quantity, pick_release_status, created_by
            ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        
        # Define the values to insert
        values = (
            execution_id, sales_header_id, sales_order_line_id, sales_order_line_data.get('item_id'), sales_order_line_data.get('uom_id'), 
            sales_order_line_data.get('quantity'), sales_order_line_data.get('base_uom_id'), sales_order_line_data.get('base_quantity'), 
            sales_order_line_data.get('picked_quantity'),sales_line_prev_status, sales_order_line_data.get('status'),  inventory_id, 
            picked_quantity, 'RELEASED', created_by
        )

        # Execute the query
        mycursor.execute(query, values)
        mydb.commit()  # Commit the transaction after execution

        # Log success
        logger.info(f"Pick release process logged for execution_id: {execution_id}, sales_order_line_id: {sales_order_line_id}")

    except Exception as e:
        # Log error
        logger.error(f"Error logging pick release process: {str(e)}")
        raise e