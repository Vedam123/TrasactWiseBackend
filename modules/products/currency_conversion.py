from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required  # Import the decorator
from config import READ_ACCESS_TYPE  # Import READ_ACCESS_TYPE
#from logger import logger 
from modules.security.get_user_from_token import get_user_from_token

# Get a logger for this module
#logger = configure_logging()

exchange_rate_api = Blueprint('exchange_rate_api', __name__)

def fetch_exchange_rate(mycursor, from_currency, to_currency):
    try:
        query = "SELECT exchangerate FROM com.exchangerate WHERE fromcurrency = %s AND tocurrency = %s"
        print("Executing query:", query)

        mycursor.execute(query, (from_currency, to_currency))
        row = mycursor.fetchone()
        print("Fetched row:", row)

        if row:
            return row[0]
        elif from_currency == to_currency:
            print("Source and target currencies are the same.")
            return 1.0  # Assuming exchange rate is 1:1 for the same currency
        else:
            print("No exchange rate found.")
            return None
    except Exception as e:
        print("Error fetching exchange rate:", e)
        return None


@exchange_rate_api.route('/currency_conversion', methods=['GET'])
@permission_required(READ_ACCESS_TYPE ,  __file__)  # Pass READ_ACCESS_TYPE as an argument
def currency_conversion():
    MODULE_NAME = __name__ 
    token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None
    USER_ID = token_results['username']
    #logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the currency conversion function")    
    try:
        from_currency = request.args.get('from_currency')
        amount = request.args.get('amount')
        to_currency = request.args.get('to_currency')

        print(from_currency, amount, to_currency)

        if not from_currency or not amount or not to_currency:
            return jsonify({'error': 'Invalid input'})

        try:
            amount = float(amount)
        except ValueError:
            return jsonify({'error': 'Invalid amount'})

        mydb = get_database_connection()
        mycursor = mydb.cursor()

        exchange_rate = fetch_exchange_rate(
            mycursor, from_currency, to_currency)
        if exchange_rate is None:
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Exchange rate not found'})

        exchange_rate = float(exchange_rate)  # Convert Decimal to float

        converted_amount = amount * exchange_rate

        mycursor.close()
        mydb.close()

        return jsonify({'from_currency': from_currency, 'amount': amount, 'to_currency': to_currency, 'converted_amount': converted_amount})

    except Exception as e:
        return jsonify({'error': str(e)})
