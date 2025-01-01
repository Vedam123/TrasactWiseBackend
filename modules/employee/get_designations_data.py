from flask import Blueprint, jsonify, request
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.utilities.logger import logger  # Import the logger module

get_designations_data_api = Blueprint('get_designations_data_api', __name__)

@get_designations_data_api.route('/designations/get_designations_data', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_designations_data():
    try:
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
        
        mycursor = mydb.cursor()
        mycursor.execute("SELECT * FROM com.designations")
        result = mycursor.fetchall()
        designations = []

        # Get the column names from the cursor's description
        column_names = [desc[0] for desc in mycursor.description]

        for row in result:
            designation_dict = {}
            for i, value in enumerate(row):
                column_name = column_names[i]
                designation_dict[column_name] = value

            designations.append(designation_dict)

        # Close the cursor and connection
        mycursor.close()
        mydb.close()

        return jsonify(designations)
    except Exception as e:
        # Log any exceptions
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
