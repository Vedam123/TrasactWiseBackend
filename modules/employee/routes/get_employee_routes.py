from flask import jsonify, Blueprint
from modules.employee.get_employee_data import get_employee_data
from modules.employee.get_designations_data import get_designations_data
from modules.employee.create_employee_data import create_employee_data
from modules.employee.update_employee_data import update_employee_data
from modules.utilities.logger import logger  # Import the logger module

get_employees_route = Blueprint('get_employees_route', __name__)
create_employee_route = Blueprint('create_employee_route', __name__)
update_employee_route = Blueprint('update_employee_route', __name__)

# GET Methods ----------------------------------------------------------
@get_employees_route.route('/', methods=['GET'])
@get_employees_route.route('/employee', methods=['GET'])
def get_employees():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Employees are going to be retrieved")
    return get_employee_data()

@get_employees_route.route('/designations', methods=['GET'])
def get_designations():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Designations are going to be retrieved")
    return get_designations_data()

# POST Methods ----------------------------------------------------------

@create_employee_route.route('/create_employee', methods=['POST'])
def create_employee():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Employee is going to be created")
    return create_employee_data()


# PUT Methods ----------------------------------------------------------

@update_employee_route.route('/update_employee', methods=['PUT'])
def update_employee():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Employee is going to be updated")
    return update_employee_data()

def register_employee_routes(app):
    app.register_blueprint(get_employees_route)
    app.register_blueprint(create_employee_route)
    app.register_blueprint(update_employee_route)
