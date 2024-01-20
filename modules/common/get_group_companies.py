from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

group_company_api = Blueprint('group_company_api', __name__)

@group_company_api.route('/get_group_companies', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_group_companies():
    MODULE_NAME = __name__

    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'get group companies' function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)
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

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Successfully retrieved group company data")

        return jsonify({'group_company_list': group_company_list})

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error retrieving group company data - {str(e)}")
        import traceback
        traceback.print_exc()  # Add this line to print the full stack trace
        return jsonify({'error': 'Internal Server Error'}), 500
