from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required  # Import the decorator
from config import WRITE_ACCESS_TYPE    # Import WRITE_ACCESS_TYPE
from flask_jwt_extended import (
    create_access_token,
    get_jwt_identity,
    jwt_required,
    unset_jwt_cookies,
)

refresh_token_api = Blueprint('refresh_token_api', __name__)

@refresh_token_api.route('/refresh_token', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE ,  __file__)  # Pass WRITE_ACCESS_TYPE as an argument
@jwt_required(refresh=True)  # This requires a valid refresh token
def refresh_token():
    try:
        print("The Input token is correct")
        current_user = get_jwt_identity()
        # Generate a new access token
        new_access_token = create_access_token(identity=current_user)
        # Return the new access token in the response
        return jsonify({"access_token": new_access_token})
    except (RuntimeError, KeyError):
        # Case where there is not a valid JWT. Just return the original response.
        pass
    return None  # Return None to indicate that the middleware should continue to the next handler.