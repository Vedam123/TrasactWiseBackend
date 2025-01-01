from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger
from modules.finance.routines.update_journal_line_logic import update_journal_line_logic 

journal_api = Blueprint('journal_api', __name__)

@journal_api.route('/update_journal_line', methods=['PUT'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def update_journal_line():
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

    logger.debug(f"{appuser} --> {__name__}: Entered the 'update_journal_line' function")


    if request.content_type == 'application/json':
        data = request.get_json()
    else:
        data = request.form

    logger.debug(f"{appuser} --> {__name__}: Received data: {data}")

    response, status_code = update_journal_line_logic(data, mydb, __name__, appuser,appuserid)
    
    return jsonify(response), status_code
