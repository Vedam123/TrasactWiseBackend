import json
from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection

create_ui_config_data_api = Blueprint('create_ui_config_data_api', __name__)

@create_ui_config_data_api.route('/create_ui_config_data', methods=['POST'])
def create_ui_config_data():
    mydb = get_database_connection() 

    if request.content_type == 'application/json':
        data = request.get_json()
    else:
        data = request.form

    try:
        config_key = data.get('config_key')
        config_value = data.get('config_value')

        if not config_key or not config_value:
            return jsonify({'error': 'Both config_key and config_value are required'}), 400

        mycursor = mydb.cursor()

        # Insert the UI configuration data into the database
        query = "INSERT INTO adm.ui_config_data (config_key, config_value) VALUES (%s, %s)"
        values = (config_key, config_value)

        mycursor.execute(query, values)
        mydb.commit()

        # Close the cursor and connection
        mycursor.close()
        mydb.close()

        return jsonify({'message': 'UI configuration data created successfully'})

    except Exception as e:
        # Close the cursor and connection
        mycursor.close()
        mydb.close()
        return jsonify({'error': str(e)}), 500
