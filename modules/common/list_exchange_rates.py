from flask import Blueprint, jsonify
from modules.admin.databases.mydb import get_database_connection

list_exchange_rates_api = Blueprint('list_exchange_rates_api', __name__)

@list_exchange_rates_api.route('/list_exchange_rates', methods=['GET'])
def list_exchange_rate_data():
    mydb = get_database_connection()
    mycursor = mydb.cursor()
    mycursor.execute("SELECT * FROM com.exchangerate")
    result = mycursor.fetchall()
    exchangerates = []

    for row in result:
        exchangeratedate, fromcurrency, tocurrency, exchangerate = row
        exchangerates.append({
            'exchangeratedate': str(exchangeratedate),
            'fromcurrency': fromcurrency,
            'tocurrency': tocurrency,
            'exchangerate': str(exchangerate)
        })
    # Close the cursor and connection
    mycursor.close()
    mydb.close()
    return jsonify({'exchangerates': exchangerates})
