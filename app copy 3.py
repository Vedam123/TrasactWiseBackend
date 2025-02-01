from flask import Flask
from flask_cors import CORS
from flask_jwt_extended import JWTManager, current_user
from blueprints import register_blueprints
from config import JWT_SECRET_KEY, JWT_ACCESS_TOKEN_EXPIRES, APP_SERVER_HOST, APP_SERVER_PORT, SSL_CRT_FILE, SSL_KEY_FILE
import os
from waitress import serve
import ssl
import logging

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

    # Create an SSL context for the application
    context = ssl.create_default_context(ssl.Purpose.CLIENT_AUTH)
    context.load_cert_chain(certfile=cert_path, keyfile=key_path)

    # Log the paths for debugging
    logging.info(f"SSL Certificate Path: {cert_path}")
    logging.info(f"SSL Key Path: {key_path}")

    # Create a standard HTTP server using Waitress
    logging.info(f"Starting HTTP server on https://{APP_SERVER_HOST}:{APP_SERVER_PORT}")
    
    # Create the HTTP server
    http_server = serve(app, host=APP_SERVER_HOST, port=APP_SERVER_PORT)

    # Wrap the HTTP server with SSL context manually
    http_server.socket = context.wrap_socket(http_server.socket, server_side=True)

    # Print message indicating server has started
    logging.info(f"Server will start on https://{APP_SERVER_HOST}:{APP_SERVER_PORT}")
    
    try:
        # Start the server
        http_server.run()
    except Exception as e:
        logging.error(f"Error while starting the server: {e}")
