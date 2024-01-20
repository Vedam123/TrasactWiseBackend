from flask import Blueprint, jsonify, request
import base64
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from datetime import date, datetime
from modules.utilities.logger import logger  # Import the logger module

get_employee_data_api = Blueprint('get_employee_data_api', __name__)

@get_employee_data_api.route('/employee', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_employee_data():
    try:
        authorization_header = request.headers.get('Authorization')
        token_results = ""
        USER_ID = ""
        MODULE_NAME = __name__
        if authorization_header:
            token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None

        if token_results:
            USER_ID = token_results["username"]
        print("Inside get Employee data function")
        # Log entry point
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the get employee data function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)
        mycursor = mydb.cursor()

        empid_param = request.args.get('empid')

        # Validate empid_param to ensure it is a valid integer
        if empid_param and not empid_param.isdigit():
            return jsonify({'error': 'Invalid empid parameter'}), 400

        if empid_param:
            query = f"""
                SELECT e.*, m.name AS manager_name, s.name AS supervisor_name, d.designation_name
                FROM com.employee e
                LEFT JOIN com.employee m ON e.manager_id = m.empid
                LEFT JOIN com.employee s ON e.supervisor_id = s.empid
                LEFT JOIN com.designations d ON e.designation_id = d.designation_id
                WHERE e.empid = {empid_param}
            """
        else:
            query = """
                SELECT e.*, m.name AS manager_name, s.name AS supervisor_name, d.designation_name
                FROM com.employee e
                LEFT JOIN com.employee m ON e.manager_id = m.empid
                LEFT JOIN com.employee s ON e.supervisor_id = s.empid
                LEFT JOIN com.designations d ON e.designation_id = d.designation_id
            """

        mycursor.execute(query)
        result = mycursor.fetchall()
        employees = []
        #print("results",result)
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
    except Exception as e:
        # Log any exceptions
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
