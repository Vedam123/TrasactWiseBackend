from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger

default_accounts_api = Blueprint('default_accounts_api', __name__)

@default_accounts_api.route('/update_default_accounts', methods=['PUT'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def update_default_accounts():
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

        logger.debug(f"{appuser} --> {__name__}: Entered the 'update_default_account' function")

        mycursor = mydb.cursor()

        # Retrieve the data from the request body (must be a JSON)
        data = request.get_json()

        logger.debug(f"Received Data: {data}")

        if isinstance(data, list):
            for item in data:
                header_id = item.get('header_id')
                line_id = item.get('line_id')  # Add line_id to identify the record uniquely
                account_id = item.get('account_id')
                account_type = item.get('account_type')
                description = item.get('description', '')
                updated_by = appuserid

                if not header_id or not line_id or not account_id or not account_type:
                    return jsonify({'error': 'Missing required fields: header_id, line_id, account_id, or account_type'}), 400

                # Check if the record exists using header_id and line_id
                check_query = """
                    SELECT account_id, account_type, description FROM fin.default_accounts
                    WHERE header_id = %s AND line_id = %s
                """
                mycursor.execute(check_query, (header_id, line_id))
                existing_record = mycursor.fetchone()

                if not existing_record:
                    logger.warning(f"{appuser} --> {__name__}: Record not found for header_id {header_id} and line_id {line_id}")
                    return jsonify({'error': 'Record not found to update'}), 404

                # Compare the new values with the existing ones
                existing_account_id, existing_account_type, existing_description = existing_record

                if (existing_account_id == account_id and
                    existing_account_type == account_type and
                    existing_description == description):
                    # No changes detected, skip the update
                    logger.info(f"{appuser} --> {__name__}: No changes detected for header_id {header_id} and line_id {line_id}. Skipping update.")
                    continue

                # If there are changes, perform the update
                update_query = """
                    UPDATE fin.default_accounts
                    SET account_id = %s, account_type = %s, description = %s, updated_by = %s, updated_at = NOW()
                    WHERE header_id = %s AND line_id = %s
                """
                update_values = (account_id, account_type, description, updated_by, header_id, line_id)

                logger.debug(f"{appuser} --> {__name__}: Executing query: {update_query} with values: {update_values}")
                mycursor.execute(update_query, update_values)
                mydb.commit()

            mycursor.close()
            mydb.close()

        logger.info(f"{appuser} --> {__name__}: Default accounts updated successfully")
        return jsonify({'message': 'Default accounts updated successfully'}), 200
    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Error updating default account - {str(e)}")
        import traceback
        traceback.print_exc()
        return jsonify({'error': 'Internal Server Error'}), 500
