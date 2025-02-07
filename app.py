import os
import sys
from flask import Flask
from flask_cors import CORS
from flask_jwt_extended import JWTManager
from blueprints import register_blueprints
from config import (
    JWT_SECRET_KEY, JWT_ACCESS_TOKEN_EXPIRES, APP_SERVER_HOST, APP_SERVER_PORT, 
    SSL_CRT_FILE, SSL_KEY_FILE, BACKEND_ENVIRONMENT, CERT_ABS_PATH1, KEY_ABS_PATH1
)
from hypercorn.asyncio import serve
from hypercorn.config import Config
import asyncio

# Type-cast APP_SERVER_PORT to an integer
APP_SERVER_PORT = int(APP_SERVER_PORT)

app = Flask(__name__)
CORS(app)

# JWT Configuration
app.config["JWT_SECRET_KEY"] = JWT_SECRET_KEY
app.config["JWT_ACCESS_TOKEN_EXPIRES"] = JWT_ACCESS_TOKEN_EXPIRES

jwt = JWTManager(app)

CERT_FILE = os.path.abspath(CERT_ABS_PATH1)
KEY_FILE = os.path.abspath(KEY_ABS_PATH1)

if __name__ == '__main__':
    register_blueprints(app)
    app.config['DEBUG'] = BACKEND_ENVIRONMENT != "Production"

    # Use absolute paths for certificates
    cert_path = CERT_FILE  # Absolute path to the certificate
    key_path = KEY_FILE   # Absolute path to the key file

    if BACKEND_ENVIRONMENT == "Production":
        print(f"Starting Server on https://{APP_SERVER_HOST}:{APP_SERVER_PORT} in Production mode with Hypercorn...")

        config = Config()
        config.bind = [f"{APP_SERVER_HOST}:{APP_SERVER_PORT}"]
        config.certfile = CERT_FILE
        config.keyfile = KEY_FILE
        config.workers = 1  # Adjust as needed

        # Run Hypercorn in an async loop
        asyncio.run(serve(app, config))

    else:
        print(f"Starting server on {APP_SERVER_HOST}:{APP_SERVER_PORT} in Development mode...")
        app.run(debug=True, host=APP_SERVER_HOST, port=APP_SERVER_PORT, ssl_context=(CERT_FILE, KEY_FILE))
