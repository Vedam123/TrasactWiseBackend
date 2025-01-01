from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger

default_accounts_api = Blueprint('default_accounts_api', __name__)

@default_accounts_api.route('/create_default_account', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_default_account():
    

    try:
       	
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

        logger.debug(f"{appuser} --> {__name__}: Entered the 'create_default_account' function")

        mycursor = mydb.cursor()
            
        data = request.get_json()

        print("Received Data",data)

        if isinstance(data, list):
            for item in data:
                header_id = item.get('header_id')
                account_id = item.get('account_id')
                account_type = item.get('account_type')
                description = item.get('description', '')
                created_by = appuserid
                updated_by = appuserid

                if not header_id or not account_id or not account_type:
                    return jsonify({'error': 'Missing required fields'}), 400

                # Check if the record already exists
                check_query = """
                    SELECT COUNT(*) FROM fin.default_accounts
                    WHERE header_id = %s AND account_type = %s
                """
                mycursor.execute(check_query, (header_id, account_type))
                record_exists = mycursor.fetchone()[0]

                if record_exists:
                    logger.warning(f"{appuser} --> {__name__}: Duplicate record found for header_id {header_id} and account_type {account_type}")
                    continue

                insert_query = """
                    INSERT INTO fin.default_accounts (header_id, account_id, account_type, description, created_by, updated_by)
                    VALUES (%s, %s, %s, %s, %s, %s)
                """
                insert_values = (header_id, account_id, account_type, description, created_by, updated_by)

                logger.debug(f"{appuser} --> {__name__}: Executing query: {insert_query} with values: {insert_values}")
                mycursor.execute(insert_query, insert_values)
                mydb.commit()

                line_id = mycursor.lastrowid

            mycursor.close()
            mydb.close()

        logger.info(f"{appuser} --> {__name__}: Default accounts created successfully")
        return jsonify({'message': 'Default accounts created successfully'}), 200
    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Error creating default account - {str(e)}")
        import traceback
        traceback.print_exc()
        return jsonify({'error': 'Internal Server Error'}), 500
