from flask import Blueprint, jsonify
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE

list_exchange_rates_api = Blueprint('list_exchange_rates_api', __name__)

@list_exchange_rates_api.route('/list_exchange_rates', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def list_exchange_rate_data():
    mydb = get_database_connection()
    mycursor = mydb.cursor()
    mycursor.execute("SELECT * FROM com.exchangerate")
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

    return jsonify({'exchangerates': exchangerates})
