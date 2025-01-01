from flask_jwt_extended import decode_token
from modules.utilities.logger import logger  # Import the logger module

def get_user_from_token(authorization_header):
    MODULE_NAME = __name__
    if not authorization_header:
        return None

    token = authorization_header.replace('Bearer ', '')  # Remove 'Bearer ' prefix
    if token:
        try:
            # Decode the token and get all the data
            token_data = decode_token(token)
            username = token_data.get('Userid')
            logger.debug(f"{MODULE_NAME} and {username}: Successfully retrieved data from token from get user token")
            
            # Return all the fields present in the token
            return token_data

        except Exception as e:
            logger.error(f"{MODULE_NAME}: Error while decoding token: {str(e)}")
            return None
