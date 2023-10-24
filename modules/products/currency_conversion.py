import json
from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required  # Import the decorator
from config import READ_ACCESS_TYPE  # Import READ_ACCESS_TYPE
from modules.utilities.logger import logger  # Import the logger module
from modules.security.get_user_from_token import get_user_from_token

exchange_rate_api = Blueprint('exchange_rate_api', __name__)

def fetch_exchange_rate(mycursor, from_currency, to_currency):
    try:
        query = "SELECT exchangerate FROM com.exchangerate WHERE fromcurrency = %s AND tocurrency = %s"
        logger.debug("Executing query: %s", query)

        mycursor.execute(query, (from_currency, to_currency))
        row = mycursor.fetchone()
        logger.debug("Fetched row: %s", row)

        if row:
            return row[0]
        elif from_currency == to_currency:
            logger.warning("Source and target currencies are the same.")
            return 1.0  # Assuming exchange rate is 1:1 for the same currency
        else:
            logger.warning("No exchange rate found.")
            return None
    except Exception as e:
        logger.error("Error fetching exchange rate: %s", e)
        return None

@exchange_rate_api.route('/currency_conversion', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)  # Pass READ_ACCESS_TYPE as an argument
def currency_conversion():
    authorization_header = request.headers.get('Authorization')
    token_results = ""
    USER_ID = ""
    MODULE_NAME = __name__
    if authorization_header:
        token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None

    if token_results:
        USER_ID = token_results["username"]

    # Log entry point
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the currency conversion function")

    try:
        from_currency = request.args.get('from_currency')
        amount = request.args.get('amount')
        to_currency = request.args.get('to_currency')

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: from_currency: %s, amount: %s, to_currency: %s", from_currency, amount, to_currency)

        if not from_currency or not amount or not to_currency:
            logger.warning(f"{USER_ID} --> {MODULE_NAME}: Invalid input")
            return jsonify({'error': 'Invalid input'})

        try:
            amount = float(amount)
        except ValueError:
            logger.warning(f"{USER_ID} --> {MODULE_NAME}: Invalid amount")
            return jsonify({'error': 'Invalid amount'})

        mydb = get_database_connection(USER_ID, MODULE_NAME)
        mycursor = mydb.cursor()

        exchange_rate = fetch_exchange_rate(mycursor, from_currency, to_currency)
        if exchange_rate is None:
            mycursor.close()
            mydb.close()
            logger.warning(f"{USER_ID} --> {MODULE_NAME}: Exchange rate not found")
            return jsonify({'message': 'Exchange rate not found'})

        exchange_rate = float(exchange_rate)  # Convert Decimal to float

        converted_amount = amount * exchange_rate

        mycursor.close()
        mydb.close()

        return jsonify({'from_currency': from_currency, 'amount': amount, 'to_currency': to_currency, 'converted_amount': converted_amount})

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred: %s", str(e))
        return jsonify({'error': str(e)})
