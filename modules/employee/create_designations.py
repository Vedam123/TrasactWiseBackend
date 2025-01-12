import json
from flask import Blueprint, jsonify, request
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger  # Import the logger module

create_designations_data_api = Blueprint('create_designation_data_api', __name__)

@create_designations_data_api.route('/designation/create_designation', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_designations():

    try:
        authorization_header = request.headers.get('Authorization')

        try:
            company, instance, dbuser, mydb, appuser, appuserid, user_info , employee_info = get_user_and_db_details(authorization_header)
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

        print("Reached to a point")
        
        required_fields = ['designation_name', 'description', 'salary_range']
        if not all(field in data for field in required_fields):
            return jsonify({'error': 'Missing required fields'}), 400

        designation_name = data['designation_name']
        description = data['description']
        salary_range = data['salary_range']
        responsibilities = data.get('responsibilities', None)  # Optional field
        qualifications = data.get('qualifications', None)  # Optional field

        logger.debug(f"{appuser} --> {__name__}: Received data: {json.dumps(data)}")

        print("Input values ",designation_name,description,salary_range,responsibilities,qualifications)

        with mydb.cursor() as mycursor:
            try:
                query = """
                    INSERT INTO com.designations (designation_name, description, salary_range, responsibilities, qualifications, created_by, updated_by)
                    VALUES (%s, %s, %s, %s, %s, %s, %s)
                """
                values = (designation_name, description, salary_range, responsibilities, qualifications, appuserid, appuserid)

                mycursor.execute(query, values)
                mydb.commit()

                logger.info(f"{appuser} --> {__name__}: Designation created successfully")

                return jsonify({'message': 'Designation created successfully'}), 201
            except Exception as e:
                logger.error(f"{appuser} --> {__name__}: Unable to create designation: {str(e)}")
                return jsonify({'error': str(e)}), 500
    except Exception as e:
        logger.error(f"An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
