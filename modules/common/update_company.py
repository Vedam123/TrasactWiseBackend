from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.utilities.logger import logger

company_api = Blueprint('company_api', __name__)

@company_api.route('/update_company', methods=['PUT'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def update_company():
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

        # Retrieve company_id from query parameters
        company_id = request.args.get('company_id', type=int)
        if not company_id:
            logger.error(f"{appuser} --> {__name__}: Missing company_id in query parameters.")
            return jsonify({"error": "company_id is required."}), 400

        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        # Log the received data
        logger.debug(f"{appuser} --> {__name__}: Received data: {data}")

        # Retrieve the new parameters from the data
        group_company_id = data.get('group_company_id')
        name = data.get('name')
        description = data.get('description')
        default_tax_code_id = data.get('default_tax_code_id')
        default_account_header_id = data.get('default_account_header_id')
        local_cur_id = data.get('local_cur_id')
        home_cur_id = data.get('home_cur_id')
        reporting_cur_id = data.get('reporting_cur_id')
        updated_by = appuserid

        # Log parsed data
        logger.debug(f"{appuser} --> {__name__}: Parsed Group Company ID: {group_company_id}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Name: {name}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Description: {description}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Default Tax Code ID: {default_tax_code_id}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Default Account Header ID: {default_account_header_id}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Local Currency ID: {local_cur_id}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Home Currency ID: {home_cur_id}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Reporting Currency ID: {reporting_cur_id}")

        mycursor = mydb.cursor()

        try:
            # SQL query for updating the company data with all required fields
            query = """
                UPDATE com.company
                SET group_company_id = %s, name = %s, description = %s, 
                    local_cur_id = %s, home_cur_id = %s, reporting_cur_id = %s, 
                    default_tax_code_id = %s, default_account_header_id = %s, updated_by = %s
                WHERE id = %s
            """
            values = (
                group_company_id, name, description, local_cur_id, home_cur_id, 
                reporting_cur_id, default_tax_code_id, default_account_header_id, 
                updated_by, company_id
            )

            mycursor.execute(query, values)
            mydb.commit()

            # Check if the record was updated
            if mycursor.rowcount == 0:
                logger.error(f"{appuser} --> {__name__}: Company with ID {company_id} not found.")
                return jsonify({"error": f"Company with ID {company_id} not found."}), 404

            # Log success and close the cursor and connection
            logger.info(f"{appuser} --> {__name__}: Company data updated successfully")
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Company data updated successfully'})
        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{appuser} --> {__name__}: Unable to update company data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500
    except Exception as e:
        # Log any exceptions
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
