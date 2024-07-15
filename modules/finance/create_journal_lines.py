from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger
from modules.finance.routines.create_journal_line_logic import create_journal_line_logic  # Import the logic function

journal_api = Blueprint('journal_api', __name__)

@journal_api.route('/create_journal_line', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_journal_line():
    authorization_header = request.headers.get('Authorization')
    token_results = ""
    USER_ID = ""
    MODULE_NAME = __name__

    if authorization_header:
        token_results = get_user_from_token(authorization_header)

    if token_results:
        USER_ID = token_results["username"]

    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'create_journal_line' function")

    mydb = get_database_connection(USER_ID, MODULE_NAME)

    current_userid = None
    if authorization_header.startswith('Bearer '):
        token = authorization_header.replace('Bearer ', '')
        decoded_token = decode_token(token)
        current_userid = decoded_token.get('Userid')

    if request.content_type == 'application/json':
        data = request.get_json()
    else:
        data = request.form

    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Received data: {data}")

    # Prepare the context object
    context = {
        'USER_ID': USER_ID,
        'MODULE_NAME': MODULE_NAME,
        'current_userid': current_userid,
        'mydb': mydb
    }

    response, status_code = create_journal_line_logic(data, context)
    
    return jsonify(response), status_code
