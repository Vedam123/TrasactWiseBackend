from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required  # Import the decorator
from config import READ_ACCESS_TYPE  # Import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token

config_data_api = Blueprint('config_data_api', __name__)

@config_data_api.route('/list_ui_config_data', methods=['GET'])
@permission_required(READ_ACCESS_TYPE ,  __file__)  # Pass READ_ACCESS_TYPE as an argument
def list_ui_config_data():

    authorization_header = request.headers.get('Authorization')
    token_results = ""
    USER_ID = ""
    MODULE_NAME = __name__
    if authorization_header:
        token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None

    if token_results:
        USER_ID = token_results["username"]
    mydb = get_database_connection(USER_ID, MODULE_NAME)

    config_key = request.args.get('config_key')  # Get the config_key query parameter

    try:
        mycursor = mydb.cursor()

        if config_key is not None:
            # If config_key is provided, search for a specific key
            query = "SELECT config_key, config_value FROM adm.ui_config_data WHERE config_key like %s"
            print(config_key)
            mycursor.execute(query, ('%' + config_key + '%',))
            ##mycursor.execute(query, (config_key,))
        else:
            # If no config_key is provided, fetch all data
            query = "SELECT config_key, config_value FROM adm.ui_config_data"
            mycursor.execute(query)

        config_data = mycursor.fetchall()

        # Convert the data into a list of dictionaries
        config_list = []
        for data in config_data:
            config_dict = {
                'config_key': data[0],
                'config_value': data[1]
            }
            config_list.append(config_dict)

        mycursor.close()
        mydb.close()

        # Return the list of key-value pairs as JSON response
        return jsonify(config_list)

    except Exception as e:
        return jsonify({'error': str(e)})
