import os
from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.utilities.logger import logger

file_api = Blueprint('file_api', __name__)

@file_api.route('/get_file_paths', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_file_paths():
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

        logger.debug(f"{appuser} --> {__name__}: Entered the 'get_files' function")

        # Determine the directory structure
        curr_dir = os.path.abspath(os.curdir)
        par_dir = os.path.dirname(curr_dir)
        g_par_dir = os.path.dirname(par_dir)
        gg_par_dir = os.path.dirname(g_par_dir)
        
        # Locate the SetupGuides/Project Info directory
        docu_guides_dir = os.path.join(curr_dir, 'Documents')
        setup_guides_dir = os.path.join(docu_guides_dir, 'SetupGuides')
        product_info_dir = os.path.join(setup_guides_dir, 'Project Info')

        if not os.path.exists(product_info_dir):
            logger.error(f"{appuser} --> {__name__}: Directory 'Project Info' not found.")
            return jsonify({"error": "'Project Info' directory not found."}), 404

        # Collect metadata for all files in the Project Info directory
        files_data = []
        for root, dirs, files in os.walk(product_info_dir):
            for file in files:
                file_path = os.path.join(root, file)
                files_data.append({'filename': file, 'path': file_path})

        logger.debug(f"{appuser} --> {__name__}: Successfully retrieved file metadata from 'Project Info' directory")

        return jsonify({'files': files_data})

    except Exception as e:
        logger.error(f"Error retrieving files: {str(e)}")
        return jsonify({'error': 'Internal Server Error'}), 500
