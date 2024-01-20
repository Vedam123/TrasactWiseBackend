from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

list_exchange_rates_api = Blueprint('list_exchange_rates_api', __name__)

@list_exchange_rates_api.route('/list_exchange_rates', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def list_exchange_rate_data():
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
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'get exchange rates data' function")

    mydb = get_database_connection(USER_ID, MODULE_NAME)
    mycursor = mydb.cursor()

    # Update the SQL query to join with com.currency
    mycursor.execute("""
        SELECT
            er.exchange_rate_id,
            er.from_currency_id,
            er.to_currency_id,
            er.exchangerate,
            er.valid_from,
            er.valid_to,
            er.conversion_type,
            er.provider_id,
            er.status,
            er.version,
            er.created_at,
            er.updated_at,
            er.created_by,
            er.updated_by,
            c1.currencycode AS from_currency_code,
            c1.currencyname AS from_currency_name,
            c1.currencysymbol AS from_currency_symbol,
            c2.currencycode AS to_currency_code,
            c2.currencyname AS to_currency_name,
            c2.currencysymbol AS to_currency_symbol
        FROM com.exchange_rates er
        JOIN com.currency c1 ON er.from_currency_id = c1.currency_id
        JOIN com.currency c2 ON er.to_currency_id = c2.currency_id
    """)

    result = mycursor.fetchall()
    exchangerates = []

    # Get the column names from the cursor's description
    column_names = [desc[0] for desc in mycursor.description]

    for row in result:
        exchange_rate_dict = {}
        for i, value in enumerate(row):
            column_name = column_names[i]
            if column_name == 'exchangeratedate' and value is not None:
                value = value.strftime('%Y-%m-%d')
            elif column_name == 'exchangerate':
                value = str(value)
            exchange_rate_dict[column_name] = value

        exchangerates.append(exchange_rate_dict)

    # Close the cursor and connection
    mycursor.close()
    mydb.close()

    # Log successful completion
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Successfully retrieved exchange rate data")

    return jsonify({'exchangerates': exchangerates})
