import json
from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection

create_db_config_data_api = Blueprint('create_db_config_data_api', __name__)

@create_db_config_data_api.route('/create_db_config_data', methods=['POST'])
def create_db_config_data():
    mydb = get_database_connection() 

    if request.content_type == 'application/json':
        data = request.get_json()
    else:
        data = request.form

    print(data);

    try:
        # Insert data into adm.bk_super_user table
        userid = data.get('userid')
        username = data.get('username')
        name = data.get('name')
        password = data.get('password')
        
        if not userid or not username or not name or not password:
            return jsonify({'error': 'All fields (userid, username, name, password) are required for adm.bk_super_user'}), 400
        
        mycursor = mydb.cursor()
        query = "INSERT INTO adm.bk_super_user (userid, username, name, password) VALUES (%s, %s, %s, %s)"
        values = (userid, username, name, password)
        mycursor.execute(query, values)

        # Insert data into adm.bk_configurations table
        config_key = data.get('config_key')
        config_value = data.get('config_value')

        if not config_key or not config_value:
            return jsonify({'error': 'Both config_key and config_value are required for adm.bk_configurations'}), 400

        query = "INSERT INTO adm.bk_configurations (config_key, config_value) VALUES (%s, %s)"
        values = (config_key, config_value)
        mycursor.execute(query, values)

        mydb.commit()
        mycursor.close()
        mydb.close()

        return jsonify({'message': 'Data inserted successfully into both tables'})

    except Exception as e:
        mycursor.close()
        mydb.close()
        return jsonify({'error': str(e)}), 500
