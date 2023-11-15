from flask import Blueprint, jsonify, request,current_app
from modules.security.permission_required import permission_required  # Import the decorator
from modules.security.get_user_from_token import get_user_from_token
from config import WRITE_ACCESS_TYPE    # Import WRITE_ACCESS_TYPE
from flask_jwt_extended import (
    create_access_token,
    get_jwt_identity,
    jwt_required
)
from modules.utilities.logger import logger  # Import the logger module
from modules.security.get_user_from_token import get_user_from_token
from config import JWT_ACCESS_TOKEN_EXPIRES


get_new_token_api = Blueprint('get_new_token_api', __name__)

@get_new_token_api.route('/get_new_token', methods=['GET'])
#@permission_required(WRITE_ACCESS_TYPE, __file__)  # Pass WRITE_ACCESS_TYPE as an argument
#@jwt_required(refresh=True)  # This requires a valid refresh token
def get_new_token():
    print("Entered in get_new_token function")
    authorization_header = request.headers.get('Authorization')
    token_results = ""
    new_access_token = ""
    TOKEN_USER_NAME = ""
    TOKEN_USER_ID = ""
    MODULE_NAME = __name__
    expires_in_seconds = int(current_app.config["JWT_ACCESS_TOKEN_EXPIRES"].total_seconds())
    
    if authorization_header:
        token_results = get_user_from_token(authorization_header)
    print("What is token results",token_results)
    if token_results:
        TOKEN_USER_NAME = token_results["username"]
        TOKEN_USER_ID = token_results["current_user_id"]

    print("TOKEN USER NAME AND USER ID, TOKEN RESULTS ",TOKEN_USER_NAME,TOKEN_USER_ID,token_results)

    logger.debug(f"{TOKEN_USER_NAME} --> {MODULE_NAME}: Entered in the new  token generation function")

    try:
        logger.debug(f"{TOKEN_USER_NAME} --> {MODULE_NAME}: The Input token is correct")
        
        new_access_token = create_access_token(
            identity=TOKEN_USER_NAME, additional_claims={"Userid": TOKEN_USER_ID, "expires_in": expires_in_seconds}
        )
        print("New Access token ", new_access_token)
        return jsonify({"access_token": new_access_token, 
                        "token_expires_delta": expires_in_seconds})
    except (RuntimeError, KeyError):
        pass
    return None  # Return None to indicate that the middleware should continue to the next handler.
