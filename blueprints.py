# Importing with aliases for better readability
from modules.employee.routes.get_employee_routes import register_employee_routes as register_employee
from modules.security.routes.security_routes import register_security_routes as register_security
from modules.products.routes.item_routes import register_item_routes as register_items
from modules.common.routes.common_routes import register_common_module_routes as register_common
from modules.admin.routes.admin_routes import register_admin_module_routes as register_admin


def register_blueprints(app):
    # Registering blueprints with aliases
    register_employee(app)
    register_security(app)
    register_items(app)
    register_common(app)
    register_admin(app)

