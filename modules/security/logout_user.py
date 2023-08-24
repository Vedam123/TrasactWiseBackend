from flask import Blueprint, jsonify

logout_data_api = Blueprint('logout_data_api', __name__)

@logout_data_api.route("/logout", methods=["POST"])
#@jwt_required()  # Require a valid JWT token to access this route
def logout():
    response = jsonify({"msg": "logout successful"})
    return response

