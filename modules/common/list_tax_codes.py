from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
import decimal  # Add this import to handle DECIMAL data type
from datetime import date
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

list_taxcodes_api = Blueprint('list_taxcodes_api', __name__)

@list_taxcodes_api.route('/list_taxcodes', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def list_tax_data():
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
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'get tax data' function")

    mydb = get_database_connection(USER_ID, MODULE_NAME)
    mycursor = mydb.cursor()
    mycursor.execute("SELECT * FROM com.tax")
    result = mycursor.fetchall()
    taxes = []

    # Get the column names from the cursor's description
    column_names = [desc[0] for desc in mycursor.description]

    for row in result:
        tax_dict = {}
        for i, value in enumerate(row):
            column_name = column_names[i]
            if isinstance(value, bool):
                value = str(value)
            elif isinstance(value, decimal.Decimal):
                value = str(value)
            elif isinstance(value, date):
                value = value.strftime('%Y-%m-%d')
            tax_dict[column_name] = value

        taxes.append(tax_dict)

    # Close the cursor and connection
    mycursor.close()
    mydb.close()

    # Log successful completion
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Successfully retrieved tax data")

    return jsonify({'taxes': taxes})
