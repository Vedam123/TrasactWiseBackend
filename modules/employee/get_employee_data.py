from flask import Blueprint, jsonify
import base64
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required  # Import the decorator
from config import READ_ACCESS_TYPE  # Import READ_ACCESS_TYPE

get_employee_data_api = Blueprint('get_employee_data_api', __name__)

@get_employee_data_api.route('/employee/get_employee_data', methods=['GET'])
@permission_required(READ_ACCESS_TYPE ,  __file__)  # Pass READ_ACCESS_TYPE as an argument
def get_employee_data():
    mydb = get_database_connection()
    mycursor = mydb.cursor()
    mycursor.execute("SELECT * FROM com.employee")
    result = mycursor.fetchall()
    employees = []
    print("Employee Array defined")

    for row in result:
        empid, name, manager, supervisor, pic, salary, role, dob, doj = row

        # Convert pic to base64 if it is of BLOB type, otherwise leave it as is
        if isinstance(pic, bytes):
            pic = base64.b64encode(pic).decode('utf-8')

        employees.append({
            'empid': empid,
            'name': name,
            'manager': manager,
            'supervisor': supervisor,
            'pic': pic,
            'salary': str(salary),
            'role': role,
            'dob': str(dob),
            'doj': str(doj)
        })
    # Close the cursor and connection
    mycursor.close()
    mydb.close()
    print("Employee Data has been retrieved and appended to the array")
    return jsonify(employees)
