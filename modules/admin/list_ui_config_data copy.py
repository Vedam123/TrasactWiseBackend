from flask import Blueprint, jsonify
from modules.admin.databases.mydb import get_database_connection

config_data_api = Blueprint('config_data_api', __name__)

@config_data_api.route('/list_ui_config_data', methods=['GET'])
def list_ui_config_data():
    mydb = get_database_connection()  # Replace with your database connection function

    try:
        # Retrieve key-value pairs from the database
        query = "SELECT config_key, config_value FROM adm.ui_config_data"
        mycursor = mydb.cursor()
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

        # Close the cursor and connection
        mycursor.close()
        mydb.close()

        # Return the list of key-value pairs as JSON response
        return jsonify(config_list)

    except Exception as e:
        return jsonify({'error': str(e)})
