from flask import jsonify, request, Blueprint
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import WRITE_ACCESS_TYPE
from modules.inventory.routines.update_pick_and_ship_stage import update_pick_and_ship_stage_status
from modules.utilities.logger import logger

reverse_pickrelease_inv_api = Blueprint('reverse_pickrelease_inv_api', __name__)


def fetch_pick_release_logs(mycursor, execution_id, sales_header_id, sales_order_line_id, inventory_id):
    query = "SELECT * FROM sal.pick_release_log WHERE execution_id = %s AND pick_release_status = 'RELEASED'"
    params = [execution_id]
    if sales_header_id:
        query += " AND sales_header_id = %s"
        params.append(sales_header_id)
    if sales_order_line_id:
        query += " AND sales_order_line_id = %s"
        params.append(sales_order_line_id)
    if inventory_id:
        query += " AND inventory_id = %s"
        params.append(inventory_id)
    
    query += " ORDER BY log_id DESC"

    logger.debug(f"Executing query: {query} with params: {params}")
    mycursor.execute(query, params)
    rval = mycursor.fetchall()
    return rval

def update_item_inventory(mycursor, inventory_id):
    try:
        mycursor.execute("UPDATE inv.item_inventory SET status = NULL, subject = NULL WHERE inventory_id = %s", (inventory_id,))
        logger.debug(f"Updated item inventory for inventory_id: {inventory_id}")
    except Exception as e:
        logger.error(f"Error updating item inventory for inventory_id {inventory_id}: {str(e)}")
        raise e

def update_sales_order_lines(mycursor, sales_line_status, already_picked_quantity, sales_header_id,sales_order_line_id):
    try:
        mycursor.execute(
            "UPDATE sal.sales_order_lines SET status = %s, picked_quantity = %s WHERE header_id =%s AND line_id = %s",
            (sales_line_status, already_picked_quantity, sales_header_id,sales_order_line_id)
        )
        logger.debug(f"Updated sales order line for line_id: {sales_order_line_id}, status: {sales_line_status}, picked_quantity: {already_picked_quantity}")
    except Exception as e:
        logger.error(f"Error updating sales order line for line_id {sales_order_line_id}: {str(e)}")
        raise e

def update_sales_order_headers(mycursor, sales_line_status, sales_header_id):
    try:
        mycursor.execute(
            "UPDATE sal.sales_order_headers SET status = %s WHERE header_id = %s",
            (sales_line_status, sales_header_id)
        )
        logger.debug(f"Updated sales order header for header_id: {sales_header_id}, status: {sales_line_status}")
    except Exception as e:
        logger.error(f"Error updating sales order header for header_id {sales_header_id}: {str(e)}")
        raise e

def update_pick_release_status(mycursor, rows, reverse_pick_release_status):
    try:
        for row in rows:
            mycursor.execute(
                "UPDATE sal.pick_release_log SET pick_release_status = %s WHERE log_id = %s",
                (reverse_pick_release_status, row['log_id'])
            )
        logger.debug(f"Updated pick_release_status in sal.pick_release_log to {reverse_pick_release_status} for relevant entries")
    except Exception as e:
        logger.error(f"Error updating pick_release_status: {str(e)}")
        raise e

    
