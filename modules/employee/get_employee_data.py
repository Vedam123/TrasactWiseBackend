from flask import Blueprint, jsonify
import base64
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from datetime import datetime, date # Corrected import

get_employee_data_api = Blueprint('get_employee_data_api', __name__)

@get_employee_data_api.route('/employee/get_employee_data', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_employee_data():
    mydb = get_database_connection()
    mycursor = mydb.cursor()
    mycursor.execute("SELECT * FROM com.employee")
    result = mycursor.fetchall()
    employees = []

    # Get the column names from the cursor's description
    column_names = [desc[0] for desc in mycursor.description]

    for row in result:
        employee_dict = {}
        for i, value in enumerate(row):
            column_name = column_names[i]
            if column_name == 'pic' and isinstance(value, bytes):
                value = base64.b64encode(value).decode('utf-8')
            if isinstance(value, (date, datetime)):
                value = str(value)
            employee_dict[column_name] = value

        employees.append(employee_dict)

    # Close the cursor and connection
    mycursor.close()
    mydb.close()

    return jsonify(employees)
