from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details	
from config import READ_ACCESS_TYPE
from modules.utilities.logger import logger

group_company_api = Blueprint('group_company_api', __name__)

@group_company_api.route('/get_group_companies', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_group_companies():

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
        logger.debug(f"{appuser} --> {__name__}: Entered the 'get group companies' function")

        mycursor = mydb.cursor()

        mycursor.execute("""
            SELECT gc.id, gc.legal_entity_id, gc.name AS group_company_name, gc.description, 
                   gc.created_at, gc.updated_at, gc.created_by, gc.updated_by,
                   le.name AS legal_entity_name
            FROM com.group_company gc
            JOIN com.legal_entity le ON gc.legal_entity_id = le.id
        """)

        result = mycursor.fetchall()
        group_company_list = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        for row in result:
            group_company_dict = {}

            for column in columns:
                group_company_dict[column] = row[column_indices[column]]

            group_company_list.append(group_company_dict)

        mycursor.close()
        mydb.close()

        logger.debug(f"{appuser} --> {__name__}: Successfully retrieved group company data")

        return jsonify({'group_company_list': group_company_list})

    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Error retrieving group company data - {str(e)}")
        import traceback
        traceback.print_exc()  # Add this line to print the full stack trace
        return jsonify({'error': 'Internal Server Error'}), 500