@reverse_pickrelease_inv_api.route('/reverse_pick_release', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def reverse_pick_release():
    MODULE_NAME = __name__
    mydb = None
    mycursor = None

    try:
        logger.info(f"Received request: {request.method} {request.url}")

        authorization_header = request.headers.get('Authorization')

        try:
            company, instance, dbuser, mydb, appuser, appuserid, user_info, employee_info = get_user_and_db_details(authorization_header)
            logger.debug(f"{appuser} --> {__name__}: Successfully retrieved user details from the token.")
        except ValueError as e:
            logger.error(f"Failed to retrieve user details from token. Error: {str(e)}")
            return jsonify({"error": str(e)}), 401
        
        if not appuser:
            logger.error(f"Unauthorized access attempt: {appuser} --> {__name__}: Application user not found.")
            return jsonify({"error": "Unauthorized. Username not found."}), 401

        data = request.get_json()
        logger.debug(f"Request Data: {data}")

        execution_id = data.get('execution_id')
        sales_header_id = data.get('sales_header_id')
        sales_order_line_id = data.get('sales_order_line_id')
        inventory_id = data.get('inventory_id')
        reverse_pick_release_status = data.get('reverse_pick_release')

        if not execution_id:
            logger.error("Execution ID is required in the request data")
            return jsonify(message='Execution ID is required'), 400
        
        if not reverse_pick_release_status:
            logger.error("The reverse Pick release status is needed to process ")
            return jsonify(message='The reverse Pick release status is needed to process'), 400
        
        logger.debug(f"After processing teh data: {data}")
        # Start the transaction here, before initiating the cursor
        #mydb.start_transaction()
        logger.debug(f"Transaction started for execution_id: {execution_id}")

        logger.debug(f"my db started transaction: {data}")
        mycursor = mydb.cursor(dictionary=True)  # Return rows as dictionaries
        logger.debug(f"Mycursor is initated and before calling the fetch pick relase logs function : {data}")

        rows = fetch_pick_release_logs(mycursor, execution_id, sales_header_id, sales_order_line_id, inventory_id)
        logger.debug(f"After After fetch pick relase logs function : {data}")
        if not rows:
            logger.warning("No records found for the provided execution ID")
            return jsonify(message='No records found'), 404

        inventory_ids = set()
        sales_order_line_ids = set()
        sales_header_ids = set()
        logger.debug(f"Before for loop : {data}")
        for row in rows:
            inventory_id = row['inventory_id']
            sales_order_line_id = row['sales_order_line_id']
            sales_header_id = row['sales_header_id']

            inventory_ids.add(inventory_id)
            sales_order_line_ids.add(sales_order_line_id)
            sales_header_ids.add(sales_header_id)

            if inventory_id is not None:
                update_item_inventory(mycursor, inventory_id)

            update_pick_and_ship_stage_status(appuser=appuserid, MODULE_NAME=MODULE_NAME, mydb=mydb, 
                                              reverse_pick_release_status=reverse_pick_release_status, execution_id=execution_id, 
                                              order_id=sales_header_id, line_id=sales_order_line_id)

            if row['sales_line_status'] is not None and row['sales_line_new_status'] is not None and row['sales_line_status'] != row['sales_line_new_status']:
                updated_picked_quantity = calculate_updated_picked_quantity(row['already_picked_quantity'],row['picked_quantity'])
                update_sales_order_lines(mycursor, row['sales_line_status'], updated_picked_quantity, sales_header_id, sales_order_line_id)           
        logger.debug(f"Before for loop 3 : {data}")
        for sales_header_id in sales_header_ids:
            update_sales_order_headers(mycursor, rows[0]['sales_line_status'], sales_header_id)
        logger.debug(f"Before calling update pick release status function  : {data}")
        update_pick_release_status(mycursor, rows,reverse_pick_release_status)
        # Commit the transaction after all updates have been executed
        mydb.commit()
        logger.info("Pick release reversed successfully")
        return jsonify(message='Pick release reversed successfully'), 200

    except Exception as e:
        logger.error(f"Error occurred: {str(e)}")
        if mydb:
            mydb.rollback()
        return jsonify(message='Processing failed'), 422

    finally:
        if mycursor:
            mycursor.close()
        if mydb:
            mydb.close()

def calculate_updated_picked_quantity(already_picked_quantity, picked_quantity):
    # Ensure both quantities are not None and default to 0 if they are
    already_picked_quantity = already_picked_quantity if already_picked_quantity is not None else 0
    picked_quantity = picked_quantity if picked_quantity is not None else 0
    
    # Calculate the updated picked quantity and ensure it is non-negative
    updated_picked_quantity = already_picked_quantity - picked_quantity
    updated_picked_quantity = max(updated_picked_quantity, 0)

    return updated_picked_quantity