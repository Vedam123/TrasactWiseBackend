from flask import jsonify, request, Blueprint
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

get_open_inspections_api = Blueprint('get_open_inspections_api', __name__)

@get_open_inspections_api.route('/get_open_inspections', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_open_inspections():
    MODULE_NAME = __name__

    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'get_open_inspections' function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)
        mycursor = mydb.cursor()
        status_param_string = request.args.get('status_param', '')
        status_params_list = [param.strip() for param in status_param_string.split(',')]
        status_param_string1 = ','.join(f"'{item}'" for item in status_params_list)
        inspection_id_param = request.args.get('inspection_id_param', 'NULL')
        inspection_location_id_param = request.args.get('inspection_location_id_param', 'NULL')
        transaction_type_param = request.args.get('transaction_type_param', 'NULL')
        item_name_param = request.args.get('item_name_param', 'NULL')
        transaction_number_param = request.args.get('transaction_number_param', 'NULL')

        query_params = {
            'inspection_id_param': inspection_id_param,
            'inspection_location_id_param': inspection_location_id_param,
            'transaction_type_param': transaction_type_param,
            'item_name_param': item_name_param,
            'transaction_number_param': transaction_number_param,
            'status_params_list': status_param_string1  # Use status_params_list here
        }

        print("Query Parameters:")
        for key, value in query_params.items():
            print(f"{key}: {value}")
        
        query = """
            SELECT * FROM inv.inspection i 
            WHERE (%(transaction_type_param)s IS NULL OR i.transaction_type = %(transaction_type_param)s)      
        """
        if status_param_string:
            query += f" AND i.status IN (%(status_params_list)s)"

        print("\nFull Query:")
        print(query)

        actual_query = query % query_params
        print("Actual query with values -->", actual_query)
        mycursor.execute(actual_query)  

        result = mycursor.fetchall()
        inspections_list = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        for row in result:
            inspection_dict = {}

            for column in columns:
                inspection_dict[column] = row[column_indices[column]]

            inspections_list.append(inspection_dict)

        mycursor.close()
        mydb.close()

        print("\nResult:")
        print(inspections_list)

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Successfully retrieved inspections data")

        return jsonify({'inspections_list': inspections_list})

    except Exception as e:
        print("\nError:", str(e))
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error retrieving inspections data - {str(e)}")
        return jsonify({'error': 'Internal Server Error'}), 500
