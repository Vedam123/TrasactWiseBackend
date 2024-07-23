from flask import request, jsonify, Blueprint
from modules.utilities.logger import logger
from flask_jwt_extended import decode_token
import uuid
from modules.security.permission_required import permission_required
from modules.security.get_user_from_token import get_user_from_token
from modules.finance.routines.auto_create_journal_logic import auto_create_journal_logic
from config import WRITE_ACCESS_TYPE

auto_create_journal_api = Blueprint('auto_create_journal_api', __name__)

@auto_create_journal_api.route('/auto_create_journal', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def auto_create_journal():
    execution_id = str(uuid.uuid4())
    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header) if authorization_header else None
        USER_ID = token_results["username"] if token_results else ""
        MODULE_NAME = __name__

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'auto_create_journal' function")

        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        current_userid = None
        if authorization_header and authorization_header.startswith('Bearer '):
            token = authorization_header.replace('Bearer ', '')
            decoded_token = decode_token(token)
            current_userid = decoded_token.get('Userid')   

        context = {
            'USER_ID': USER_ID,
            'MODULE_NAME': MODULE_NAME,
            'current_userid': current_userid
        }
        
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Before calling auto_create_journal_logic function")
        responses = auto_create_journal_logic(data, context)
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: After calling auto_create_journal_logic function {responses}")
        
        return jsonify({"success": True, "responses": responses}), 200

    except Exception as e:
        logger.error(f"Error in auto_create_journal: {str(e)}")
        return jsonify({"error": str(e)}), 500
