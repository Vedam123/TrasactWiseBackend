from flask import jsonify, request, Blueprint
from modules.security.permission_required import permission_required
from modules.admin.databases.mydb import get_database_connection
from config import UPDATE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

update_employee_data_api = Blueprint('update_employee_data_api', __name__)

@update_employee_data_api.route('/update_employee_data', methods=['PUT'])
@permission_required(UPDATE_ACCESS_TYPE, __file__)
def update_employee_data():
    MODULE_NAME = __name__

    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'update employee' function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)
        mycursor = mydb.cursor()

        current_userid = None
        authorization_header = request.headers.get('Authorization', '')
        if authorization_header.startswith('Bearer '):
            token = authorization_header.replace('Bearer ', '')
            decoded_token = decode_token(token)
            current_userid = decoded_token.get('Userid')

        # Assuming you receive the updated data as JSON in the request body
        data = request.get_json()

        # Extract the empid from the request data
        empid = data.get('empid')

        # Check if empid is provided
        if empid is None:
            logger.error(f"{USER_ID} --> {MODULE_NAME}: Missing empid in the request")
            return jsonify({'error': 'Missing empid in the request'}), 400

        # Construct the update query for the employee table
        update_query = "UPDATE com.employee SET "
        values = []

        for key, value in data.items():
            if key != 'empid':  # Exclude empid from the update
                update_query += f"{key} = %s, "
                values.append(value)

        # Remove the trailing comma and space
        update_query = update_query.rstrip(', ')

        # Add the WHERE clause
        update_query += " WHERE empid = %s"
        values.append(empid)

        mycursor.execute(update_query, values)

        # Check if the update query is executed successfully
        if mycursor.rowcount > 0:
            mydb.commit()
            logger.info(
                f"{USER_ID} --> {MODULE_NAME}: Successfully updated employee data. "
                f"empid: {empid}, "
                f"Updated values: {', '.join(f'{key}={value}' for key, value in zip(data.keys(), values[:-1]))}, "
                f"Request variables: {data}"
            )
            return jsonify({'message': 'Employee data updated successfully'})
        else:
            logger.warning(
                f"{USER_ID} --> {MODULE_NAME}: No rows were affected. Employee data might not have been updated. "
                f"Request variables: {data}"
            )
            return jsonify({'message': 'No rows were affected. Employee data might not have been updated.'}), 200

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error updating employee data - {str(e)}, Request variables: {data}")
        return jsonify({'error': 'Internal Server Error'}), 500
    finally:
        mycursor.close()
        mydb.close()
