from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

company_api = Blueprint('company_api', __name__)

@company_api.route('/create_company', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_company():
    try:
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
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the create company function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)

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
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Received data: {data}")

        group_company_id = data['group_company_id']
        name = data.get('name')
        description = data.get('description')
        local_cur_id = data.get('local_cur_id')
        home_cur_id = data.get('home_cur_id')
        reporting_cur_id = data.get('reporting_cur_id')
        tax_code_id = data.get('tax_code_id')
        created_by = current_userid
        updated_by = current_userid

        # Log parsed data
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Group Company ID: {group_company_id}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Name: {name}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Description: {description}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Local Currency: {local_cur_id}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Home Currency: {home_cur_id}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Reporting Currency: {reporting_cur_id}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Tax code : {tax_code_id}")

        mycursor = mydb.cursor()

        try:
            query = """
                INSERT INTO com.company 
                (group_company_id, name,description, local_cur_id, home_cur_id, reporting_cur_id, default_tax_code_id,created_by, updated_by)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
            """
            values = (group_company_id,name,description, local_cur_id, home_cur_id, reporting_cur_id,tax_code_id, created_by, updated_by)

            mycursor.execute(query, values)
            mydb.commit()

            # Log success and close the cursor and connection
            logger.info(f"{USER_ID} --> {MODULE_NAME}: Company data created successfully")
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Company data created successfully'})
        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{USER_ID} --> {MODULE_NAME}: Unable to create company data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500
    except Exception as e:
        # Log any exceptions
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
