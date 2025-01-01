from flask import Blueprint
from modules.products.list_item_categories import list_item_categories
from modules.products.list_items import list_items
from modules.products.list_uoms import list_uoms
from modules.products.create_item_category import create_item_category
from modules.products.create_items import create_items
from modules.products.create_uom import create_uom
from modules.products.uom_conversion import convert_quantity_endpoint
from modules.products.baseunit_uom_conversion import baseunit_uom_conversion
from modules.products.currency_conversion import currency_conversion
from modules.products.get_category_images import get_category_images
from modules.products.get_item_images import get_item_images
from modules.products.update_items import update_items
from modules.products.create_item_images import create_item_images
from modules.products.delete_item_image import delete_item_image
from modules.products.update_item_image import update_item_image

from modules.products.update_item_category_image import update_item_category_image
from modules.products.update_item_image import update_item_image
from modules.products.delete_item_image import delete_item_image
from modules.products.update_itemcategory import update_itemcategory
from modules.products.create_category_images import create_category_images
from modules.products.delete_item_category_image import delete_item_category_image
from modules.products.delete_item_category import delete_item_category
from modules.products.delete_item import delete_item

from modules.utilities.logger import logger  # Import the logger module

item_list_routes = Blueprint('item_list_routes', __name__)
item_create_routes = Blueprint('item_create_routes', __name__)
item_update_routes = Blueprint('item_update_routes', __name__)
item_delete_routes = Blueprint('item_delete_routes', __name__)

# GET routes -----------------------------------------------------
@item_list_routes.route('/list_items', methods=['GET'])
def list_route_items():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to list items")
    return list_items()

@item_list_routes.route('/list_item_categories', methods=['GET'])
def list_route_item_categories():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to list item categories")
    return list_item_categories()

@item_list_routes.route('/list_uoms', methods=['GET'])
def list_route_uoms():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to list UOMs")
    return list_uoms()

@item_create_routes.route('/uom_conversion', methods=['GET'])
def uom_route_conversion():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request for UOM conversion")
    return convert_quantity_endpoint()

@item_create_routes.route('/currency_conversion', methods=['GET'])
def currency_route_conversion():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request for currency conversion")
    return currency_conversion()

@item_create_routes.route('/baseunit_uom_conversion', methods=['GET'])
def baseunit_conversion():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Base unit conversion ")
    return baseunit_uom_conversion()

@item_create_routes.route('/get_category_images', methods=['GET'])
def get_category_images_all():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: get_category_images ")
    return get_category_images()

@item_create_routes.route('/get_item_images', methods=['GET'])
def get_item_images_all():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: get_item_images ")
    return get_item_images()

# POST routes -----------------------------------------------------
@item_create_routes.route('/create_items', methods=['POST'])
def create_items_all():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to create an item")
    return create_items()

@item_create_routes.route('/create_item_category', methods=['POST'])
def create_route_item_category():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to create an item category")
    return create_item_category()

@item_create_routes.route('/create_uom', methods=['POST'])
def create_route_uom():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to create a UOM")
    return create_uom()

@item_create_routes.route('/create_item_images', methods=['POST'])
def create_item_images_all():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to create_item_images")
    return create_item_images()

@item_create_routes.route('/create_category_images', methods=['POST'])
def create_category_images_all():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to create_item_images")
    return create_category_images()

# PuT routes -----------------------------------------------------
@item_update_routes.route('/update_items', methods=['PUT'])
def update_items_all():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to update_items an item")
    return update_items()

@item_update_routes.route('/update_item_image', methods=['PUT'])
def update_item_image_all():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to update_item_image an item")
    return update_item_image()

@item_update_routes.route('/update_itemcategory', methods=['PUT'])
def update_itemcategory_all():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to update_itemcategory an item")
    return update_itemcategory()

@item_update_routes.route('/update_item_category_image', methods=['PUT'])
def update_item_category_image_all():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to update_item_category_image an item")
    return update_item_category_image()

# DELETE routes -----------------------------------------------------
@item_delete_routes.route('/delete_item_image', methods=['DELETE'])
def delete_item_image_all():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to delete_item_image of an item")
    return delete_item_image()

@item_delete_routes.route('/delete_item_category_image', methods=['DELETE'])
def delete_item_category_image_all():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to delete_item_category_image of an item")
    return delete_item_category_image()

@item_delete_routes.route('/delete_item_category', methods=['DELETE'])
def delete_item_category_all():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to delete_item_category of a category")
    return delete_item_category()


@item_delete_routes.route('/delete_item', methods=['DELETE'])
def delete_item_all():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to delete_item of a item")
    return delete_item()



# Register blueprints
def register_item_routes(app):
    app.register_blueprint(item_list_routes)
    app.register_blueprint(item_create_routes)
    app.register_blueprint(item_update_routes)
    app.register_blueprint(item_delete_routes)
