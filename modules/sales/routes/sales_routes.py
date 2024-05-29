from flask import Blueprint
from modules.sales.get_sales_order_lines import get_sales_order_lines
from modules.sales.get_sales_order_headers import get_sales_order_headers
from modules.sales.create_sales_order_header import create_sales_order_header
from modules.sales.create_sales_order_line import create_sales_order_line
from modules.sales.update_sales_order_header import update_sales_order_header
from modules.sales.update_sales_order_lines import update_sales_order_lines
from modules.utilities.logger import logger  # Import the logger module
from modules.sales.delete_sales_order_lines import delete_sales_order_lines
from modules.sales.delete_sales_orders import delete_sales_orders

# Create blueprints
sales_list_routes = Blueprint('sales_list_routes', __name__)
sales_create_routes = Blueprint('sales_create_routes', __name__)
sales_delete_routes = Blueprint('sales_delete_routes', __name__)

# GET routes -----------------------------------------------------
@sales_list_routes.route('/get_sales_order_lines', methods=['GET'])
def get_sales_order_lines_all():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to get Purcahse order Lines")
    return get_sales_order_lines()

@sales_list_routes.route('/get_sales_order_headers', methods=['GET'])
def get_sales_order_headers_all():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to get Purcahse order Headers")
    return get_sales_order_headers()
# POST routes -----------------------------------------------------
@sales_create_routes.route('/create_sales_order_header', methods=['POST'])
def create_sales_order_header_All():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Create a sales order header")
    return create_sales_order_header()

@sales_create_routes.route('/create_sales_order_line', methods=['POST'])
def create_sales_order_line_All():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Create a sales order line")
    return create_sales_order_line()

# PUT routes -----------------------------------------------------
@sales_create_routes.route('/update_sales_order_header', methods=['PUT'])
def update_sales_order_header_all():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Update a sales order header")
    return update_sales_order_header()

@sales_create_routes.route('/update_sales_order_lines', methods=['PUT'])
def update_sales_order_lines_all():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Update a sales order lines")
    return update_sales_order_lines()

# DELETE routes -----------------------------------------------------
@sales_list_routes.route('/delete_sales_order_lines', methods=['DELETE'])
def delete_sales_order_lines_all():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to delete Purcahse order Lines")
    return delete_sales_order_lines()

@sales_list_routes.route('/delete_sales_orders', methods=['DELETE'])
def delete_sales_orders_all():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to delete Purcahse orders")
    return delete_sales_orders()

# Register blueprints
def register_sales_routes(app):
    app.register_blueprint(sales_list_routes)
    app.register_blueprint(sales_create_routes)
    app.register_blueprint(sales_delete_routes)
