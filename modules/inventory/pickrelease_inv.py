from flask import jsonify, request, Blueprint
from modules.security.permission_required import permission_required
import uuid
from config import WRITE_ACCESS_TYPE
from modules.admin.databases.mydb import get_database_connection
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.sales.routines.fetch_sales_order_details import fetch_sales_order_details
from modules.employee.routines.fetch_employee_details import fetch_employee_details
from modules.inventory.routines.allocate_inventory import allocate_inventory
from modules.inventory.routines.update_sales_order_status import update_sales_order_status
from modules.inventory.routines.get_sales_order_data import get_sales_order_data
from modules.utilities.logger import logger

pickrelease_inv_api = Blueprint('pickrelease_inv_api', __name__)

@pickrelease_inv_api.route('/pickrelease_inv', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def pickrelease_inv():
    MODULE_NAME = __name__
    mydb = None
    mycursor = None
    execution_id = generate_execution_id()

    try:
        logger.info(f"Received request: {request.method} {request.url}")

        authorization_header = request.headers.get('Authorization')
        logger.debug(f"Authorization Header: {authorization_header}")

        token_results = get_user_from_token(authorization_header)
        USER_ID = token_results["username"] if token_results else ""
        logger.debug(f"User ID from Token: {USER_ID}")

        data = request.get_json()
        logger.debug(f"Request Data: {data}")

        full_picking = data.get('full_picking')
        logger.debug(f"Full Picking: {full_picking}")

        full_qty_alloc_status = data.get('full_qty_alloc_status')
        part_qty_alloc_status = data.get('part_qty_alloc_status')
        ship_status = data.get('ship_status')
        sales_order_status = data.get('sales_order_status', [])  # Changed to default to an empty list
        pick_status = data.get('released_inventory')
        look_only_inventory_ids = data.get("look_only_inventory_ids", [])

        if full_picking != "Yes":
            logger.warning("Full picking is not enabled")
            return jsonify(message='Full picking is not enabled'), 400

        current_userid = None
        if authorization_header.startswith('Bearer '):
            token = authorization_header.replace('Bearer ', '')
            decoded_token = decode_token(token)
            current_userid = decoded_token.get('Userid')
        logger.debug(f"Current User ID from Token: {current_userid}")

        sales_orders = data.get('sales_orders', [])
        logger.debug(f"Sales Orders: {sales_orders}")

        mydb = get_database_connection(USER_ID, MODULE_NAME)
        logger.debug(f"Database Connection established for User ID: {USER_ID}")

        # Fetch employee details
        details_by_id = fetch_employee_details(USER_ID, MODULE_NAME, mydb, user_id=current_userid)
        if details_by_id:
            empid = details_by_id["empid"]
            name = details_by_id["name"]
            logger.debug(f"Employee ID: {empid}, Name: {name}")
        else:
            logger.debug("No details found by user ID")

        picker_id = details_by_id["empid"]

        # Fetch sales order data
        sales_order_data = get_sales_order_data(sales_orders, sales_order_status, mydb, current_userid, MODULE_NAME)
        sales_orders = sales_order_data.get("sales_orders", [])

        logger.debug(f"{current_userid} --> {MODULE_NAME}: AFTER RETURN FROM FUNCTION SALES ORDER DATA : {sales_orders}")

        updated_headers = set()

        for sales_order in sales_orders:
            sales_header_id = sales_order.get('sales_header_id')
            shipping_method = ""
            shipping_address = ""
            details = fetch_sales_order_details(USER_ID, MODULE_NAME, mydb, sales_header_id)
            if details:
                logger.debug("Sales Order Details:")
                shipping_method = details.get("shipping_method")
                shipping_address = details.get("shipping_address")
                logger.debug(f"Shipping Method: {shipping_method}")
                logger.debug(f"Shipping Address: {shipping_address}")
            else:
                logger.debug(f"No details found for Header ID {sales_header_id}")
            sales_order_lines = sales_order.get('sales_order_lines')
            logger.debug(f"Processing Sales Header ID: {sales_header_id}")
            logger.debug(f"Sales Order Lines: {sales_order_lines}")

            for line in sales_order_lines:
                result = None
                status_code = None
                sales_order_line_id = line.get('sales_order_line_id')
                current_status = line.get('sales_line_status')
                if current_status is None:
                    result = jsonify(message=f"Fetched status for Sales Order Line ID: {sales_order_line_id} is NULL : {current_status}")
                    status_code = 200
                    logger.debug(f"Fetched status for Sales Order Line ID: {sales_order_line_id} is NULL : {current_status}")
                    continue

                logger.debug(f"Fetched status for Sales Order Line ID: {sales_order_line_id} is {current_status}")

                if current_status == full_qty_alloc_status:
                    result = jsonify(message=f"The Sales order line: {sales_order_line_id} is already fully Picked and its status is  : {current_status}")
                    logger.debug(f"Skipping allocation for Sales Order Line ID: {sales_order_line_id} as it is fully allocated")
                    continue
                logger.debug(f"Processing Sales Order Line: {line}")
                result, status_code = allocate_inventory(line, execution_id, sales_header_id, look_only_inventory_ids,
                                                         full_qty_alloc_status, part_qty_alloc_status, shipping_method, shipping_address, ship_status,
                                                         picker_id, pick_status, mydb, current_userid, MODULE_NAME)
                if status_code == 200:
                    updated_headers.add(sales_header_id)
                    mydb.commit()
                elif status_code != 200:
                    logger.warning(f"Processing failed for sales header ID and line: {sales_header_id}, {line}")
                    mydb.rollback()
                    continue

            for sales_header_id in updated_headers:
                result, status_code = update_sales_order_status(sales_header_id, full_qty_alloc_status, part_qty_alloc_status, mydb, current_userid, MODULE_NAME)
                logger.debug(f"Updated Sales Order Status for Header ID: {sales_header_id}")

        mydb.commit()
        logger.info("Process is completed")
        return result, status_code

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

def generate_execution_id():
    return str(uuid.uuid4())
