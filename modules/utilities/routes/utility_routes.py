from flask import Blueprint
from modules.utilities.Tools.get_file_paths import get_file_paths
from modules.utilities.Tools.download_file import download_file
from modules.utilities.Tools.get_and_download_file import get_and_download_file
from modules.utilities.Tools.download_binary_file import download_binary_file
from modules.utilities.logger import logger  # Import the logger module


# Create blueprints
get_utility_routes = Blueprint('get_utility_routes', __name__)


# GET routes -----------------------------------------------------
@get_utility_routes.route('/get_file_paths', methods=['GET'])
def get_file_paths_all():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to get get_file_paths")
    return get_file_paths()

@get_utility_routes.route('/get_and_download_file', methods=['GET'])
def get_and_download_file_all():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to get get_and_download_file")
    return get_and_download_file()

@get_utility_routes.route('/download_file', methods=['GET'])
def download_file_all():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to get download_file")
    return download_file()


@get_utility_routes.route('/download_binary_file', methods=['GET'])
def download_binary_file_all():
    MODULE_NAME = __name__
    USER_ID = ""  # Replace with the appropriate user ID or identifier
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request to get get_and_download_binary_file")
    return download_binary_file()


# Register blueprints
def register_utility_routes(app):
    app.register_blueprint(get_utility_routes)

