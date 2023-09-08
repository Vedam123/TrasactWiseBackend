from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection

config_data_api = Blueprint('config_data_api', __name__)

@config_data_api.route('/list_ui_config_data', methods=['GET'])
def list_ui_config_data():
    mydb = get_database_connection()  # Replace with your database connection function

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
