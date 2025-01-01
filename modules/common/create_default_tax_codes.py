from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details	
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger

default_tax_codes_api = Blueprint('default_tax_codes_api', __name__)

@default_tax_codes_api.route('/create_default_tax_codes', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_default_tax_codes():
 
    try:
        # Extract Authorization header and decode user information
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

        # Parse JSON data from request
        data = request.get_json()

        logger.debug(f"{appuser} --> {__name__}: Received data: {data}")

        if isinstance(data, list):
            mycursor = mydb.cursor()

            results = []  # To store the results for each record

            for item in data:
                header_id = item.get('header_id')
                tax_id = item.get('tax_id')
                tax_type = item.get('tax_type')
                description = item.get('description', '')
                created_by = appuserid
                updated_by = appuserid

                if not header_id or not tax_id or not tax_type:
                    return jsonify({'error': 'Missing required fields'}), 400

                # Check if the record already exists
              
                # Insert new record
                insert_query = """
                    INSERT INTO com.default_tax_codes (header_id, tax_id, tax_type, description, created_at, updated_at)
                    VALUES (%s, %s, %s, %s, NOW(), NOW())
                """
                insert_values = (header_id, tax_id, tax_type, description)

                logger.debug(f"{appuser} --> {__name__}: Executing query: {insert_query} with values: {insert_values}")
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

            logger.info(f"{appuser} --> {__name__}: Processed all records")
            return jsonify({'results': results}), 200
        else:
            return jsonify({'error': 'Invalid data format. Expected a list of records.'}), 400

    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Error creating default tax codes - {str(e)}")
        import traceback
        traceback.print_exc()
        return jsonify({'error': 'Internal Server Error'}), 500
