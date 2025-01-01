from flask import Blueprint
from modules.finance.get_accounts import get_accounts
from modules.finance.get_journal_headers import get_journal_headers
from modules.finance.get_journal_lines import get_journal_lines
from modules.finance.create_account import create_account
from modules.finance.create_journal_header import create_journal_header
from modules.finance.create_journal_lines import create_journal_line
from modules.finance.create_purchase_invoice import create_purchase_invoice
from modules.finance.create_purchase_invoice_lines import create_purchase_invoice_lines
from modules.finance.distribute_invoice_to_accounts import distribute_invoice_to_accounts
from modules.finance.get_purchase_invoice_details import get_purchase_invoice_details
from modules.finance.get_purchase_invoice_lines import get_purchase_invoice_lines
from modules.finance.get_invoice_distributions import get_invoice_distributions
from modules.finance.update_purchase_invoice import update_purchase_invoice
from modules.finance.update_purchase_invoice_lines import update_purchase_invoice_lines
from modules.finance.delete_purchase_invoice_lines import delete_purchase_invoice_lines
from modules.finance.delete_purchase_invoice_account import delete_purchase_invoice_account
from modules.finance.update_invoice_accounts import update_invoice_accounts
from modules.finance.validate_po_invoice import validate_po_invoice
from modules.finance.create_sales_invoice import create_sales_invoice
from modules.finance.update_sales_invoice import update_sales_invoice
from modules.finance.get_sales_invoice_details import get_sales_invoice_details
from modules.finance.create_sales_invoice_lines import create_sales_invoice_lines
from modules.finance.updated_sales_invoice_lines import update_sales_invoice_lines
from modules.finance.distribute_sales_invoice_to_accounts import distribute_sales_invoice_to_accounts
from modules.finance.update_sales_invoice_accounts import update_sales_invoice_accounts
from modules.finance.delete_sales_invoice_lines import delete_sales_invoice_lines
from modules.finance.delete_sales_invoice_account import delete_sales_invoice_account
from modules.finance.validate_sales_invoice import validate_sales_invoice
from modules.finance.get_sales_invoice_distributions import get_sales_invoice_accounts
from modules.finance.get_default_accounts import get_default_accounts
from modules.finance.get_sales_invoice_lines import get_sales_invoice_lines
from modules.finance.create_default_account import create_default_account
from modules.finance.create_default_account_headers import create_default_account_headers
from modules.finance.get_default_accounts_combined import get_default_accounts_combined

from modules.finance.get_default_account_headers import get_default_account_headers
from modules.finance.auto_create_journal import auto_create_journal
from modules.finance.update_journal_header import update_journal_header
from modules.finance.update_journal_line import update_journal_line
from modules.finance.delete_journal_line import delete_journal_line
from modules.finance.validate_journal import validate_journal


from modules.utilities.logger import logger  # Import the logger module

# Create blueprints
finance_get_routes = Blueprint('finance_get_routes', __name__)
finance_post_routes = Blueprint('finance_post_routes', __name__)
finance_update_routes = Blueprint('finance_update_routes', __name__)
finance_delete_routes = Blueprint('finance_delete_routes', __name__)

# GET routes -----------------------------------------------------
@finance_get_routes.route('/get_accounts', methods=['GET'])
def get_all_accounts():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Request to get Accounts")
    return get_accounts()

@finance_get_routes.route('/get_journal_headers', methods=['GET'])
def get_journal_headers_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Request to get Journal Headers")
    return get_journal_headers()

@finance_get_routes.route('/get_journal_lines', methods=['GET'])
def get_journal_lines_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Request to get Journal Lines")
    return get_journal_lines()

@finance_get_routes.route('/get_po_invoices', methods=['GET'])
def get_purchase_invoice_details_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Request to get purchase Invoice headers")
    return get_purchase_invoice_details()

@finance_get_routes.route('/get_po_invoice_lines', methods=['GET'])
def get_purchase_invoice_lines_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Request to get purchase Invoice Lines")
    return get_purchase_invoice_lines()

@finance_get_routes.route('/get_po_invoice_distributions', methods=['GET'])
def get_invoice_distributions_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Request to get invoice distributions")
    return get_invoice_distributions()

@finance_get_routes.route('/validate_po_invoice', methods=['GET'])
def validate_po_invoice_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Validate PO Invoice")
    return validate_po_invoice()

@finance_get_routes.route('/get_so_invoices', methods=['GET'])
def get_sales_invoice_details_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Request to get Sales Invoices")
    return get_sales_invoice_details()

@finance_get_routes.route('/validate_sales_invoice', methods=['GET'])
def validate_sales_invoice_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Validate sales Invoice")
    return validate_sales_invoice()


@finance_get_routes.route('/get_sales_invoice_distributions', methods=['GET'])
def get_sales_invoice_accounts_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Get sales Invoice accounts")
    return get_sales_invoice_accounts()

@finance_get_routes.route('/get_sales_invoice_lines', methods=['GET'])
def get_sales_invoice_lines_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Get sales Invoice lines")
    return get_sales_invoice_lines()

@finance_get_routes.route('/get_default_accounts', methods=['GET'])
def get_default_accounts_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Get Default accounts")
    return get_default_accounts()

@finance_get_routes.route('/get_default_accounts_combined', methods=['GET'])
def get_default_accounts_combined_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Get Default account headers all combined")
    return get_default_accounts_combined()



