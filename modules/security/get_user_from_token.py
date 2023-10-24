from flask_jwt_extended import decode_token
from modules.utilities.logger import logger  # Import the logger module

def get_user_from_token(authorization_header):
    MODULE_NAME = __name__

    if not authorization_header:
        return None

    token = authorization_header.replace('Bearer ', '')

    if token:
        try:
            token_data = decode_token(token)
            current_user_id = token_data.get('Userid')
            username = token_data.get('sub')
            logger.debug(f"{MODULE_NAME}: Successfully retrieved user data from token")
            return {
                'current_user_id': current_user_id,
                'username': username
            }
        except Exception as e:
            logger.error(f"{MODULE_NAME}: Error while decoding token: {str(e)}")
            return None
