from flask import Blueprint, jsonify, request
import base64
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details	
from config import READ_ACCESS_TYPE
from modules.utilities.logger import logger  # Import the logger module

get_partner_data_api = Blueprint('get_partner_data_api', __name__)

@get_partner_data_api.route('/get_partner_data', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_partner_data():
	
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

    partner_id = request.args.get('partnerid')
    partner_name = request.args.get('partnername')
    
    # Log entry point
    logger.debug(f"{appuser} --> {__name__}: Entered in the get partner data function")

    try:
        mycursor = mydb.cursor()

        if partner_id is not None:
            logger.debug(f"{appuser} --> {__name__}: Request Parameters: partnerid={partner_id}")  # Log request variables
            query = """
                SELECT bp.*, c.currency_id, c.currencycode, c.currencysymbol
                FROM com.businesspartner bp
                LEFT JOIN com.currency c ON bp.currency_id = c.currency_id
                WHERE bp.partnerid = %s
            """
            mycursor.execute(query, (partner_id,))
        elif partner_name is not None:
            logger.debug(f"{appuser} --> {__name__}: Request Parameters: partnername={partner_name}")  # Log request variables
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
                        logger.error(f"{appuser} --> {__name__}: Error decoding image: {str(e)}")
                else:
                    partner_dict[column_name] = value

            partner_list.append(partner_dict)

        mycursor.close()
        mydb.close()

        # Log successful completion
        logger.info(f"{appuser} --> {__name__}: Successfully fetched partner data")

        return jsonify(partner_list)
    except Exception as e:
        mydb.close()
        # Log an error message
        logger.error(f"{appuser} --> {__name__}: Error fetching partner data: {str(e)}")
        return jsonify({'error': str(e)}), 500
