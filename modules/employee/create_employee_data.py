import json
from flask import Blueprint, jsonify, request
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger  # Import the logger module

create_employee_data_api = Blueprint('create_employee_data_api', __name__)

@create_employee_data_api.route('/employee/create_employee_data', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_employee_data():
    try:
        authorization_header = request.headers.get('Authorization')

        try:
            company, instance, dbuser, mydb, appuser, appuserid, user_info, employee_info = get_user_and_db_details(authorization_header)
            logger.debug(f"{appuser} --> {__name__}: Successfully retrieved user details from the token.")
        except ValueError as e:
            logger.error(f"Failed to retrieve user details from token. Error: {str(e)}")
            return jsonify({"error": str(e)}), 401
        
        if not appuser:
            logger.error(f"Unauthorized access attempt: {appuser} --> {__name__}: Application user not found.")
            return jsonify({"error": "Unauthorized. Username not found."}), 401

        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form
        
        #required_fields = ['name', 'manager_id', 'supervisor_id', 'designation_id', 'dob', 'doj']
        required_fields = ['name',  'designation_id', 'dob', 'doj']
        if not all(field in data for field in required_fields):
            return jsonify({'error': 'Missing required fields'}), 400

        # Extract new fields (resignation_date, status)
        resignation_date = data.get('resignation_date', None)  # Default to None if not provided
        status = data.get('status', True)  # Default to True (active) if not provided
        status = bool(status)  # Convert status to boolean (0 -> False, 1 -> True)

        logger.debug(f"{appuser} --> {__name__}: Parsed Employee status: {status}")

        logger.debug(f"{appuser} --> {__name__}: Received data: {json.dumps(data)}")
        print("Data reached to backend", data)

        name = data['name']
        # Extract fields from request data
        manager_id = data.get('manager_id', None)

        # If manager_id is an empty string, set it to None
        if manager_id == '':
            manager_id = None

        supervisor_id = data.get('supervisor_id', None)
        if supervisor_id == '':
            supervisor_id = None
        pic = request.files['pic'] if 'pic' in request.files else None
        pic_data = pic.read() if pic else None
        designation_id = data['designation_id']
        dob = data['dob']
        doj = data['doj']

        salary = data.get('salary', None)

        # If salary is an empty string or invalid, set it to 0.0 (or None if your DB allows NULL)
        if salary == '' or salary is None:
            salary = 0.0
        else:
            try:
                salary = float(salary)  # Convert salary to a float
            except ValueError:
                salary = 0.0  # Default to 0.0 if salary cannot be converted to float

        # Log parsed data
        logger.debug(f"{appuser} --> {__name__}: Parsed Employee name: {name}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Employee manager: {manager_id}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Employee supervisor: {supervisor_id}")

        if pic:
            logger.debug(f"{appuser} --> {__name__}: Parsed Employee pic: File detected")
        else:
            logger.debug(f"{appuser} --> {__name__}: Parsed Employee pic: Empty")

        logger.debug(f"{appuser} --> {__name__}: Parsed Employee salary: {salary}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Employee role: {designation_id}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Employee dob: {dob}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Employee doj: {doj}")

        with mydb.cursor() as mycursor:
            try:
                # Query to insert employee data into the database
                query = """
                    INSERT INTO com.employee (name, manager_id, supervisor_id, pic, salary, designation_id, dob, doj, resignation_date, status, created_by, updated_by)
                    VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
                """
                
                # If resignation_date is None or empty, ensure it is treated as NULL for the database
                resignation_date = None if resignation_date in [None, '', 'null'] else resignation_date

                values = (name, manager_id, supervisor_id, pic_data, salary, designation_id, dob, doj, resignation_date, status, appuserid, appuserid)

                mycursor.execute(query, values)
                mydb.commit()

                # Log success message
                logger.info(f"{appuser} --> {__name__}: Employee data created successfully")

                return jsonify({'message': 'Employee data created successfully'})
            except Exception as e:
                # Log error message
                logger.error(f"{appuser} --> {__name__}: Unable to create employee data: {str(e)}")
                return jsonify({'error': str(e)}), 500
    except Exception as e:
        # Log any exceptions
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
