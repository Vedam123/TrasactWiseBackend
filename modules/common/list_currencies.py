from flask import Blueprint, jsonify
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required  # Import the decorator
from config import READ_ACCESS_TYPE  # Import READ_ACCESS_TYPE

list_currencies_api = Blueprint('list_currencies_api', __name__)

@list_currencies_api.route('/list_currencies', methods=['GET'])
@permission_required(READ_ACCESS_TYPE ,  __file__)  # Pass READ_ACCESS_TYPE as an argument
def list_currency_data():
    mydb = get_database_connection()
    mycursor = mydb.cursor()
    mycursor.execute("SELECT * FROM com.currency")
    result = mycursor.fetchall()
    currencies = []

    for row in result:
        currencycode, currencyname, currencysymbol = row
        currencies.append({
            'currencycode': currencycode,
            'currencyname': currencyname,
            'currencysymbol': currencysymbol
        })
    # Close the cursor and connection
    mycursor.close()
    mydb.close()
    return jsonify({'currencies': currencies})
