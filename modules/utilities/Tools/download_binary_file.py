import os
from flask import Blueprint, jsonify, request, make_response
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.utilities.logger import logger

download_binary_file_api = Blueprint('download_binary_file_api', __name__)

@download_binary_file_api.route('/download_binary_file', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def download_binary_file():
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

        logger.debug(f"{appuser} --> {__name__}: Entered the 'get_and_download_file' function")

        # Directory structure
        curr_dir = os.path.abspath(os.curdir)
        product_info_dir = os.path.join(curr_dir, 'Documents', 'SetupGuides', 'Project Info')

        if not os.path.exists(product_info_dir):
            logger.error(f"{appuser} --> {__name__}: Directory 'Project Info' not found.")
            return jsonify({"error": "'Project Info' directory not found."}), 404

        # Collect metadata for all files
        files_data = []
        for root, dirs, files in os.walk(product_info_dir):
            for file in files:
                file_path = os.path.join(root, file)
                files_data.append({'filename': file, 'path': file_path})

        logger.debug(f"{appuser} --> {__name__}: Successfully retrieved file metadata from 'Project Info' directory")

        # Check if a specific file is requested
        file_path = request.args.get('file_path')
        if file_path:
            # Validate if the requested file exists
            matching_file = next((file for file in files_data if file['path'] == file_path), None)
            if not matching_file:
                logger.error(f"{appuser} --> {__name__}: Requested file does not exist.")
                return jsonify({"error": "File not found."}), 404

            # Get file details
            filename = os.path.basename(file_path)
            logger.debug(f"{appuser} --> {__name__}: Sending file {file_path} as binary")

            # Read the binary content of the file
            with open(file_path, 'rb') as file:
                file_content = file.read()

            # Return the filename, file path, and binary content
            return jsonify({
                "filename": filename,
                "file_path": file_path,
                "file_content": file_content.decode('latin1')  # Encode binary for transport
            })

        # If no file_path is provided, return the list of all files
        return jsonify({'files': files_data})

    except Exception as e:
        logger.error(f"Error retrieving or downloading file: {str(e)}")
        return jsonify({'error': 'Internal Server Error'}), 500
