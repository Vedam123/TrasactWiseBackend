from flask import Blueprint, jsonify, request
from modules.utilities.logger import logger  # Import the logger module
from modules.security.routines.get_user_and_db_details import get_user_and_db_details

logout_data_api = Blueprint('logout_data_api', __name__)

@logout_data_api.route("/logout", methods=["POST"])
#@jwt_required()  # Require a valid JWT token to access this route
def logout():
    authorization_header = request.headers.get('Authorization')
    try:
        company, instance, dbuser, mydb, appuser, appuserid, user_info, employee_info = get_user_and_db_details(authorization_header)
    except ValueError as e:
        return jsonify({"error": str(e)}), 401
        
    if not appuser:
        return jsonify({"error": "Unauthorized. Username not found."}), 401

    logger.debug(f"{appuser} --> { __name__}: Logout function is called, user is now logged out")

    response = jsonify({"msg": "logout successful"})
    mydb.close()
    return response



