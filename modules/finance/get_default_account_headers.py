from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import READ_ACCESS_TYPE
from modules.utilities.logger import logger

get_default_account_headers_api = Blueprint('get_default_account_headers_api', __name__)

@get_default_account_headers_api.route('/get_default_account_headers', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_default_account_headers():
    

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

        logger.debug(f"{appuser} --> {__name__}: Entered the 'get_default_account_headers' function")

        mycursor = mydb.cursor()

        # Fetch header_id from query parameters if provided
        header_id = request.args.get('header_id', default=None, type=int)

        # Base query
        query = """
            SELECT
                header_id,
                header_name,
                created_at,
                updated_at,
                created_by,
                updated_by
            FROM fin.default_account_headers
        """

        # Add WHERE clause if header_id is provided
        if header_id is not None:
            query += " WHERE header_id = %s"
            logger.debug(f"{appuser} --> {__name__}: Executing query with header_id filter: {query}")
            mycursor.execute(query, (header_id,))
        else:
            logger.debug(f"{appuser} --> {__name__}: Executing query: {query}")
            mycursor.execute(query)

        result = mycursor.fetchall()
        default_account_headers_list = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        for row in result:
            default_account_header_dict = {}
            for column in columns:
                default_account_header_dict[column] = row[column_indices[column]]
            default_account_headers_list.append(default_account_header_dict)

        mycursor.close()
        mydb.close()

        logger.debug(f"{appuser} --> {__name__}: Successfully retrieved default account headers data")

        return jsonify({'default_account_headers': default_account_headers_list})

    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Error retrieving default account headers data - {str(e)}")
        return jsonify({'error': 'Internal Server Error'}), 500
