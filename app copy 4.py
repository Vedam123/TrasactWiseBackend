from flask import Flask
from flask_cors import CORS
from flask_jwt_extended import JWTManager
from blueprints import register_blueprints
from config import JWT_SECRET_KEY, JWT_ACCESS_TOKEN_EXPIRES, APP_SERVER_HOST, APP_SERVER_PORT, SSL_CRT_FILE, SSL_KEY_FILE
import os

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

    # Use the imported SSL certificate and key paths from the config
    cert_path = os.path.abspath(SSL_CRT_FILE)  # Absolute path to the certificate
    key_path = os.path.abspath(SSL_KEY_FILE)   # Absolute path to the key file

    app.run(debug=True, host=APP_SERVER_HOST, port=APP_SERVER_PORT, ssl_context=(cert_path, key_path))
