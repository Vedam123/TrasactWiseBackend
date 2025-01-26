import os
from flask import Blueprint, jsonify, request, send_file
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.utilities.logger import logger

file_api = Blueprint('file_api', __name__)

@file_api.route('/download_file', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def download_file():
    try:
        # Authenticate user
        authorization_header = request.headers.get('Authorization')
        try:
            company, instance, dbuser, mydb, appuser, appuserid, user_info, employee_info = get_user_and_db_details(authorization_header)
            logger.debug(f"{appuser} --> {__name__}: Successfully retrieved user details from the token.")
        except ValueError as e:
            logger.error(f"Failed to retrieve user details from token. Error: {str(e)}")
            return jsonify({"error": str(e)}), 401

        if not appuser:
            logger.error(f"Unauthorized access attempt: {appuser} --> {__name__}: Application user not found.")
            return jsonify({"error": "Unauthorized. Username not found."}), 401

        # Get the requested file path from query parameters
        file_path = request.args.get('file_path')
        if not file_path or not os.path.exists(file_path):
            logger.error(f"{appuser} --> {__name__}: Invalid or missing file path.")
            return jsonify({"error": "Invalid or missing file path."}), 400

        logger.debug(f"{appuser} --> {__name__}: Downloading file {file_path}")
        return send_file(file_path, as_attachment=True)

    except Exception as e:
        logger.error(f"Error downloading file: {str(e)}")
        return jsonify({'error': 'Internal Server Error'}), 500
