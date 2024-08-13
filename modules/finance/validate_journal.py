from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

journal_api = Blueprint('journal_api', __name__)

@journal_api.route('/validate_journal', methods=['GET'])  # Changed to GET
@permission_required(WRITE_ACCESS_TYPE, __file__)
def validate_journal():
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
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'validate_journal' function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)

        current_userid = None
        if authorization_header.startswith('Bearer '):
            token = authorization_header.replace('Bearer ', '')
            decoded_token = decode_token(token)
            current_userid = decoded_token.get('Userid')

        # Fetching the journal_number from the query parameters
        journal_number = request.args.get('journal_number')

        if not journal_number:
            logger.error(f"{USER_ID} --> {MODULE_NAME}: journal_number is missing from the request")
            return jsonify({'error': 'journal_number is required'}), 400

        # Query to fetch the header_id based on the journal_number
        fetch_header_id_query = """
            SELECT header_id FROM fin.journal_headers WHERE journal_number = %s
        """

        mycursor = mydb.cursor()
        mycursor.execute(fetch_header_id_query, (journal_number,))
        result = mycursor.fetchone()

        if not result:
            logger.error(f"{USER_ID} --> {MODULE_NAME}: No journal found for journal_number {journal_number}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': 'No journal found with the provided journal_number'}), 404

        header_id = result[0]
        
        # Log the fetched header_id
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Fetched header_id: {header_id} for journal_number: {journal_number}")

        # Query to sum the debit and credit for the given header_id
        fetch_sums_query = """
            SELECT SUM(debit) as total_debit, SUM(credit) as total_credit
            FROM fin.journal_lines WHERE header_id = %s
        """
        mycursor.execute(fetch_sums_query, (header_id,))
        sums_result = mycursor.fetchone()

        if sums_result:
            total_debit, total_credit = sums_result
            # Log the debit and credit sums
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: Debit Sum: {total_debit}, Credit Sum: {total_credit} for header_id: {header_id}")

            if total_debit == total_credit:
                logger.info(f"{USER_ID} --> {MODULE_NAME}: Journal validation successful. Totals are equal.")
                response = {'valid': True, 'message': 'Journal is valid. Debit and Credit totals are equal.'}
            else:
                logger.warning(f"{USER_ID} --> {MODULE_NAME}: Journal validation failed. Debit and Credit totals are not equal.")
                response = {'valid': False, 'message': 'Journal is not valid. Debit and Credit totals are not equal.'}
        else:
            logger.error(f"{USER_ID} --> {MODULE_NAME}: No lines found for header_id {header_id}")
            response = {'error': 'No lines found for the provided journal header.'}

        mycursor.close()
        mydb.close()

        return jsonify(response), 200

    except Exception as e:
        # Log any exceptions
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
