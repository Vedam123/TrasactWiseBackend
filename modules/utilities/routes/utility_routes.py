from flask import Blueprint
from modules.utilities.Tools.get_files import get_files
from modules.utilities.logger import logger  # Import the logger module


# Create blueprints
get_utility_routes = Blueprint('get_utility_routes', __name__)


# GET routes -----------------------------------------------------
@get_utility_routes.route('/get_files', methods=['GET'])
def get_files_all():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to get get_utility_routes")
    return get_files()


# Register blueprints
def register_utility_routes(app):
    app.register_blueprint(get_utility_routes)

