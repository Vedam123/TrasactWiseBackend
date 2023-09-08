from flask import jsonify, Blueprint
from modules.admin.list_ui_config_data import list_ui_config_data
from modules.admin.create_ui_config_data import create_ui_config_data

list_admin_module = Blueprint('list_admin_module', __name__)


#GET Methods ---------------------------------------------------------
@list_admin_module.route('/list_ui_config_data', methods=['GET'])
def list_ui_config_info():
    print("Front end setups are going to be retrieved")
    return list_ui_config_data()

#POST Methods ----------------------------------------------------------
@list_admin_module.route('/create_ui_config_data', methods=['POST'])
def create_ui_config_info():
    print("Front end setups are going to be inserted")
    return create_ui_config_data()
#PUT Methods -----------------------------------------------------------

#DELETE Methods ---------------------------------------------------------

def register_admin_module_routes(app):
    app.register_blueprint(list_admin_module)