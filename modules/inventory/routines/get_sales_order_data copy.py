from modules.utilities.logger import logger
from flask import jsonify

def get_sales_order_data(sales_orders, sales_order_status, mydb, current_userid, MODULE_NAME):
    """
    Fetches sales order data from the database based on the provided sales orders and status.
    
    Parameters:
    - sales_orders (list or None): List of sales order IDs or None to fetch all orders.
    - sales_order_status (str): The status of the sales orders to be retrieved.
    - mydb: Database connection object.
    - current_userid (str): ID of the current user (contextual use).
    - MODULE_NAME (str): The module name (contextual use).
    
    Returns:
    - dict: The formatted sales order data.
    """
    # Create a cursor object using the provided database connection
    cursor = mydb.cursor()

    logger.debug(f"{current_userid} --> {MODULE_NAME}: New cursor initiated to fetch input data: {sales_orders}")

    # Prepare SQL queries based on the presence of sales_orders
    if sales_orders:
        # If sales_orders are provided, create a placeholder for the IDs
        if isinstance(sales_orders, int):
            sales_orders = [sales_orders]
        header_ids_placeholder = ','.join(['%s'] * len(sales_orders))
        header_query = f"""
            SELECT * FROM sal.sales_order_headers
            WHERE so_num IN ({header_ids_placeholder}) AND status = %s
        """
        params = tuple(sales_orders) + (sales_order_status,)
        logger.debug(f"{current_userid} --> {MODULE_NAME}: header ids placeholder and params {header_ids_placeholder}: {params}")        
    else:
        # If no sales_orders are provided, fetch all headers with the specified status
        header_query = """
            SELECT * FROM sal.sales_order_headers
            WHERE status = %s
        """
        params = (sales_order_status,)

    # Execute the query to get the sales order headers
    cursor.execute(header_query, params)
    headers = cursor.fetchall()
    logger.debug(f"{current_userid} --> {MODULE_NAME}: fetched headers: {headers}")    

    # Extract header IDs for the next query
    header_ids = [header[0] for header in headers]  # Ensure you are using the correct index for header_id
    logger.debug(f"Extracted header IDs: {header_ids}")

    # Ensure header_ids is correctly populated
    if not header_ids:
        logger.debug("Header IDs list is empty after extraction")
        cursor.close()
        return {"sales_orders": []}

    # Prepare and execute the query to get the sales order lines
    header_ids_to_query = ','.join(['%s'] * len(header_ids))
    logger.debug(f"Line IDs placeholder: {header_ids_to_query}")

    line_query = f"""
        SELECT * FROM sal.sales_order_lines
        WHERE header_id IN ({header_ids_to_query}) AND status = %s
    """
    params = tuple(header_ids) + (sales_order_status,)
    logger.debug(f"Line query params: {params}")

    cursor.execute(line_query, params)
    lines = cursor.fetchall()
    logger.debug(f"Fetched lines: {lines}")

    cursor.close()

    # Group lines by their corresponding headers
    orders_by_header = {}
    for header in headers:
        header_id = header[0]  # Ensure you are using the correct index for header_id
        orders_by_header[header_id] = {
            "sales_header_id": header_id,
            "sales_order_lines": []
        }
    logger.debug(f"{current_userid} --> {MODULE_NAME}: inpput information orders byheader  {orders_by_header}")    

    for line in lines:
        header_id = line[1]  # Correct index for header_id in lines (was line[0], now line[1])
        if header_id in orders_by_header:
            orders_by_header[header_id]["sales_order_lines"].append({
                "sales_order_line_id": line[0],  # Corrected index for sales_order_line_id
                "sales_item_id": line[3],
                "sales_uom_id": line[7],
                "sales_uom_id_quantity": line[4],
                "sales_base_uom_id": line[12],
                "sales_base_uom_quantity": line[13],
                "already_picked_quantity": line[14],
                "sales_line_status": line[9]  # Adjusted index for sales_line_status (was line[8], now line[9])
            })

    # Convert the grouped data to a list of orders
    sales_orders_data = list(orders_by_header.values())
    logger.debug(f"{current_userid} --> {MODULE_NAME}: SALES ORDER DATA : {sales_orders_data}")
    return {"sales_orders": sales_orders_data}