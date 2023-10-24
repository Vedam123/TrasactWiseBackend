from flask import jsonify, Blueprint
from modules.common.list_currencies import list_currency_data
from modules.common.list_exchange_rates import list_exchange_rate_data
from modules.common.list_tax_codes import list_tax_data
from modules.common.explode_bom import explode_bom_data
from modules.common.process_bom import process_exploded_bom
from modules.common.get_partner_data import get_partner_data
from modules.common.create_partner_data import create_partner_data
from modules.utilities.logger import logger  # Import the logger module

list_common_module = Blueprint('list_common_module', __name__)

# GET Methods ---------------------------------------------------------
@list_common_module.route('/list_currencies', methods=['GET'])
def list_currencies():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Currencies are going to be retrieved")
    return list_currency_data()

@list_common_module.route('/list_exchange_rates', methods=['GET'])
def list_exchange_rates():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Exchange rates are going to be retrieved")
    return list_exchange_rate_data()

@list_common_module.route('/list_tax_codes', methods=['GET'])
def list_tax_codes():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Tax codes are going to be retrieved")
    return list_tax_data()

@list_common_module.route('/explode_bom', methods=['GET'])
def bom_explosion():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: BOM of the item is going to be exploded")
    return explode_bom_data()

@list_common_module.route('/process_exploded_bom', methods=['GET'])
def process_bom():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Already exploded BOM is now being processed")
    return process_exploded_bom()

@list_common_module.route('/get_partner_data', methods=['GET'])
def list_business_partners():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: List business partners")
    return get_partner_data()

# POST Methods ----------------------------------------------------------

@list_common_module.route('/create_partner_data', methods=['POST'])
def create_business_partners():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Create business partners")
    return create_partner_data()

# PUT Methods -----------------------------------------------------------

# DELETE Methods ---------------------------------------------------------

def register_common_module_routes(app):
    app.register_blueprint(list_common_module)
