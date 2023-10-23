print ("Calling list currencies Once")

from flask import Blueprint, jsonify,request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger 



list_currencies_api = Blueprint('list_currencies_api', __name__)

@list_currencies_api.route('/list_currencies', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def list_currency_data():

    MODULE_NAME = __name__ 
    token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None
    USER_ID = token_results['username']
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the get currencies data function")
    print(f"{USER_ID} --> {MODULE_NAME}: Entered in the get currencies data function")
    mydb = get_database_connection()
    mycursor = mydb.cursor()
    mycursor.execute("SELECT * FROM com.currency")
    result = mycursor.fetchall()
    currencies = []

    # Get the column names from the cursor's description
    column_names = [desc[0] for desc in mycursor.description]

    for row in result:
        currency_dict = {}
        for i, value in enumerate(row):
            column_name = column_names[i]
            currency_dict[column_name] = value

        currencies.append(currency_dict)

    # Close the cursor and connection
    mycursor.close()
    mydb.close()

    return jsonify({'currencies': currencies})