@finance_get_routes.route('/get_default_account_headers', methods=['GET'])
def get_default_account_headers_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Get get_default_account_headers")
    return get_default_account_headers()

@finance_get_routes.route('/validate_journal', methods=['GET'])
def validate_journal_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Get validate_journal")
    return validate_journal()

# POST routes -----------------------------------------------------
@finance_post_routes.route('/create_account', methods=['POST'])
def create_account_data():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Request to crete account")
    return create_account()

@finance_post_routes.route('/create_journal_header', methods=['POST'])
def create_journal_header_All():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Request to crete Journal Header")
    return create_journal_header()

@finance_post_routes.route('/create_journal_line', methods=['POST'])
def create_journal_line_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Request to crete Journal Lines")
    return create_journal_line()

@finance_post_routes.route('/create_po_invoice', methods=['POST'])
def create_purchase_invoice_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Request to crete Purchase Invoice Header")
    return create_purchase_invoice()

@finance_post_routes.route('/create_po_invoice_lines', methods=['POST'])
def create_purchase_invoice_lines_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Request to crete Purchase Invoice Lines")
    return create_purchase_invoice_lines()

@finance_post_routes.route('/distribute_invoice_to_accounts', methods=['POST'])
def distribute_invoice_to_accounts_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Request to Distribute Invoice to accounts")
    return distribute_invoice_to_accounts()

@finance_post_routes.route('/create_sales_invoice', methods=['POST'])
def create_sales_invoices_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Create Sales Invoices")
    return create_sales_invoice()

@finance_post_routes.route('/create_sales_invoice_lines', methods=['POST'])
def create_sales_invoice_lines_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Create Sales Invoice lines")
    return create_sales_invoice_lines()

@finance_post_routes.route('/distribute_sales_invoice_to_accounts', methods=['POST'])
def distribute_sales_invoice_to_accounts_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Distribute Sales Invoice Accounts")
    return distribute_sales_invoice_to_accounts()

@finance_post_routes.route('/create_default_account', methods=['POST'])
def create_default_accounts_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Create Default Accounts from Company or Departement Accounts")
    return create_default_account()

@finance_post_routes.route('/create_default_account_headers', methods=['POST'])
def create_default_account_headers_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Create Default Account Headers from Company or Departement Accounts")
    return create_default_account_headers()




@finance_post_routes.route('/auto_create_journal', methods=['POST'])
def auto_create_journal_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Request to auto_create_journal accounts")
    return auto_create_journal()

# PUT Methods -----------------------------------------------------------

@finance_update_routes.route('/update_purchase_invoice', methods=['PUT'])
def update_purchase_invoice_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Request to update Purchase Invoice Header")
    return update_purchase_invoice()


@finance_update_routes.route('/update_purchase_invoice_lines', methods=['PUT'])
def update_purchase_invoice_lines_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Request to update Purchase Invoice Lines")
    return update_purchase_invoice_lines()

@finance_update_routes.route('/update_invoice_accounts', methods=['PUT'])
def update_invoice_accounts_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: update invoice accounts")
    return update_invoice_accounts()

@finance_update_routes.route('/update_sales_invoice', methods=['PUT'])
def update_sales_invoice_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: update sales invoice ")
    return update_sales_invoice()

@finance_update_routes.route('/update_sales_invoice_lines', methods=['PUT'])
def update_sales_invoice_lines_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: update sales invoice lines ")
    return update_sales_invoice_lines()

@finance_update_routes.route('/update_sales_invoice_accounts', methods=['PUT'])
def update_sales_invoice_accounts_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: update sales invoice accounts ")
    return update_sales_invoice_accounts()

@finance_update_routes.route('/update_journal_header', methods=['PUT'])
def update_journal_headers_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Request to update Journal Headers")
    return update_journal_header()

@finance_update_routes.route('/update_journal_line', methods=['PUT'])
def update_journal_line_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Request to  update_journal_line")
    return update_journal_line()

# DELETE Methods ---------------------------------------------------------

@finance_delete_routes.route('/delete_purchase_invoice_lines', methods=['DELETE'])
def delete_purchase_invoice_lines_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Request to Delete Invoice Lines")
    return delete_purchase_invoice_lines()

@finance_delete_routes.route('/delete_purchase_invoice_account', methods=['DELETE'])
def delete_purchase_invoice_one_account():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Request to delete accounts")
    return delete_purchase_invoice_account()

@finance_delete_routes.route('/delete_sales_invoice_lines', methods=['DELETE'])
def delete_sales_invoice_lines_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Request to delete sales invoice lines")
    return delete_sales_invoice_lines()


@finance_delete_routes.route('/delete_sales_invoice_account', methods=['DELETE'])
def delete_sales_invoice_account_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Request to delete sales invoice accounts")
    return delete_sales_invoice_account()

@finance_delete_routes.route('/delete_journal_line', methods=['DELETE'])
def delete_journal_line_all():
    
    appuser = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{appuser} --> {__name__}: Request to delete_journal_line")
    return delete_journal_line()





# Register blueprints
def register_finance_routes(app):
    app.register_blueprint(finance_get_routes)
    app.register_blueprint(finance_post_routes)
    app.register_blueprint(finance_update_routes)
    app.register_blueprint(finance_delete_routes)
