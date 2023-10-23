from flask_jwt_extended import decode_token

def get_user_from_token(authorization_header):
    if not authorization_header:
        return None

    token = authorization_header.replace('Bearer ', '')

    if token:
        try:
            token_data = decode_token(token)
            current_user_id = token_data.get('Userid')
            username = token_data.get('sub')
            return {
                'current_user_id': current_user_id,
                'username': username
            }
        except Exception as e:
            return None
