from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.utilities.logger import logger

department_api = Blueprint('department_api', __name__)

@department_api.route('/update_department', methods=['PUT'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def update_department():
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

        # Retrieve department_id from query parameters
        department_id = request.args.get('department_id', type=int)
        if not department_id:
            logger.error(f"{appuser} --> {__name__}: Missing department_id in query parameters.")
            return jsonify({"error": "department_id is required."}), 400

        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        # Log the received data
        logger.debug(f"{appuser} --> {__name__}: Received data: {data}")

        # Retrieve the parameters from the data
        company_id = data.get('company_id')
        department_name = data.get('department_name')
        manager_id = data.get('manager_id')
        description = data.get('description')
        default_account_header_id = data.get('default_account_header_id')
        updated_by = appuserid

        # Log parsed data
        logger.debug(f"{appuser} --> {__name__}: Parsed Company ID: {company_id}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Department Name: {department_name}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Manager ID: {manager_id}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Description: {description}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Default Account Header ID: {default_account_header_id}")

        mycursor = mydb.cursor()

        try:
            # SQL query for updating the department data
            query = """
                UPDATE com.department
                SET company_id = %s, department_name = %s, manager_id = %s, 
                    description = %s, default_account_header_id = %s, updated_by = %s
                WHERE id = %s
            """
            values = (
                company_id, department_name, manager_id, description, 
                default_account_header_id, updated_by, department_id
            )

            mycursor.execute(query, values)
            mydb.commit()

            # Check if the record was updated
            if mycursor.rowcount == 0:
                logger.error(f"{appuser} --> {__name__}: Department with ID {department_id} not found.")
                return jsonify({"error": f"Department with ID {department_id} not found."}), 404

            # Log success and close the cursor and connection
            logger.info(f"{appuser} --> {__name__}: Department data updated successfully")
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Department data updated successfully'})
        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{appuser} --> {__name__}: Unable to update department data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500
    except Exception as e:
        # Log any exceptions
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
