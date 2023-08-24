from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from flask_jwt_extended import create_access_token, get_jwt, get_jwt_identity, \
                               unset_jwt_cookies, jwt_required, JWTManager
from config import JWT_SECRET_KEY, JWT_ACCESS_TOKEN_EXPIRES, APPLICATION_CREDENTIALS

logout_data_api = Blueprint('logout_data_api', __name__)

@logout_data_api.route("/logout", methods=["POST"])
#@jwt_required()  # Require a valid JWT token to access this route
def logout():
    response = jsonify({"msg": "logout successful"})
    return response

