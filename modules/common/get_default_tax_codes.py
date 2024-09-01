from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

get_default_tax_codes_api = Blueprint('get_default_tax_codes_api', __name__)

@get_default_tax_codes_api.route('/get_default_tax_codes', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_default_tax_codes():
    MODULE_NAME = __name__

    try:
        # Extract Authorization header and decode user information
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'get_default_tax_codes' function")

        # Get the 'header_id' from the query parameters
        header_id = request.args.get('header_id', None)

        # Create a database connection
        mydb = get_database_connection(USER_ID, MODULE_NAME)
        mycursor = mydb.cursor()

        # Base query
        query = """
            SELECT
                line_id,
                header_id,
                tax_id,
                tax_type,
                description,
                created_at,
                updated_at
            FROM com.default_tax_codes
        """

        # If 'header_id' is provided, add a WHERE clause to the query
        if header_id is not None:
            query += " WHERE header_id = %s"

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Executing query: {query}")

        # Execute the query
        if header_id is not None:
            mycursor.execute(query, (header_id,))
        else:
            mycursor.execute(query)

        result = mycursor.fetchall()
        default_tax_codes_list = []

        # Retrieve column names from cursor description
        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        # Map result rows to dictionaries
        for row in result:
            default_tax_code_dict = {}
            for column in columns:
                default_tax_code_dict[column] = row[column_indices[column]]
            default_tax_codes_list.append(default_tax_code_dict)

        # Close cursor and connection
        mycursor.close()
        mydb.close()

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Successfully retrieved default tax codes data")

        # Return the result as JSON
        return jsonify({'default_tax_codes': default_tax_codes_list})

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error retrieving default tax codes data - {str(e)}")
        return jsonify({'error': 'Internal Server Error'}), 500
