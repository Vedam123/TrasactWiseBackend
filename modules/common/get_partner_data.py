from flask import Blueprint, jsonify, request
import base64
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger  # Import the logger module

get_partner_data_api = Blueprint('get_partner_data_api', __name__)

@get_partner_data_api.route('/get_partner_data', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_partner_data():
    authorization_header = request.headers.get('Authorization')
    token_results = ""
    USER_ID = ""
    MODULE_NAME = __name__
    if authorization_header:
        token_results = get_user_from_token(authorization_header)

    if token_results:
        USER_ID = token_results["username"]
        token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None

    mydb = get_database_connection(USER_ID, MODULE_NAME)

    partner_id = request.args.get('partnerid')
    partner_name = request.args.get('partnername')
    
    # Log entry point
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the get partner data function")

    try:
        mycursor = mydb.cursor()

        if partner_id is not None:
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request Parameters: partnerid={partner_id}")  # Log request variables
            query = """
                SELECT bp.*, c.currency_id, c.currencycode, c.currencysymbol
                FROM com.businesspartner bp
                LEFT JOIN com.currency c ON bp.currency_id = c.currency_id
                WHERE bp.partnerid = %s
            """
            mycursor.execute(query, (partner_id,))
        elif partner_name is not None:
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: Request Parameters: partnername={partner_name}")  # Log request variables
            query = """
                SELECT bp.*, c.currency_id, c.currencycode, c.currencysymbol
                FROM com.businesspartner bp
                LEFT JOIN com.currency c ON bp.currency_id = c.currency_id
                WHERE bp.partnername LIKE %s
            """
            mycursor.execute(query, ('%' + partner_name + '%',))
        else:
            query = """
                SELECT bp.*, c.currency_id, c.currencycode, c.currencysymbol
                FROM com.businesspartner bp
                LEFT JOIN com.currency c ON bp.currency_id = c.currency_id
            """
            mycursor.execute(query)

        partner_data = mycursor.fetchall()
        partner_list = []

        # Get the column names from the cursor's description
        column_names = [desc[0] for desc in mycursor.description]

        for partner in partner_data:
            partner_dict = {}
            for i, value in enumerate(partner):
                column_name = column_names[i]

                if column_name == 'customerimage' and isinstance(value, bytes):
                    try:
                        decoded_image = base64.b64encode(value).decode('utf-8')
                        partner_dict[column_name] = decoded_image
                    except Exception as e:
                        # Log an error message
                        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error decoding image: {str(e)}")
                else:
                    partner_dict[column_name] = value

            partner_list.append(partner_dict)

        mycursor.close()
        mydb.close()

        # Log successful completion
        logger.info(f"{USER_ID} --> {MODULE_NAME}: Successfully fetched partner data")

        return jsonify(partner_list)
    except Exception as e:
        mydb.close()
        # Log an error message
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error fetching partner data: {str(e)}")
        return jsonify({'error': str(e)}), 500
