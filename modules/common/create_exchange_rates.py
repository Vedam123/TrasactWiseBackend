from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.utilities.logger import logger

tax_api = Blueprint('tax_api', __name__)

@tax_api.route('/create_exchange_rates', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_exchange_rates():
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
        logger.debug(f"{appuser} --> {__name__}: Entered in the create exchange rate function")


        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        # Log the received data
        logger.debug(f"{appuser} --> {__name__}: Received data: {data}")

        try:
            # Type-cast and validate the received data
            from_currency_id = int(data.get('from_currency_id', 0))
            to_currency_id = int(data.get('to_currency_id', 0))
            exchange_rate = float(data.get('exchangerate', 0.0))  # Convert to float
            valid_from = str(data.get('valid_from', '')).strip()
            valid_to = str(data.get('valid_to', '')).strip()
            conversion_type = str(data.get('conversion_type', '')).strip()
            provider_id = int(data.get('provider_id', 0))
            status = str(data.get('status', '')).strip()
            version = str(data.get('version', '')).strip()
            created_by = int(appuserid)
            updated_by = int(appuserid)
        except ValueError as ve:
            logger.error(f"{appuser} --> {__name__}: Invalid data type: {str(ve)}")
            return jsonify({'error': f'Invalid data type: {str(ve)}'}), 400

        # Log parsed and type-cast data
        logger.debug(f"{appuser} --> {__name__}: Parsed and type-cast From Currency ID: {from_currency_id}")
        logger.debug(f"{appuser} --> {__name__}: Parsed and type-cast To Currency ID: {to_currency_id}")
        logger.debug(f"{appuser} --> {__name__}: Parsed and type-cast Exchange Rate: {exchange_rate}")

        mycursor = mydb.cursor()

        try:
            # Create the SQL insert query
            query = """
                INSERT INTO com.exchange_rates 
                (from_currency_id, to_currency_id, exchangerate, valid_from, valid_to, conversion_type, provider_id, 
                 status, version, created_by, updated_by)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """
            values = (
                from_currency_id, to_currency_id, exchange_rate, valid_from, valid_to, conversion_type, provider_id, 
                status, version, created_by, updated_by
            )

            # Execute the query
            mycursor.execute(query, values)
            mydb.commit()

            # Log success and close the cursor and connection
            logger.info(f"{appuser} --> {__name__}: Exchange rate data created successfully")
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Exchange rate data created successfully'})
        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{appuser} --> {__name__}: Unable to create exchange rate data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500
    except Exception as e:
        # Log any exceptions
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500

