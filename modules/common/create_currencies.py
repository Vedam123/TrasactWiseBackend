from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.utilities.logger import logger

tax_api = Blueprint('tax_api', __name__)

@tax_api.route('/create_currencies', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_currencies():
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

        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        # Log the received data
        logger.debug(f"{appuser} --> {__name__}: Received data: {data}")

        try:
            # Type-cast and validate the received data
            currency_code = str(data.get('currencycode', '')).strip()
            currency_name = str(data.get('currencyname', '')).strip()
            currency_symbol = str(data.get('currencysymbol', '')).strip()
            created_by = int(appuserid)
            updated_by = int(appuserid)
        except ValueError as ve:
            logger.error(f"{appuser} --> {__name__}: Invalid data type: {str(ve)}")
            return jsonify({'error': f'Invalid data type: {str(ve)}'}), 400

        # Log parsed and type-cast data
        logger.debug(f"{appuser} --> {__name__}: Parsed and type-cast Currency Code: {currency_code}")
        logger.debug(f"{appuser} --> {__name__}: Parsed and type-cast Currency Name: {currency_name}")

        mycursor = mydb.cursor()

        try:
            # Create the SQL insert query
            query = """
                INSERT INTO com.currency 
                (currencycode, currencyname, currencysymbol, created_by, updated_by)
                VALUES (%s, %s, %s, %s, %s)
            """
            values = (currency_code, currency_name, currency_symbol, created_by, updated_by)

            # Execute the query
            mycursor.execute(query, values)
            mydb.commit()

            # Log success and close the cursor and connection
            logger.info(f"{appuser} --> {__name__}: Currency data created successfully")
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Currency data created successfully'})
        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{appuser} --> {__name__}: Unable to create currency data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500
    except Exception as e:
        # Log any exceptions
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
