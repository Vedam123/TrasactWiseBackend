from flask import Flask
from flask_cors import CORS
from flask_jwt_extended import JWTManager, current_user
from blueprints import register_blueprints
from config import JWT_SECRET_KEY, JWT_ACCESS_TOKEN_EXPIRES,APP_SERVER_HOST,APP_SERVER_PORT
#from modules.security.refresh_token import refresh_token
#from authorization import authorize_user

# Type-cast APP_SERVER_PORT to an integer
APP_SERVER_PORT = int(APP_SERVER_PORT)
 
app = Flask(__name__)
CORS(app)

# JWT Configuration
app.config["JWT_SECRET_KEY"] = JWT_SECRET_KEY
app.config["JWT_ACCESS_TOKEN_EXPIRES"] = JWT_ACCESS_TOKEN_EXPIRES

jwt = JWTManager(app)

if __name__ == '__main__':
    register_blueprints(app)
    app.config['DEBUG'] = True
    #app.run(debug=True, host='localhost', port=8010)
    app.run(debug=True, host=APP_SERVER_HOST, port=APP_SERVER_PORT)