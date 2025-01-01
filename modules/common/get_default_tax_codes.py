from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.utilities.logger import logger

get_default_tax_codes_api = Blueprint('get_default_tax_codes_api', __name__)

@get_default_tax_codes_api.route('/get_default_tax_codes', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_default_tax_codes():

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

        logger.debug(f"{appuser} --> {__name__}: Entered the 'get_default_tax_codes' function")

        # Get the 'header_id' from the query parameters
        header_id = request.args.get('header_id', None)

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

        logger.debug(f"{appuser} --> {__name__}: Executing query: {query}")

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

        logger.debug(f"{appuser} --> {__name__}: Successfully retrieved default tax codes data")

        # Return the result as JSON
        return jsonify({'default_tax_codes': default_tax_codes_list})

    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Error retrieving default tax codes data - {str(e)}")
        return jsonify({'error': 'Internal Server Error'}), 500
