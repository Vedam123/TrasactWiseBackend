print("Starting app.py")  # Add this line

from flask import Flask
from flask_cors import CORS
from flask_jwt_extended import JWTManager, current_user
from blueprints import register_blueprints
from config import JWT_SECRET_KEY, JWT_ACCESS_TOKEN_EXPIRES
from modules.security.refresh_token import refresh_token
from authorization import authorize_user

app = Flask(__name__)
CORS(app)

# JWT Configuration
app.config["JWT_SECRET_KEY"] = JWT_SECRET_KEY
app.config["JWT_ACCESS_TOKEN_EXPIRES"] = JWT_ACCESS_TOKEN_EXPIRES

jwt = JWTManager(app)

if __name__ == '__main__':
    register_blueprints(app)
    app.config['DEBUG'] = True
    print("The call arrived")
    app.run(debug=True, host='localhost', port=8010)
