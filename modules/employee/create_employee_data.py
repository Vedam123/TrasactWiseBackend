import json
from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger  # Import the logger module

create_employee_data_api = Blueprint('create_employee_data_api', __name__)

# ... (previous imports)

@create_employee_data_api.route('/employee/create_employee_data', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_employee_data():
    try:
        authorization_header = request.headers.get('Authorization')
        token_results = ""
        USER_ID = ""
        MODULE_NAME = __name__
        if authorization_header:
            token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get(
                'Authorization') else None

        if token_results:
            USER_ID = token_results["username"]

        # Log entry point
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the Create employee data function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)
        currentuserid = decode_token(
            request.headers.get('Authorization', '').replace('Bearer ', '')).get('Userid') if request.headers.get(
            'Authorization', '').startswith('Bearer ') else None

        print("Fetched Current user id ", currentuserid)

        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        required_fields = ['name', 'manager', 'supervisor', 'role', 'dob', 'doj']
        if not all(field in data for field in required_fields):
            return jsonify({'error': 'Missing required fields'}), 400

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Received data: {json.dumps(data)}")
        print("Data reached to backend", data)
        name = data['name']
        manager = data['manager']
        supervisor = data['supervisor']
        pic = request.files['pic'] if 'pic' in request.files else None
        pic_data = pic.read() if pic else None
        salary = data.get('salary')
        if salary == '' :
            salary = 0
        role = data['role']
        dob = data['dob']
        doj = data['doj']

        # Log parsed data
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Employee name: {name}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Employee manager: {manager}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Employee supervisor: {supervisor}")

        if pic:
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Employee pic: File detected")
        else:
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Employee pic: Empty")

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Employee salary: {salary}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Employee role: {role}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Employee dob: {dob}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Employee doj: {doj}")
        print("complete insert data ",name, manager, supervisor, salary, role, dob, doj, currentuserid, currentuserid)
        with mydb.cursor() as mycursor:
            try:
                query = "INSERT INTO com.employee (name, manager, supervisor, pic, salary, role, dob, doj, created_by, updated_by) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
                values = (name, manager, supervisor, pic_data, salary, role, dob, doj, currentuserid, currentuserid)

                mycursor.execute(query, values)
                mydb.commit()

                # Log success message
                logger.info(f"{USER_ID} --> {MODULE_NAME}: Employee data created successfully")

                return jsonify({'message': 'Employee data created successfully'})
            except Exception as e:
                # Log error message
                logger.error(f"{USER_ID} --> {MODULE_NAME}: Unable to create employee data: {str(e)}")
                return jsonify({'error': str(e)}), 500
    except Exception as e:
        # Log any exceptions
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
