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

    print(data)

    try:
        success = False  # Initialize a flag to track success
        success_user = False
        success_config = False

        # Check if all fields have values for adm.bk_super_user table
        if all(data.get(field) for field in ['username', 'name', 'password']):
            print("All user values")
            username = data['username']
            name = data['name']
            password = data['password']

            mycursor = mydb.cursor()
            query = "INSERT INTO adm.bk_super_user (username, name, password) VALUES (%s, %s, %s)"
            values = (username, name, password)
            mycursor.execute(query, values)
            mydb.commit()
            mycursor.close()

            if mycursor.rowcount > 0:
                print("Data successfully inserted in the users table")
                success_user = True  # Table 1 update is successful
            else:
                print("Failed to insert data into the users table")
                success_user = False  # Table 1 update failed
        else:
                print("Not all user values present to insert data into the users table")
                success_user = False  # Table 1 update failed

        # Check if all fields have values for adm.bk_configurations table
        if all(data.get(field) for field in ['config_key', 'config_value']):
            print("All config values")
            config_key = data.get('config_key')
            config_value = data.get('config_value')

            mycursor = mydb.cursor()
            query = "INSERT INTO adm.bk_configurations (config_key, config_value) VALUES (%s, %s)"
            values = (config_key, config_value)
            mycursor.execute(query, values)
            mydb.commit()
            mycursor.close()

            if mycursor.rowcount > 0:
                print("Data successfully inserted in the configuration table")
                success_config = True  # Table 2 update is successful
            else:
                print("Failed to insert data into the configuration table")
                success_config = False  # Table 2 update failed
        else:
            print("Not all config values present to insert data into the users table")
            success_config = False  # Table 1 update failed

        mydb.close()

        if success_user or success_config:
            success = True

        if success:
            return jsonify({'message': 'Data inserted successfully into relevant table(s)'})
        else:
            return jsonify({'error': 'No relevant data provided to insert into any table'}), 400

    except Exception as e:
        mydb.close()
        return jsonify({'error': str(e)}), 500
