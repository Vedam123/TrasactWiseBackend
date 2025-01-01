from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger

create_department_api = Blueprint('create_department_api', __name__)

@create_department_api.route('/create_department', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_department():
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

        # Log the received data
        logger.debug(f"{appuser} --> {__name__}: Received data: {data}")

        company_id = data['company_id']
        department_name = data['department_name']
        manager_id = data.get('manager_id')
        description = data.get('description')
        account_group_id = data.get('account_group_id')
        if account_group_id == '':
            account_group_id = None
        created_by = appuserid
        updated_by = appuserid

        # Log parsed data
        logger.debug(f"{appuser} --> {__name__}: Parsed Company ID: {company_id}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Department Name: {department_name}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Manager ID: {manager_id}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Description: {description}")

        mycursor = mydb.cursor()

        try:
            query = """
                INSERT INTO com.department (company_id, department_name, manager_id, description, default_account_header_id, created_by, updated_by)
                VALUES (%s, %s, %s, %s, %s, %s, %s)
            """
            values = (company_id, department_name, manager_id, description, account_group_id, created_by, updated_by)

            mycursor.execute(query, values)
            mydb.commit()

            # Log success and close the cursor and connection
            logger.info(f"{appuser} --> {__name__}: Department data created successfully")
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Department data created successfully'}), 200

        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{appuser} --> {__name__}: Unable to create department data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500
    except Exception as e:
        # Log any exceptions
        logger.error(f"{appuser} --> {__name__}: An error occurred : {str(e)}")
        return jsonify({'error': str(e)}), 500
