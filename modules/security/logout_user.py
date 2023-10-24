from flask import Blueprint, jsonify, request
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger  # Import the logger module

logout_data_api = Blueprint('logout_data_api', __name__)

@logout_data_api.route("/logout", methods=["POST"])
#@jwt_required()  # Require a valid JWT token to access this route
def logout():
    authorization_header = request.headers.get('Authorization')
    token_results = ""
    USER_ID = ""
    MODULE_NAME = __name__
    if authorization_header:
        token_results = get_user_from_token(authorization_header)

    if token_results:
        USER_ID = token_results["username"]

    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Logout function is called, user is now logged out")

    response = jsonify({"msg": "logout successful"})
    return response


