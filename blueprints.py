from modules.employee.routes.get_employee_routes import register_employee_routes as register_employee
from modules.security.routes.security_routes import register_security_routes as register_security
from modules.products.routes.item_routes import register_item_routes as register_items
from modules.common.routes.common_routes import register_common_module_routes as register_common
from modules.admin.routes.admin_routes import register_admin_module_routes as register_admin
from modules.finance.routes.finance_routes import register_finance_routes as register_finance
from modules.inventory.routes.Inventory_routes import register_inventory_routes as register_inventory
from modules.purchase.routes.purchase_routes import register_purchase_routes as register_purchase

def register_blueprints(app):
    register_employee(app)
    register_security(app)
    register_items(app)
    register_common(app)
    register_admin(app)
    register_finance(app)
    register_inventory(app)
    register_purchase(app)

