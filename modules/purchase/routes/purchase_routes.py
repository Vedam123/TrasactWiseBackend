from flask import Blueprint
from modules.purchase.get_purchase_order_lines import get_purchase_order_lines
from modules.purchase.get_purchase_order_headers import get_purchase_order_headers
from modules.purchase.create_purchase_order_header import create_purchase_order_header
from modules.purchase.create_purchase_order_line import create_purchase_order_line
from modules.purchase.update_purchase_order_header import update_purchase_order_header
from modules.purchase.update_purchase_order_lines import update_purchase_order_lines
from modules.utilities.logger import logger  # Import the logger module
from modules.purchase.delete_purchase_order_lines import delete_purchase_order_lines
from modules.purchase.delete_purchase_orders import delete_purchase_orders
from modules.purchase.auto_create_po_pi import auto_create_po_pi

# Create blueprints
purchase_list_routes = Blueprint('purchase_list_routes', __name__)
purchase_create_routes = Blueprint('purchase_create_routes', __name__)
purchase_delete_routes = Blueprint('purchase_delete_routes', __name__)

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

@purchase_create_routes.route('/auto_create_po_pi', methods=['POST'])
def auto_create_po_pi_all():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: auto_create_po_pi")
    return auto_create_po_pi()

# PUT routes -----------------------------------------------------
@purchase_create_routes.route('/update_purchase_order_header', methods=['PUT'])
def update_purchase_order_header_all():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Update a purchase order header")
    return update_purchase_order_header()

@purchase_create_routes.route('/update_purchase_order_lines', methods=['PUT'])
def update_purchase_order_lines_all():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Update a purchase order lines")
    return update_purchase_order_lines()





# DELETE routes -----------------------------------------------------
@purchase_list_routes.route('/delete_purchase_order_lines', methods=['DELETE'])
def delete_purchase_order_lines_all():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to delete Purcahse order Lines")
    return delete_purchase_order_lines()

@purchase_list_routes.route('/delete_purchase_orders', methods=['DELETE'])
def delete_purchase_orders_all():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to delete Purcahse orders")
    return delete_purchase_orders()

# Register blueprints
def register_purchase_routes(app):
    app.register_blueprint(purchase_list_routes)
    app.register_blueprint(purchase_create_routes)
    app.register_blueprint(purchase_delete_routes)
