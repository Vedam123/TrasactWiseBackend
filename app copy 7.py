from flask import Flask, request
from flask_cors import CORS
from flask_jwt_extended import JWTManager
from blueprints import register_blueprints
from config import JWT_SECRET_KEY, JWT_ACCESS_TOKEN_EXPIRES, APP_SERVER_HOST, APP_SERVER_PORT
import os
from waitress import serve

# Allow all origins
ALLOWED_ORIGINS = "*"

# Type-cast APP_SERVER_PORT to an integer
APP_SERVER_PORT = int(APP_SERVER_PORT)

app = Flask(__name__)

# Manually adding CORS headers for all responses
@app.after_request
def after_request(response):
    response.headers.add('Access-Control-Allow-Origin', ALLOWED_ORIGINS)
    response.headers.add('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, DELETE')
    response.headers.add('Access-Control-Allow-Headers', 'Content-Type, Authorization')
    return response

# JWT Configuration
app.config["JWT_SECRET_KEY"] = JWT_SECRET_KEY
app.config["JWT_ACCESS_TOKEN_EXPIRES"] = JWT_ACCESS_TOKEN_EXPIRES

jwt = JWTManager(app)

register_blueprints(app)

if __name__ == '__main__':
    # Serve using waitress
    serve(app, host=APP_SERVER_HOST, port=APP_SERVER_PORT, threads=2)
