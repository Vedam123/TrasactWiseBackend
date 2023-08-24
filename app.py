from flask import Flask
from flask_cors import CORS
from flask_jwt_extended import JWTManager, current_user
from blueprints import register_blueprints
from config import JWT_SECRET_KEY, JWT_ACCESS_TOKEN_EXPIRES
from modules.security.refresh_token import refresh_expiring_jwts
from authorization import authorize_user

app = Flask(__name__)
CORS(app)

# JWT Configuration
app.config["JWT_SECRET_KEY"] = JWT_SECRET_KEY
app.config["JWT_ACCESS_TOKEN_EXPIRES"] = JWT_ACCESS_TOKEN_EXPIRES

jwt = JWTManager(app)

# Authorization Middleware
#app.before_request(authorize_user)

#@app.before_request
#def before_request_handler():
    # Call the refresh_expiring_jwts_middleware to refresh JWT tokens before accessing protected routes.
#    response = refresh_expiring_jwts()
#    print("response value",response)
#    if response:
#        return response

if __name__ == '__main__':
    register_blueprints(app)
    app.config['DEBUG'] = True
    print("The call arrived")
    app.run(debug=True, host='localhost', port=8010)
