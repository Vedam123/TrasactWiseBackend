from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

create_department_api = Blueprint('create_department_api', __name__)

@create_department_api.route('/create_department', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_department():
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
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the create department function")

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

        company_id = data['company_id']
        department_name = data['department_name']
        manager_id = data.get('manager_id')
        description = data.get('description')
        account_group_id = data.get('account_group_id')
        if account_group_id == '':
            account_group_id = None
        created_by = current_userid
        updated_by = current_userid

        # Log parsed data
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Company ID: {company_id}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Department Name: {department_name}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Manager ID: {manager_id}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Parsed Description: {description}")

        mycursor = mydb.cursor()

        try:
            query = """
                INSERT INTO com.department (company_id, department_name, manager_id, description, default_account_header_id, created_by, updated_by)
                VALUES (%s, %s, %s, %s, %s, %s, %s)
            """
            values = (company_id, department_name, manager_id, description, account_group_id, created_by, updated_by)

            mycursor.execute(query, values)
            mydb.commit()

            # Log success and close the cursor and connection
            logger.info(f"{USER_ID} --> {MODULE_NAME}: Department data created successfully")
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Department data created successfully'}), 200

        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{USER_ID} --> {MODULE_NAME}: Unable to create department data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500
    except Exception as e:
        # Log any exceptions
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred : {str(e)}")
        return jsonify({'error': str(e)}), 500
