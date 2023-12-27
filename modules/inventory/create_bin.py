# modules/inventory/create_bin.py

from flask import jsonify, request,Blueprint
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

create_bin_api = Blueprint('create_bin_api', __name__)

@create_bin_api.route('/create_bin', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_bin():
    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
            token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None

        # Log entry point
        logger.debug(f"{USER_ID} --> {__name__}: Entered in the create bin function")

        mydb = get_database_connection(USER_ID, __name__)

        current_userid = None
        authorization_header = request.headers.get('Authorization', '')
        if authorization_header.startswith('Bearer '):
            token = authorization_header.replace('Bearer ', '')
            decoded_token = decode_token(token)
            current_userid = decoded_token.get('Userid')

        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        # Log the received data
        logger.debug(f"{USER_ID} --> {__name__}: Received data: {data}")

        rack_id = data['rack_id']
        bin_name = data['bin_name']
        description = data.get('description')
        capacity = data.get('capacity')
        created_by = current_userid
        updated_by = current_userid

        # Log parsed data
        logger.debug(f"{USER_ID} --> {__name__}: Parsed Rack ID: {rack_id}")
        logger.debug(f"{USER_ID} --> {__name__}: Parsed Bin Name: {bin_name}")
        logger.debug(f"{USER_ID} --> {__name__}: Parsed Description: {description}")
        logger.debug(f"{USER_ID} --> {__name__}: Parsed Capacity: {capacity}")

        mycursor = mydb.cursor()

        try:
            query = """
                INSERT INTO inv.bins (rack_id, bin_name, description, capacity, created_by, updated_by)
                VALUES (%s, %s, %s, %s, %s, %s)
            """
            values = (rack_id, bin_name, description, capacity, created_by, updated_by)

            mycursor.execute(query, values)
            mydb.commit()

            # Log success and close the cursor and connection
            logger.info(f"{USER_ID} --> {__name__}: Bin data created successfully")
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Bin data created successfully'}), 200

        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{USER_ID} --> {__name__}: Unable to create bin data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500
    except Exception as e:
        # Log any exceptions
        logger.error(f"{USER_ID} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
