from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

tax_api = Blueprint('tax_api', __name__)

@tax_api.route('/create_tax_codes', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_tax_codes():
    try:
        authorization_header = request.headers.get('Authorization')
        token_results = ""
        USER_ID = ""
        MODULE_NAME = __name__
        
        if authorization_header:
            token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
            token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None

        # Log entry point
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the create tax function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)

        current_userid = None
        authorization_header = request.headers.get('Authorization', '')
        if authorization_header.startswith('Bearer '):
            token = authorization_header.replace('Bearer ', '')
            decoded_token = decode_token(token)
            current_userid = decoded_token.get('Userid')

        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        # Log the received data
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Received data: {data}")

        try:
            # Type-cast and validate the received data
            tax_code = str(data.get('tax_code', '')).strip()
            tax_description = str(data.get('tax_description', '')).strip()
            tax_rate = float(data.get('tax_rate', 0.0))  # Convert to float
            tax_type = str(data.get('tax_type', '')).strip()
            tax_authority = str(data.get('tax_authority', '')).strip()
            tax_jurisdiction = str(data.get('tax_jurisdiction', '')).strip()
            tax_applicability = str(data.get('tax_applicability', '')).strip()
            effective_date = str(data.get('effective_date', '')).strip()  # Assuming the date is a string in YYYY-MM-DD format
            exemption = str(data.get('exemption', '')).strip()
            reporting_codes = str(data.get('reporting_codes', '')).strip()
            integration_info = str(data.get('integration_info', '')).strip()
            status = bool(data.get('status', True))  # Convert to boolean
            notes = str(data.get('notes', '')).strip()
            created_by = int(current_userid)
            updated_by = int(current_userid)
        except ValueError as ve:
            logger.error(f"{USER_ID} --> {MODULE_NAME}: Invalid data type: {str(ve)}")
            return jsonify({'error': f'Invalid data type: {str(ve)}'}), 400

        # Log parsed and type-cast data
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed and type-cast Tax Code: {tax_code}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed and type-cast Tax Description: {tax_description}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed and type-cast Tax Rate: {tax_rate}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed and type-cast Tax Type: {tax_type}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed and type-cast Tax Authority: {tax_authority}")

        mycursor = mydb.cursor()

        try:
            # Create the SQL insert query
            query = """
                INSERT INTO com.tax 
                (tax_code, tax_description, tax_rate, tax_type, tax_authority, tax_jurisdiction, tax_applicability, 
                effective_date, exemption, reporting_codes, integration_info, status, notes, created_by, updated_by)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """
            values = (
                tax_code, tax_description, tax_rate, tax_type, tax_authority, tax_jurisdiction, tax_applicability,
                effective_date, exemption, reporting_codes, integration_info, status, notes, created_by, updated_by
            )

            # Execute the query
            mycursor.execute(query, values)
            mydb.commit()

            # Log success and close the cursor and connection
            logger.info(f"{USER_ID} --> {MODULE_NAME}: Tax data created successfully")
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Tax data created successfully'})
        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{USER_ID} --> {MODULE_NAME}: Unable to create tax data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500
    except Exception as e:
        # Log any exceptions
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
