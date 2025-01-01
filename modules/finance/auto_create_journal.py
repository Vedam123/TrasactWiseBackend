from flask import request, jsonify, Blueprint
from modules.utilities.logger import logger
import uuid
from modules.security.permission_required import permission_required
from modules.finance.routines.auto_create_journal_logic import auto_create_journal_logic
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import WRITE_ACCESS_TYPE

auto_create_journal_api = Blueprint('auto_create_journal_api', __name__)

@auto_create_journal_api.route('/auto_create_journal', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def auto_create_journal():
    execution_id = str(uuid.uuid4())
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
        

        logger.debug(f"{appuser} --> {__name__}: Entered the 'auto_create_journal' function")

        data = request.get_json() if request.content_type == 'application/json' else request.form

        
        logger.debug(f"{appuser} --> {__name__}: Before calling auto_create_journal_logic function sent data {data} ")
        responses = auto_create_journal_logic(data,  mydb, __name__, appuser,appuserid)
        logger.debug(f"{appuser} --> {__name__}: After calling auto_create_journal_logic function {responses}")
        
        return jsonify({"success": True, "responses": responses}), 200

    except Exception as e:
        logger.error(f"Error in auto_create_journal: {str(e)}")
        return jsonify({"error": str(e)}), 500
