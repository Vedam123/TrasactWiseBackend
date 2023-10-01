from flask import Blueprint, jsonify
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required  # Import the decorator
from config import READ_ACCESS_TYPE  # Import READ_ACCESS_TYPE

list_db_config_data_api = Blueprint('list_db_config_data_api', __name__)

@list_db_config_data_api.route('/list_db_config_data', methods=['GET'])
@permission_required(READ_ACCESS_TYPE ,  __file__)  # Pass READ_ACCESS_TYPE as an argument
def list_db_config_data():
    mydb = get_database_connection()  # Replace with your database connection function

    try:
        mycursor = mydb.cursor()

        # Fetch data from adm.bk_super_user table
        query = "SELECT userid, username, name, password FROM adm.bk_super_user"
        mycursor.execute(query)
        user_data = mycursor.fetchall()

        # Fetch data from adm.bk_configurations table
        query = "SELECT config_key, config_value FROM adm.bk_configurations"
        mycursor.execute(query)
        config_data = mycursor.fetchall()

        mycursor.close()
        mydb.close()

        # Combine user and configuration data into a single dictionary
        result = {}

        if user_data:
            result['user_data'] = []
            for user_row in user_data:
                user_dict = {
                    'userid': user_row[0],
                    'username': user_row[1],
                    'name': user_row[2],
                    'password': user_row[3]
                }
                result['user_data'].append(user_dict)

        if config_data:
            result['config_data'] = []
            for config_row in config_data:
                config_dict = {
                    'config_key': config_row[0],
                    'config_value': config_row[1]
                }
                result['config_data'].append(config_dict)

        # Return the combined data as JSON response
        return jsonify(result)

    except Exception as e:
        return jsonify({'error': str(e)})
