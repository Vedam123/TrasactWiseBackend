from flask import Blueprint, jsonify, current_app, request
import os
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required  # Import the decorator
from config import READ_ACCESS_TYPE  # Import READ_ACCESS_TYPE
from flask_jwt_extended import decode_token

fetch_module_data_api = Blueprint('fetch_module_data_api', __name__)

# Function to fetch folder names
def get_module_names():
    try:
        folder_names = []
        root_directory = current_app.root_path
        modules_path = os.path.join(root_directory,'modules')
        #modules_path = os.path.join(root_directory)     
        #modules_path = root_directory   
        print("Module path ",modules_path)   
        print("Roote  path ",root_directory) 
        for folder in os.listdir(modules_path):
            if os.path.isdir(os.path.join(modules_path, folder)):
                folder_names.append(folder)
        return folder_names
    except Exception as e:
        print("Error fetching module names:", e)
        return []

# Function to store folder names in the database
def store_module_names(folder_names):
    try:
        print("Connecting to DB and storing the folders ")
        mydb = get_database_connection()
        mycursor = mydb.cursor()

        current_userid = None
        authorization_header = request.headers.get('Authorization', '')
        if authorization_header.startswith('Bearer '):
            token = authorization_header.replace('Bearer ', '')
            decoded_token = decode_token(token)
            current_userid = decoded_token.get('Userid')

        # Drop the adm.modules table if it exists
        mycursor.execute("DROP TABLE IF EXISTS adm.modules")

        # Create the adm.modules table again
        mycursor.execute("""
            CREATE TABLE adm.modules (
            id INT PRIMARY KEY AUTO_INCREMENT,
            folder_name VARCHAR(100) NOT NULL,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
            created_by INT,
            updated_by INT
        ) AUTO_INCREMENT = 10;
        """)

        for folder_name in folder_names:
            sql = "INSERT INTO adm.modules (folder_name, created_by, updated_by) VALUES (%s, %s, %s)"
            values = (folder_name, current_userid, current_userid)
            mycursor.execute(sql, values)

        mydb.commit()
        mycursor.close()
        mydb.close()
        return True
    except Exception as e:
        print("Error storing module names:", e)
        return False

@fetch_module_data_api.route('/fetch_module', methods=['GET'])
@permission_required(READ_ACCESS_TYPE ,  __file__)  # Pass READ_ACCESS_TYPE as an argument
def fetch_module():
    try:
        folders = get_module_names()
        if store_module_names(folders):
            return jsonify({'message': 'The modules are inserted in DB successfully'}), 200
        else:
            return jsonify({'message': 'Failed to insert modules in DB.'}), 500
    except Exception as e:
        return jsonify({'message': 'An error occurred while processing the request.'}), 500

