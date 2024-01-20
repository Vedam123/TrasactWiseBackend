from flask import Blueprint
from modules.inventory.get_warehouses import get_warehouses
from modules.inventory.create_warehouse import create_warehouse
from modules.inventory.get_locations import get_locations
from modules.inventory.create_location import create_location
from modules.inventory.get_zones import get_zones
from modules.inventory.create_zone import create_zone
from modules.inventory.get_aisles import get_aisles
from modules.inventory.create_aisle import create_aisle
from modules.inventory.get_invrows import get_invrows
from modules.inventory.create_invrow import create_invrow
from modules.inventory.get_racks import get_racks  # Import the new inventory APIs
from modules.inventory.create_rack import create_rack  # Import the new inventory APIs
from modules.inventory.get_bins import get_bins
from modules.inventory.create_bin import create_bin
from modules.inventory.get_item_inventory import get_item_inventory
from modules.inventory.create_item_inventory import create_item_inventory
from modules.inventory.get_receipts import get_receipts
from modules.inventory.create_receipt import create_receipt
from modules.inventory.get_inspections import get_inspections
from modules.inventory.create_inspection import create_inspection
from modules.inventory.get_open_inspections import get_open_inspections
from modules.inventory.get_shipments import get_shipments
from modules.inventory.create_shipment import create_shipment
from modules.inventory.update_inspection import update_inspection
from modules.inventory.put_away_inventory import put_away_inventory
from modules.inventory.get_receipts_to_putaway import get_receipts_to_putaway
from modules.inventory.update_ir_status import update_ir_status
from modules.inventory.pack_or_unpack   import pack_or_unpack
from modules.inventory.bulk_pack_or_unpack   import bulk_pack_or_unpack
from modules.inventory.move_item_inventory  import move_item_inventory
from modules.utilities.logger import logger

# Create blueprints
inventory_get_routes = Blueprint('inventory_get_routes', __name__)
inventory_post_routes = Blueprint('inventory_post_routes', __name__)
inventory_put_routes = Blueprint('inventory_put_routes', __name__)

# GET routes -----------------------------------------------------


@inventory_get_routes.route('/get_receipts_to_putaway', methods=['GET'])
def get_all_receipts_to_putaway():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to get only receipts for putaway")
    return get_receipts_to_putaway()

@inventory_get_routes.route('/get_open_inspections', methods=['GET'])
def get_all_open_inspections():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to get only open inpsections")
    return get_open_inspections()

@inventory_get_routes.route('/get_shipments', methods=['GET'])
def get_all_shipments():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to get shipments")
    return get_shipments()

@inventory_get_routes.route('/get_inspections', methods=['GET'])
def get_all_inspections():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to get inpsections")
    return get_inspections()

@inventory_get_routes.route('/get_receipts', methods=['GET'])
def get_all_receipts():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to get receipts")
    return get_receipts()

@inventory_get_routes.route('/get_item_inventory', methods=['GET'])
def get_all_item_inventory():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to get item inventory")
    return get_item_inventory()

@inventory_get_routes.route('/get_bins', methods=['GET'])
def get_all_bins():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to get bins")
    return get_bins()

@inventory_get_routes.route('/get_racks', methods=['GET'])
def get_all_racks():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to get racks")
    return get_racks()

@inventory_get_routes.route('/get_invrows', methods=['GET'])
def get_all_invrows():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to get invrows")
    return get_invrows()

@inventory_get_routes.route('/get_aisles', methods=['GET'])
def get_all_aisles():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to get aisles")
    return get_aisles()

@inventory_get_routes.route('/get_warehouses', methods=['GET'])
def get_all_warehouses():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to get Warehouses")
    return get_warehouses()

@inventory_get_routes.route('/get_locations', methods=['GET'])
def get_all_locations():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to get locations")
    return get_locations()

@inventory_get_routes.route('/get_zones', methods=['GET'])
def get_all_zones():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to get zones")
    return get_zones()

# POST routes -----------------------------------------------------
@inventory_post_routes.route('/create_shipment', methods=['POST'])
def create_shipment_data():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to create shipment")
    return create_shipment()

@inventory_post_routes.route('/create_inspection', methods=['POST'])
def create_inspections():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to create inspection")
    return create_inspection()

@inventory_post_routes.route('/create_receipt', methods=['POST'])
def create_receipt_data():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to create receipt")
    return create_receipt()

@inventory_post_routes.route('/create_item_inventory', methods=['POST'])
def create_item_inventory_data():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to create item inventory")
    return create_item_inventory()

@inventory_post_routes.route('/create_bin', methods=['POST'])
def create_bin_data():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to create bin")
    return create_bin()

@inventory_post_routes.route('/create_rack', methods=['POST'])
def create_rack_data():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to create rack")
    return create_rack()

@inventory_post_routes.route('/create_invrow', methods=['POST'])
def create_invrow_data():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to create invrow")
    return create_invrow()

@inventory_post_routes.route('/create_aisle', methods=['POST'])
def create_aisle_data():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to create aisle")
    return create_aisle()

@inventory_post_routes.route('/create_warehouse', methods=['POST'])
def create_warehouse_data():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to create warehouse")
    return create_warehouse()

@inventory_post_routes.route('/create_location', methods=['POST'])
def create_location_data():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to create location")
    return create_location()

@inventory_post_routes.route('/create_zone', methods=['POST'])
def create_zone_data():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to create zone")
    return create_zone()

@inventory_put_routes.route('/put_away_inventory', methods=['POST'])
def put_away_inventories():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to put away inventory")
    return put_away_inventory()

@inventory_put_routes.route('/pack_or_unpack', methods=['POST'])
def pack_all_or_unpack_all():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request pack or unpack")
    return pack_or_unpack()

@inventory_put_routes.route('/bulk_pack_or_unpack', methods=['POST'])
def bulk_pack_or_unpack_all():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request Bulk pack or unpack")
    return bulk_pack_or_unpack()

@inventory_put_routes.route('/move_item_inventory', methods=['POST'])
def move_item_inventory_all():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request Move inventory")
    return move_item_inventory()

# PUT Methods -----------------------------------------------------------
@inventory_put_routes.route('/update_inspection', methods=['PUT'])
def update_inspections():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to update zone")
    return update_inspection()

@inventory_put_routes.route('/update_transaction_status', methods=['PUT'])
def update_receipt_or_inspection_status():
    MODULE_NAME = __name__
    USER_ID = ""
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Update Receipt or Inpsection status")
    return update_ir_status()


# DELETE Methods ---------------------------------------------------------

# Register blueprints
def register_inventory_routes(app):
    app.register_blueprint(inventory_get_routes)
    app.register_blueprint(inventory_post_routes)
    app.register_blueprint(inventory_put_routes)
