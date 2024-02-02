from flask import Blueprint
from modules.finance.get_accounts import get_accounts
from modules.finance.get_journal_headers import get_journal_headers
from modules.finance.get_journal_lines import get_journal_lines
from modules.finance.create_account import create_account

from modules.utilities.logger import logger  # Import the logger module

# Create blueprints
finance_get_routes = Blueprint('finance_get_routes', __name__)
finance_post_routes = Blueprint('finance_post_routes', __name__)

# GET routes -----------------------------------------------------
@finance_get_routes.route('/get_accounts', methods=['GET'])
def get_all_accounts():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to get Accounts")
    return get_accounts()

@finance_get_routes.route('/get_journal_headers', methods=['GET'])
def get_journal_headers_all():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to get Journal Headers")
    return get_journal_headers()

@finance_get_routes.route('/get_journal_lines', methods=['GET'])
def get_journal_lines_all():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to get Journal Lines")
    return get_journal_lines()

# POST routes -----------------------------------------------------
@finance_post_routes.route('/create_account', methods=['POST'])
def create_account_data():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to crete account")
    return create_account()

# PUT Methods -----------------------------------------------------------

# DELETE Methods ---------------------------------------------------------


# Register blueprints
def register_finance_routes(app):
    app.register_blueprint(finance_get_routes)
    app.register_blueprint(finance_post_routes)
