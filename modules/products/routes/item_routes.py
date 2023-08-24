from flask import Blueprint

from modules.products.list_item_categories import list_item_categories
from modules.products.list_items import list_items
from modules.products.list_uoms import list_uoms
from modules.products.create_item_category import create_item_category
from modules.products.create_item import create_item
from modules.products.create_uom import create_uom
from modules.products.uom_conversion import convert_quantity_endpoint
from modules.products.currency_conversion import currency_conversion

# Create blueprints
item_list_routes = Blueprint('item_list_routes', __name__)
item_create_routes = Blueprint('item_create_routes', __name__)

# GET routes -----------------------------------------------------
@item_list_routes.route('/list_items', methods=['GET'])
def list_route_items():
    return list_items()

@item_list_routes.route('/list_item_categories', methods=['GET'])
def list_route_item_categories():
    return list_item_categories()

@item_list_routes.route('/list_uoms', methods=['GET'])
def list_route_uoms():
    return list_uoms()

@item_create_routes.route('/uom_conversion', methods=['GET'])
def uom_route_conversion():
    return convert_quantity_endpoint()

@item_create_routes.route('/currency_conversion', methods=['GET'])
def currency_route_conversion():
    return currency_conversion()
# POST routes -----------------------------------------------------
@item_create_routes.route('/create_item', methods=['POST'])
def create_route_item():
    return create_item()

@item_create_routes.route('/create_item_category', methods=['POST'])
def create_route_item_category():
    return create_item_category()

@item_create_routes.route('/create_uom', methods=['POST'])
def create_route_uom():
    return create_uom()

# Register blueprints
def register_item_routes(app):
    app.register_blueprint(item_list_routes)
    app.register_blueprint(item_create_routes)
