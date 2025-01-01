from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details	
from config import READ_ACCESS_TYPE
from modules.utilities.logger import logger

list_currencies_api = Blueprint('list_currencies_api', __name__)

@list_currencies_api.route('/list_currencies', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def list_currency_data():
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
    
    logger.debug(f"{appuser} --> {__name__}: Entered the 'get currencies data' function")

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

    # Log successful completion
    logger.debug(f"{appuser} --> {__name__}: Successfully retrieved currency data")

    return jsonify({'currencies': currencies})
