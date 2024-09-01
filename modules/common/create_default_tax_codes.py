from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from flask_jwt_extended import decode_token
from modules.utilities.logger import logger

default_tax_codes_api = Blueprint('default_tax_codes_api', __name__)

@default_tax_codes_api.route('/create_default_tax_codes', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_default_tax_codes():
    MODULE_NAME = __name__

    try:
        # Extract Authorization header and decode user information
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'create_default_tax_codes' function")

        # Get the user ID from the JWT token
        current_userid = None
        if authorization_header and authorization_header.startswith('Bearer '):
            token = authorization_header.replace('Bearer ', '')
            decoded_token = decode_token(token)
            current_userid = decoded_token.get('Userid')

        # Parse JSON data from request
        data = request.get_json()

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Received data: {data}")

        if isinstance(data, list):
            mydb = get_database_connection(USER_ID, MODULE_NAME)
            mycursor = mydb.cursor()

            results = []  # To store the results for each record

            for item in data:
                header_id = item.get('header_id')
                tax_id = item.get('tax_id')
                tax_type = item.get('tax_type')
                description = item.get('description', '')
                created_by = current_userid
                updated_by = current_userid

                if not header_id or not tax_id or not tax_type:
                    return jsonify({'error': 'Missing required fields'}), 400

                # Check if the record already exists
              
                # Insert new record
                insert_query = """
                    INSERT INTO com.default_tax_codes (header_id, tax_id, tax_type, description, created_at, updated_at)
                    VALUES (%s, %s, %s, %s, NOW(), NOW())
                """
                insert_values = (header_id, tax_id, tax_type, description)

                logger.debug(f"{USER_ID} --> {MODULE_NAME}: Executing query: {insert_query} with values: {insert_values}")
                mycursor.execute(insert_query, insert_values)
                mydb.commit()

                results.append({
                    'header_id': header_id,
                    'tax_type': tax_type,
                    'status': 'inserted',
                    'message': 'New Tax codes created successfully in the system'
                })

            mycursor.close()
            mydb.close()

            logger.info(f"{USER_ID} --> {MODULE_NAME}: Processed all records")
            return jsonify({'results': results}), 200
        else:
            return jsonify({'error': 'Invalid data format. Expected a list of records.'}), 400

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error creating default tax codes - {str(e)}")
        import traceback
        traceback.print_exc()
        return jsonify({'error': 'Internal Server Error'}), 500
