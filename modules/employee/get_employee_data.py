from flask import Blueprint, jsonify, request
import base64
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from datetime import date, datetime
from modules.utilities.logger import logger  # Import the logger module

get_employee_data_api = Blueprint('get_employee_data_api', __name__)

@get_employee_data_api.route('/employee', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_employee_data():
    try:
        authorization_header = request.headers.get('Authorization')
        logger.debug(f"{authorization_header} --> {__name__}: Received Authorization header: {authorization_header}")
        
        try:
            company, instance, dbuser, mydb, appuser, appuserid, user_info, employee_info = get_user_and_db_details(authorization_header)
            logger.debug(f"{appuser} --> {__name__}: User details retrieved successfully")
        except ValueError as e:
            logger.error(f"{appuser} --> {__name__}: Authorization failed for {appuser} --> {__name__}: {str(e)}")
            return jsonify({"error": str(e)}), 401
            
        if not appuser:
            logger.error(f"{appuser} --> {__name__}: Unauthorized access attempt with missing appuser --> {__name__}: Username not found in the request")
            return jsonify({"error": "Unauthorized. Username not found."}), 401  

        logger.debug(f"{appuser} --> {__name__}: Entered the get_employee_data function, attempting to retrieve employee data")

        mycursor = mydb.cursor()
        empid_param = request.args.get('empid')
        status_param = request.args.get('status')
        logger.debug(f"{appuser} --> {__name__}: Received empid: {empid_param}, status: {status_param}")

        # Validate empid_param to ensure it is a valid integer
        if empid_param and not empid_param.isdigit():
            logger.warning(f"{appuser} --> {__name__}: Invalid empid parameter received: {empid_param}")
            return jsonify({'error': 'Invalid empid parameter'}), 400

        # Construct the base query
        query = """
            SELECT e.*, m.name AS manager_name, s.name AS supervisor_name, d.designation_name
            FROM com.employee e
            LEFT JOIN com.employee m ON e.manager_id = m.empid
            LEFT JOIN com.employee s ON e.supervisor_id = s.empid
            LEFT JOIN com.designations d ON e.designation_id = d.designation_id
        """
        conditions = []

        # Add filters for empid and status if provided
        if empid_param:
            conditions.append(f"e.empid = {empid_param}")
        if status_param:
            conditions.append(f"e.status = '{status_param}'")

        # If there are any conditions, append them to the query
        if conditions:
            query += " WHERE " + " AND ".join(conditions)

        logger.debug(f"{appuser} --> {__name__}: Constructed query: {query}")

        mycursor.execute(query)
        result = mycursor.fetchall()
        logger.debug(f"{appuser} --> {__name__}: Retrieved {len(result)} records from the database")

        employees = []
        column_names = [desc[0] for desc in mycursor.description]
        logger.debug(f"{appuser} --> {__name__}: Column names fetched: {column_names}")

        for row in result:
            employee_dict = {}
            for i, value in enumerate(row):
                column_name = column_names[i]
                if column_name == 'pic' and isinstance(value, bytes):
                    value = base64.b64encode(value).decode('utf-8')
                    logger.debug(f"{appuser} --> {__name__}: Employee '{appuser}' picture field encoded")
                if isinstance(value, (date, datetime)):
                    value = str(value)
                employee_dict[column_name] = value

            employees.append(employee_dict)

        # Close the cursor and connection
        mycursor.close()
        mydb.close()
        logger.debug(f"{appuser} --> {__name__}: Database connection closed successfully")

        return jsonify(employees)

    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
