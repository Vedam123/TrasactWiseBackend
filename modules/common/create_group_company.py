from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details	
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger

create_group_company_api = Blueprint('create_group_company_api', __name__)

@create_group_company_api.route('/create_group_company', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_group_company():
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
           
        # Log entry point
        logger.debug(f"{appuser} --> {__name__}: Entered in the create group company function")

        
        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        # Log the received data
        logger.debug(f"{appuser} --> {__name__}: Received data: {data}")

        legal_entity_id = data['legal_entity_id']
        name = data['name']
        description = data.get('description')
        created_by = appuserid
        updated_by = appuserid

        # Log parsed data
        logger.debug(f"{appuser} --> {__name__}: Parsed Legal Entity ID: {legal_entity_id}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Name: {name}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Description: {description}")

        mycursor = mydb.cursor()

        try:
            query = "INSERT INTO com.group_company (legal_entity_id, name, description, created_by, updated_by) VALUES (%s, %s, %s, %s, %s)"
            values = (legal_entity_id, name, description, created_by, updated_by)

            mycursor.execute(query, values)
            mydb.commit()

            # Log success and close the cursor and connection
            logger.info(f"{appuser} --> {__name__}: Group company data created successfully")
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Group company data created successfully'})
        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{appuser} --> {__name__}: Unable to create group company data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500
    except Exception as e:
        # Log any exceptions
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
