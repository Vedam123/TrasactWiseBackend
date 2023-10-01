from flask import Blueprint, jsonify
from modules.admin.databases.mydb import get_database_connection
from datetime import datetime
from modules.security.permission_required import permission_required  # Import the decorator
from config import READ_ACCESS_TYPE  # Import READ_ACCESS_TYPE

list_users_api = Blueprint('list_users_api', __name__)

@list_users_api.route('/users', methods=['GET'])
@permission_required(READ_ACCESS_TYPE ,  __file__)  # Pass READ_ACCESS_TYPE as an argument
def list_users():
    mydb = get_database_connection()

    # Retrieve all users from the database
    query = "SELECT * FROM adm.users"
    mycursor = mydb.cursor()
    mycursor.execute(query)
    users = mycursor.fetchall()

    # Convert the user data into a list of dictionaries
    user_list = []
    for data in users:

        user_dict = {
            'id': data[0],
            'username': data[1],
            'password': data[2],
            'empid': data[3],
            'emailid': data[4],
            'created_at': data[5] 
        }
        user_list.append(user_dict)

    # Close the cursor and connection
    mycursor.close()
    mydb.close()
    
    # Return the list of users as JSON response
    return jsonify({'users': user_list})
