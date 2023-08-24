from flask import request, jsonify, current_app
from datetime import datetime, timedelta, timezone
from flask_jwt_extended import get_jwt, create_access_token,get_jwt_identity

def refresh_expiring_jwts():
    try:
        exp_timestamp = get_jwt()["exp"]
        now = datetime.now(timezone.utc)
        target_timestamp = datetime.timestamp(now + timedelta(seconds=30))

        if target_timestamp > exp_timestamp:
            # Token needs to be refreshed
            current_identity = get_jwt_identity()
            access_token = create_access_token(identity=current_identity,
                                               expires_delta=current_app.config["JWT_ACCESS_TOKEN_EXPIRES"])
            response = jsonify({'message': 'Token refreshed MR VEDAM NEW CALL'})
            response.set_cookie("access_token_cookie", access_token)  # Optionally, you can use a cookie for the new token.
            return response

    except (RuntimeError, KeyError):
        # Case where there is not a valid JWT. Just return the original response.
        pass

    return None  # Return None to indicate that the middleware should continue to the next handler.

