import json
from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required  # Import the decorator
from config import WRITE_ACCESS_TYPE   #Import WRITE_ACCESS_TYPE

create_employee_data_api = Blueprint('create_employee_data_api', __name__)

@create_employee_data_api.route('/employee/create_employee_data', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE ,  __file__)  # Pass READ_ACCESS_TYPE as an argument
def create_employee_data():
    mydb = get_database_connection()

   
    
    if request.content_type == 'application/json':
        data = request.get_json()
    else:
        data = request.form

    print(data)

    name = data['name']
    manager = data['manager']
    supervisor = data['supervisor']
    pic = request.files['pic'] if 'pic' in request.files else None
    pic_data = pic.read() if pic else None
    salary = data['salary']
    role = data['role']
    dob = data['dob']
    doj = data['doj']

    print("Parsed Employee name:", name)
    print("Parsed Employee manager:", manager)
    print("Parsed Employee supervisor:", supervisor)
    if pic:
        print("Parsed Employee pic: File detected")
    else:
        print("Parsed Employee pic: Empty")
    print("Parsed Employee salary:", salary)
    print("Parsed Employee role:", role)
    print("Parsed Employee dob:", dob)
    print("Parsed Employee doj:", doj)

    mycursor = mydb.cursor()

    try:
        query = "INSERT INTO com.employee (name, manager, supervisor, pic, salary, role, dob, doj) VALUES (%s, %s, %s, %s, %s, %s, %s, %s)"
        values = (name, manager, supervisor, pic_data, salary, role, dob, doj)

        mycursor.execute(query, values)
        mydb.commit()
        # Close the cursor and connection
        mycursor.close()
        mydb.close()
        return jsonify({'message': 'Employee data created successfully'})
    except Exception as e:
        # Close the cursor and connection
        mycursor.close()
        mydb.close()
        print("Unable to create employee data:", str(e))
        return jsonify({'error': str(e)}), 500
