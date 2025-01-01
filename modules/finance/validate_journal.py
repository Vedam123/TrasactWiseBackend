from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger

journal_api = Blueprint('journal_api', __name__)

@journal_api.route('/validate_journal', methods=['GET'])  # Changed to GET
@permission_required(WRITE_ACCESS_TYPE, __file__)
def validate_journal():
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
        # Log entry point
        logger.debug(f"{appuser} --> {__name__}: Entered the 'validate_journal' function")

        # Fetching the journal_number from the query parameters
        journal_number = request.args.get('journal_number')

        if not journal_number:
            logger.error(f"{appuser} --> {__name__}: journal_number is missing from the request")
            return jsonify({'error': 'journal_number is required'}), 400

        # Query to fetch the header_id based on the journal_number
        fetch_header_id_query = """
            SELECT header_id FROM fin.journal_headers WHERE journal_number = %s
        """

        mycursor = mydb.cursor()
        mycursor.execute(fetch_header_id_query, (journal_number,))
        result = mycursor.fetchone()

        if not result:
            logger.error(f"{appuser} --> {__name__}: No journal found for journal_number {journal_number}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': 'No journal found with the provided journal_number'}), 404

        header_id = result[0]
        
        # Log the fetched header_id
        logger.debug(f"{appuser} --> {__name__}: Fetched header_id: {header_id} for journal_number: {journal_number}")

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
            logger.debug(f"{appuser} --> {__name__}: Debit Sum: {total_debit}, Credit Sum: {total_credit} for header_id: {header_id}")

            if total_debit == total_credit:
                logger.info(f"{appuser} --> {__name__}: Journal validation successful. Totals are equal.")
                response = {'valid': True, 'message': 'Journal is valid. Debit and Credit totals are equal.'}
            else:
                logger.warning(f"{appuser} --> {__name__}: Journal validation failed. Debit and Credit totals are not equal.")
                response = {'valid': False, 'message': 'Journal is not valid. Debit and Credit totals are not equal.'}
        else:
            logger.error(f"{appuser} --> {__name__}: No lines found for header_id {header_id}")
            response = {'error': 'No lines found for the provided journal header.'}

        mycursor.close()
        mydb.close()

        return jsonify(response), 200

    except Exception as e:
        # Log any exceptions
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
