from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from modules.security.routines.get_user_and_db_details import get_user_and_db_details		
from modules.utilities.logger import logger

company_api = Blueprint('company_api', __name__)

@company_api.route('/create_company', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_company():
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

        group_company_id = data['group_company_id']
        name = data.get('name')
        description = data.get('description')
        local_cur_id = data.get('local_cur_id')
        home_cur_id = data.get('home_cur_id')
        reporting_cur_id = data.get('reporting_cur_id')
        tax_code_id = data.get('tax_code_id')
        created_by = appuserid
        updated_by = appuserid

        # Log parsed data
        logger.debug(f"{appuser} --> {__name__}: Parsed Group Company ID: {group_company_id}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Name: {name}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Description: {description}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Local Currency: {local_cur_id}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Home Currency: {home_cur_id}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Reporting Currency: {reporting_cur_id}")
        logger.debug(f"{appuser} --> {__name__}: Tax code: {tax_code_id}")

        mycursor = mydb.cursor()

        try:
            query = """
                INSERT INTO com.company 
                (group_company_id, name, description, local_cur_id, home_cur_id, reporting_cur_id, default_tax_code_id, created_by, updated_by)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
            """
            values = (
                group_company_id, name, description, local_cur_id, home_cur_id, 
                reporting_cur_id, tax_code_id, created_by, updated_by
            )

            mycursor.execute(query, values)
            mydb.commit()

            # Log success and close the cursor and connection
            logger.info(f"{appuser} --> {__name__}: Company data created successfully")
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Company data created successfully'})
        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{appuser} --> {__name__}: Unable to create company data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500
    except Exception as e:
        # Log any exceptions
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
