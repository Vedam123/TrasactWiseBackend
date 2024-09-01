from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

tax_api = Blueprint('tax_api', __name__)

@tax_api.route('/create_exchange_rates', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_exchange_rates():
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
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the create exchange rate function")

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
            from_currency_id = int(data.get('from_currency_id', 0))
            to_currency_id = int(data.get('to_currency_id', 0))
            exchange_rate = float(data.get('exchangerate', 0.0))  # Convert to float
            valid_from = str(data.get('valid_from', '')).strip()
            valid_to = str(data.get('valid_to', '')).strip()
            conversion_type = str(data.get('conversion_type', '')).strip()
            provider_id = int(data.get('provider_id', 0))
            status = str(data.get('status', '')).strip()
            version = str(data.get('version', '')).strip()
            created_by = int(current_userid)
            updated_by = int(current_userid)
        except ValueError as ve:
            logger.error(f"{USER_ID} --> {MODULE_NAME}: Invalid data type: {str(ve)}")
            return jsonify({'error': f'Invalid data type: {str(ve)}'}), 400

        # Log parsed and type-cast data
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed and type-cast From Currency ID: {from_currency_id}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed and type-cast To Currency ID: {to_currency_id}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed and type-cast Exchange Rate: {exchange_rate}")

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
            logger.info(f"{USER_ID} --> {MODULE_NAME}: Exchange rate data created successfully")
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Exchange rate data created successfully'})
        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{USER_ID} --> {MODULE_NAME}: Unable to create exchange rate data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500
    except Exception as e:
        # Log any exceptions
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500

