from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.utilities.logger import logger

department_api = Blueprint('department_api', __name__)

@department_api.route('/get_departments', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_departments():

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

        logger.debug(f"{appuser} --> {__name__}: Entered the 'get departments' function")

        mycursor = mydb.cursor()

        id_param = request.args.get('id')
        department_name_param = request.args.get('department_name')
        company_id_param = request.args.get('company_id')

        query_params = {
            'id_param': id_param,
            'department_name_param': department_name_param,
            'company_id_param': company_id_param
        }

        query = """
            SELECT d.id, d.company_id, d.department_name, d.manager_id, d.description,
                   d.created_at, d.updated_at, d.created_by, d.updated_by,
                   c.name AS company_name, c.description AS company_description,
                   e.name AS manager_name,
                   dah.header_name AS default_account_header_name
            FROM com.department d
            JOIN com.company c ON d.company_id = c.id
            LEFT JOIN com.employee e ON d.manager_id = e.empid
            LEFT JOIN fin.default_account_headers dah ON d.default_account_header_id = dah.header_id
            WHERE (%(id_param)s IS NULL OR d.id = %(id_param)s)
              AND (%(department_name_param)s IS NULL OR d.department_name REGEXP %(department_name_param)s)
              AND (%(company_id_param)s IS NULL OR d.company_id = %(company_id_param)s)
        """

        mycursor.execute(query, query_params)

        result = mycursor.fetchall()
        department_list = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        for row in result:
            department_dict = {}

            for column in columns:
                department_dict[column] = row[column_indices[column]]

            department_list.append(department_dict)

        mycursor.close()
        mydb.close()

        logger.debug(f"{appuser} --> {__name__}: Successfully retrieved department data")

        return jsonify({'department_list': department_list})

    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Error retrieving department data - {str(e)}")
        return jsonify({'error': 'Internal Server Error'}), 500
