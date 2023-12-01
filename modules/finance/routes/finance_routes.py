from flask import Blueprint
from modules.finance.get_accounts import get_accounts
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
