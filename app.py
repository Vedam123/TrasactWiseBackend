from flask import Flask
from flask_cors import CORS
from flask_jwt_extended import JWTManager
from blueprints import register_blueprints
from config import (
    JWT_SECRET_KEY, JWT_ACCESS_TOKEN_EXPIRES, APP_SERVER_HOST, APP_SERVER_PORT, 
    SSL_CRT_FILE, SSL_KEY_FILE, BACKEND_ENVIRONMENT
)
import os
from gevent.pywsgi import WSGIServer  # ✅ Use gevent for SSL in production

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
    app.config['DEBUG'] = BACKEND_ENVIRONMENT != "Production"

    cert_path = os.path.abspath(SSL_CRT_FILE)  # Absolute path to the certificate
    key_path = os.path.abspath(SSL_KEY_FILE)   # Absolute path to the key file

    if BACKEND_ENVIRONMENT == "Production":
        print(f"Starting server on {APP_SERVER_HOST}:{APP_SERVER_PORT} in Production mode with SSL...")

        # Use gevent WSGI server with SSL
        http_server = WSGIServer((APP_SERVER_HOST, APP_SERVER_PORT), app, 
                                 keyfile=key_path, certfile=cert_path)
        http_server.serve_forever()

    else:
        print(f"Starting server on {APP_SERVER_HOST}:{APP_SERVER_PORT} in Development mode...")
        # Flask built-in server should not be used in production
        app.run(debug=True, host=APP_SERVER_HOST, port=APP_SERVER_PORT, ssl_context=(cert_path, key_path))