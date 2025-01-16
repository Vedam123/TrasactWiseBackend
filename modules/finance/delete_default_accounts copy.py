from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger

default_accounts_api = Blueprint('default_accounts_api', __name__)

@default_accounts_api.route('/delete_default_accounts', methods=['DELETE'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def delete_default_accounts():
    try:
        # Retrieve the authorization token from the headers
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

        logger.debug(f"{appuser} --> {__name__}: Entered the 'delete_default_accounts' function")

        mycursor = mydb.cursor()
        
        print(request)
        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        logger.debug(f"Received Data: ", data)

        if isinstance(data, list):
            for item in data:
                header_id = item.get('header_id')
                line_id = item.get('line_id')  # Add line_id to identify the record uniquely

                if not header_id or not line_id:
                    return jsonify({'error': 'Missing required fields: header_id or line_id'}), 400

                # Check if the record exists using header_id and line_id
                check_query = """
                    SELECT account_id FROM fin.default_accounts
                    WHERE header_id = %s AND line_id = %s
                """
                mycursor.execute(check_query, (header_id, line_id))
                existing_record = mycursor.fetchone()

                if not existing_record:
                    logger.warning(f"{appuser} --> {__name__}: Record not found for header_id {header_id} and line_id {line_id}")
                    return jsonify({'error': 'Record not found to delete'}), 404

                # If the record exists, delete it
                delete_query = """
                    DELETE FROM fin.default_accounts
                    WHERE header_id = %s AND line_id = %s
                """
                delete_values = (header_id, line_id)

                logger.debug(f"{appuser} --> {__name__}: Executing query: {delete_query} with values: {delete_values}")
                mycursor.execute(delete_query, delete_values)
                mydb.commit()

            mycursor.close()
            mydb.close()

        logger.info(f"{appuser} --> {__name__}: Default accounts deleted successfully")
        return jsonify({'message': 'Default accounts deleted successfully'}), 200
    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Error deleting default account - {str(e)}")
        import traceback
        traceback.print_exc()
        return jsonify({'error': 'Internal Server Error'}), 500
