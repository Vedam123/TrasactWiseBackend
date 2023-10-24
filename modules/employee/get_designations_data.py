from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger  # Import the logger module

get_designations_data_api = Blueprint('get_designations_data_api', __name__)

@get_designations_data_api.route('/designations/get_designations_data', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_designations_data():
    try:
        authorization_header = request.headers.get('Authorization')
        token_results = ""
        USER_ID = ""
        MODULE_NAME = __name__
        if authorization_header:
            token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None

        if token_results:
            USER_ID = token_results["username"]
        
        # Log entry point
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the get designations data function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)
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
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
