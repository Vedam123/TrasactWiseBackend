import json
from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required  # Import the decorator
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import READ_ACCESS_TYPE  # Import READ_ACCESS_TYPE
from modules.utilities.logger import logger  # Import the logger module

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
    logger.debug(f"{appuser} --> {__name__}: Entered in the currency conversion function")

    try:
        from_currency = request.args.get('from_currency')
        amount = request.args.get('amount')
        to_currency = request.args.get('to_currency')

        logger.debug(f"{appuser} --> {__name__}: from_currency: %s, amount: %s, to_currency: %s", from_currency, amount, to_currency)

        if not from_currency or not amount or not to_currency:
            logger.warning(f"{appuser} --> {__name__}: Invalid input")
            return jsonify({'error': 'Invalid input'})

        try:
            amount = float(amount)
        except ValueError:
            logger.warning(f"{appuser} --> {__name__}: Invalid amount")
            return jsonify({'error': 'Invalid amount'})
        
        mycursor = mydb.cursor()

        exchange_rate = fetch_exchange_rate(mycursor, from_currency, to_currency)
        if exchange_rate is None:
            mycursor.close()
            mydb.close()
            logger.warning(f"{appuser} --> {__name__}: Exchange rate not found")
            return jsonify({'message': 'Exchange rate not found'})

        exchange_rate = float(exchange_rate)  # Convert Decimal to float

        converted_amount = amount * exchange_rate

        mycursor.close()
        mydb.close()

        return jsonify({'from_currency': from_currency, 'amount': amount, 'to_currency': to_currency, 'converted_amount': converted_amount})

    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: An error occurred: %s", str(e))
        return jsonify({'error': str(e)})
