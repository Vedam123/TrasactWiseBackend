# Flask API
from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details	
from config import READ_ACCESS_TYPE
from modules.utilities.logger import logger

legal_entity_api = Blueprint('legal_entity_api', __name__)

@legal_entity_api.route('/get_legal_entity', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_legal_entity_data():
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

        logger.debug(f"{appuser} --> {__name__}: Entered the 'get legal entity data' function")

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

        logger.debug(f"{appuser} --> {__name__}: Successfully retrieved legal entity data")

        return jsonify({'legal_entity_list': legal_entity_list})

    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Error retrieving legal entity data - {str(e)}")
        import traceback
        traceback.print_exc()  # Add this line to print the full stack trace
        return jsonify({'error': 'Internal Server Error'}), 500
