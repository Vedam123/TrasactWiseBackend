import json
import openai
from flask import Blueprint, jsonify, request
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from config import (
    OPENAI_API_KEY
)
from modules.utilities.logger import logger  # Import the logger module

# Define Blueprint
llm_chat_api = Blueprint('llm_chat_api', __name__)

@llm_chat_api.route('/generate_response', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def generate_response():
    try:
        authorization_header = request.headers.get('Authorization')

        # Validate user and database details
        try:
            company, instance, dbuser, mydb, appuser, appuserid, user_info, employee_info = get_user_and_db_details(authorization_header)
            logger.debug(f"{appuser} --> {__name__}: Successfully retrieved user details from token.")
        except ValueError as e:
            logger.error(f"Failed to retrieve user details from token. Error: {str(e)}")
            return jsonify({"error": str(e)}), 401

        if not appuser:
            logger.error(f"Unauthorized access attempt: {appuser} --> {__name__}: Application user not found.")
            return jsonify({"error": "Unauthorized. Username not found."}), 401

        # Get request data
        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        # Ensure required field exists
        if 'prompt' not in data:
            return jsonify({'error': 'Missing required field: prompt'}), 400

        prompt = data['prompt']
        logger.debug(f"{appuser} --> {__name__}: Received prompt: {prompt}")

        # OpenAI API call
        client = openai.OpenAI(api_key=OPENAI_API_KEY)
        response = client.chat.completions.create(
            model="gpt-4o-mini",
            store=True,
            messages=[{"role": "user", "content": prompt}]
        )

        result = response.choices[0].message.content
        logger.info(f"{appuser} --> {__name__}: Successfully generated response")

        return jsonify({'response': result})
    
    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
