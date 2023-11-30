from flask import jsonify, Blueprint
from modules.common.list_currencies import list_currency_data
from modules.common.list_exchange_rates import list_exchange_rate_data
from modules.common.list_tax_codes import list_tax_data
from modules.common.explode_bom import explode_bom_data
from modules.common.list_bom import list_bom_data
from modules.common.process_bom import process_exploded_bom
from modules.common.get_partner_data import get_partner_data
from modules.common.create_partner_data import create_partner_data
from modules.common.get_legal_entity import get_legal_entity_data
from modules.common.create_legal_entity import create_legal_entity

from modules.common.get_group_companies import get_group_companies
from modules.common.create_group_company import create_group_company
from modules.common.get_companies import get_companies
from modules.common.create_company import create_company

from modules.common.get_departments import get_departments
from modules.common.create_department import create_department

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

@list_common_module.route('/list_bom', methods=['GET'])
def list_bom():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Bill of Materials are going to be retrieved")
    return list_bom_data()

@list_common_module.route('/get_legal_entity', methods=['GET'])
def get_legal_entity():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Get Legal entities")
    return get_legal_entity_data()

@list_common_module.route('/get_group_companies', methods=['GET'])
def get_groupcompanies():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Get Group companies entities")
    return get_group_companies()

@list_common_module.route('/get_companies', methods=['GET'])
def get_all_companies():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Get companies entities")
    return get_companies()

@list_common_module.route('/get_departments', methods=['GET'])
def get_all_departments():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Get department entities")
    return get_departments()

# POST Methods ----------------------------------------------------------

@list_common_module.route('/create_partner_data', methods=['POST'])
def create_business_partners():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Create business partners")
    return create_partner_data()

@list_common_module.route('/create_legal_entity', methods=['POST'])
def create_legalentity():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Create Legal entities")
    return create_legal_entity()

@list_common_module.route('/create_group_company', methods=['POST'])
def create_groupcompany():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Create Group companies")
    return create_group_company()

@list_common_module.route('/create_company', methods=['POST'])
def create_a_company():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Create company")
    return create_company()

@list_common_module.route('/create_department', methods=['POST'])
def create_a_department():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Create department")
    return create_department()
# PUT Methods -----------------------------------------------------------

# DELETE Methods ---------------------------------------------------------

def register_common_module_routes(app):
    app.register_blueprint(list_common_module)
