from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

get_default_tax_headers_api = Blueprint('get_default_tax_headers_api', __name__)

@get_default_tax_headers_api.route('/get_default_tax_headers', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_default_tax_headers():
    MODULE_NAME = __name__

    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'get_default_tax_headers' function")

        # Get the header_id from the request parameters
        header_id = request.args.get('header_id')

        mydb = get_database_connection(USER_ID, MODULE_NAME)
        mycursor = mydb.cursor()

        # Prepare the query based on whether header_id is provided
        if header_id:
            query = """
                SELECT
                    dtc.header_id,
                    dtc.description,
                    dtc.created_at,
                    dtc.updated_at
                FROM com.default_tax_config dtc
                WHERE dtc.header_id = %s
            """
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: Executing query: {query} with header_id: {header_id}")
            mycursor.execute(query, (header_id,))
        else:
            query = """
                SELECT
                    dtc.header_id,
                    dtc.description,
                    dtc.created_at,
                    dtc.updated_at
                FROM com.default_tax_config dtc
            """
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: Executing query: {query}")
            mycursor.execute(query)

        result = mycursor.fetchall()
        get_default_tax_headers_list = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        for row in result:
            default_tax_header_dict = {}

            for column in columns:
                default_tax_header_dict[column] = row[column_indices[column]]

            get_default_tax_headers_list.append(default_tax_header_dict)

        mycursor.close()
        mydb.close()

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Successfully retrieved default tax codes data")

        return jsonify({'default_tax_headers': get_default_tax_headers_list})

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error retrieving default tax codes data - {str(e)}")
        return jsonify({'error': 'Internal Server Error'}), 500
