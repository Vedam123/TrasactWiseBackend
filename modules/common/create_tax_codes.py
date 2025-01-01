from flask import Blueprint, jsonify, request
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger

tax_api = Blueprint('tax_api', __name__)

@tax_api.route('/create_tax_codes', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_tax_codes():
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
        logger.debug(f"{appuser} --> {__name__}: Entered in the create tax function")

      
        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        # Log the received data
        logger.debug(f"{appuser} --> {__name__}: Received data: {data}")

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
            created_by = int(appuserid)
            updated_by = int(appuserid)
        except ValueError as ve:
            logger.error(f"{appuser} --> {__name__}: Invalid data type: {str(ve)}")
            return jsonify({'error': f'Invalid data type: {str(ve)}'}), 400

        # Log parsed and type-cast data
        logger.debug(f"{appuser} --> {__name__}: Parsed and type-cast Tax Code: {tax_code}")
        logger.debug(f"{appuser} --> {__name__}: Parsed and type-cast Tax Description: {tax_description}")
        logger.debug(f"{appuser} --> {__name__}: Parsed and type-cast Tax Rate: {tax_rate}")
        logger.debug(f"{appuser} --> {__name__}: Parsed and type-cast Tax Type: {tax_type}")
        logger.debug(f"{appuser} --> {__name__}: Parsed and type-cast Tax Authority: {tax_authority}")

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
            logger.info(f"{appuser} --> {__name__}: Tax data created successfully")
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Tax data created successfully'})
        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{appuser} --> {__name__}: Unable to create tax data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500
    except Exception as e:
        # Log any exceptions
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
