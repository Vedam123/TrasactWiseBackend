# Flask API
from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

legal_entity_api = Blueprint('legal_entity_api', __name__)

@legal_entity_api.route('/get_legal_entity', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_legal_entity_data():
    MODULE_NAME = __name__

    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'get legal entity data' function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)
        mycursor = mydb.cursor()

        # Check if 'name' parameter is in the request.args
        name = request.args.get('name')

        if name:
            mycursor.execute("""
                SELECT id, name, registration_number, address, contact_email, contact_phone, about, created_at, updated_at, created_by, updated_by
                FROM com.legal_entity
                WHERE name REGEXP %s
            """, (name,))
        else:
            mycursor.execute("""
                SELECT id, name, registration_number, address, contact_email, contact_phone, about, created_at, updated_at, created_by, updated_by
                FROM com.legal_entity
            """)

        result = mycursor.fetchall()
        legal_entity_list = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        for row in result:
            legal_entity_dict = {}

            for column in columns:
                legal_entity_dict[column] = row[column_indices[column]]

            legal_entity_list.append(legal_entity_dict)

        mycursor.close()
        mydb.close()

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Successfully retrieved legal entity data")

        return jsonify({'legal_entity_list': legal_entity_list})

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error retrieving legal entity data - {str(e)}")
        import traceback
        traceback.print_exc()  # Add this line to print the full stack trace
        return jsonify({'error': 'Internal Server Error'}), 500
