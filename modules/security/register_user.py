from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
import bcrypt
from modules.security.permission_required import permission_required  # Import the decorator
from config import WRITE_ACCESS_TYPE   #Import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token

register_data_api = Blueprint('register_data_api', __name__)

@register_data_api.route('/register', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE ,  __file__)  # Pass READ_ACCESS_TYPE as an argument
def register():
    mydb = get_database_connection()

    # Retrieve user registration data from the request
    currentuserid = decode_token(request.headers.get('Authorization', '').replace('Bearer ', '')).get('Userid') if request.headers.get('Authorization', '').startswith('Bearer ') else None    
    username = request.json['username']
    password = request.json['password']
    print(request.json['empid'])
    
    # Check if email exists in the JSON request
    if 'emailid' in request.json:
        emailid = request.json['emailid']
    else:
        emailid = None

    if 'empid' in request.json:
        empid = request.json['empid']
    elif 'empid' in request.form:
        empid = request.form['empid']
    else:
        empid = None

    print("Before select statement ",request.json['empid'])

    # Validate and sanitize user input

    # Hash and store the user's password securely in the database
    hashed_password = bcrypt.hashpw(password.encode('utf-8'), bcrypt.gensalt())

    # Save the user data to the database
    # Assuming you have a 'users' table with columns 'username', 'password', 'empid', and 'emailid'
    query = "INSERT INTO adm.users (username, password, empid, emailid,created_by,updated_by) VALUES (%s, %s, %s, %s,%s,%s)"
    values = (username, hashed_password, empid, emailid,currentuserid,currentuserid)
    mycursor = mydb.cursor()
    mycursor.execute(query, values)
    mydb.commit()

    # Return success message along with username, empid, and emailid
    response = {
        'message': 'Registration successful',
        'username': username,
        'empid': empid,
        'emailid': emailid
    }

    # Close the cursor and connection
    mycursor.close()
    mydb.close()
     
    return jsonify(response)
