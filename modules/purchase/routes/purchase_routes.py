from flask import Blueprint
from modules.purchase.get_purchase_order_lines import get_purchase_order_lines
from modules.purchase.get_purchase_order_headers import get_purchase_order_headers
from modules.purchase.create_purchase_order_header import create_purchase_order_header
from modules.purchase.create_purchase_order_line import create_purchase_order_line
from modules.utilities.logger import logger  # Import the logger module

# Create blueprints
purchase_list_routes = Blueprint('purchase_list_routes', __name__)
purchase_create_routes = Blueprint('purchase_create_routes', __name__)

# GET routes -----------------------------------------------------
@purchase_list_routes.route('/get_purchase_order_lines', methods=['GET'])
def get_purchase_order_lines_all():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to get Purcahse order Lines")
    return get_purchase_order_lines()

@purchase_list_routes.route('/get_purchase_order_headers', methods=['GET'])
def get_purchase_order_headers_all():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to get Purcahse order Headers")
    return get_purchase_order_headers()
# POST routes -----------------------------------------------------
@purchase_create_routes.route('/create_purchase_order_header', methods=['POST'])
def create_purchase_order_header_All():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Create a purchase order header")
    return create_purchase_order_header()

@purchase_create_routes.route('/create_purchase_order_line', methods=['POST'])
def create_purchase_order_line_All():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Create a purchase order line")
    return create_purchase_order_line()

# Register blueprints
def register_purchase_routes(app):
    app.register_blueprint(purchase_list_routes)
    app.register_blueprint(purchase_create_routes)
