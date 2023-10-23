from flask import Blueprint, jsonify,request
import base64
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
#from configure_logging import configure_logging
from modules.security.get_user_from_token import get_user_from_token
from datetime import date, datetime

# Get a logger for this module
#logger = configure_logging()

get_employee_data_api = Blueprint('get_employee_data_api', __name__)

@get_employee_data_api.route('/employee/get_employee_data', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_employee_data():
    MODULE_NAME = __name__ 
    token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None
    USER_ID = token_results['username']
 #   logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the get partner data function")

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
            if isinstance(date, datetime):
                value = str(value)
            employee_dict[column_name] = value

        employees.append(employee_dict)

    # Close the cursor and connection
    mycursor.close()
    mydb.close()

    return jsonify(employees)
