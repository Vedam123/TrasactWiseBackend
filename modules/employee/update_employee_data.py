from flask import jsonify, request, Blueprint
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import UPDATE_ACCESS_TYPE
from modules.utilities.logger import logger

update_employee_data_api = Blueprint('update_employee_data_api', __name__)

@update_employee_data_api.route('/update_employee_data', methods=['PUT'])
@permission_required(UPDATE_ACCESS_TYPE, __file__)
def update_employee_data():
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
        logger.debug(f"{appuser} --> {__name__}: Entered the 'update employee' function")

        mycursor = mydb.cursor()

         # Assuming you receive the updated data as JSON in the request body
        data = request.get_json()

        # Extract the empid from the request data
        empid = data.get('empid')

        # Check if empid is provided
        if empid is None:
            logger.error(f"{appuser} --> {__name__}: Missing empid in the request")
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
                f"{appuser} --> {__name__}: Successfully updated employee data. "
                f"empid: {empid}, "
                f"Updated values: {', '.join(f'{key}={value}' for key, value in zip(data.keys(), values[:-1]))}, "
                f"Request variables: {data} "
            )
            return jsonify({'message': 'Employee data updated successfully'})
        else:
            logger.warning(
                f"{appuser} --> {__name__}: No rows were affected. Employee data might not have been updated. "
                f"Request variables: {data}"
            )
            return jsonify({'message': 'No rows were affected. Employee data might not have been updated.'}), 200

    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Error updating employee data - {str(e)}, Request variables: {data}")
        return jsonify({'error': 'Internal Server Error'}), 500
    finally:
        mycursor.close()
        mydb.close()
