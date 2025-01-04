from flask import jsonify, request, Blueprint
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger

create_bin_api = Blueprint('create_bin_api', __name__)

@create_bin_api.route('/create_bin', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_bin():
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

        # Log entry point
        logger.debug(f"{appuser} --> {__name__}: Entered in the create bin function")

        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        # Log the received data
        logger.debug(f"{appuser} --> {__name__}: Received data: {data}")

        rack_id = data['rack_id']
        bin_name = data['bin_name']
        description = data.get('description')
        
        # Handle capacity (if provided) and convert to float
        capacity = data.get('capacity')
        if capacity == '':  # Handle empty capacity
            capacity = None

        created_by = appuserid
        updated_by = appuserid

        # Log parsed data
        logger.debug(f"{appuser} --> {__name__}: Parsed Rack ID: {rack_id}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Bin Name: {bin_name}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Description: {description}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Capacity: {capacity}")

        # Convert capacity to float (if provided)
        if capacity:
            try:
                capacity = float(capacity)
            except ValueError:
                logger.error(f"{appuser} --> {__name__}: Invalid capacity value: {capacity}")
                return jsonify({"error": "Capacity must be a valid number."}), 400

        mycursor = mydb.cursor()

        try:
            query = """
                INSERT INTO inv.bins (rack_id, bin_name, description, capacity, created_by, updated_by)
                VALUES (%s, %s, %s, %s, %s, %s)
            """
            values = (rack_id, bin_name, description, capacity, created_by, updated_by)

            mycursor.execute(query, values)
            mydb.commit()

            # Log success and close the cursor and connection
            logger.info(f"{appuser} --> {__name__}: Bin data created successfully")
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Bin data created successfully'}), 200

        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{appuser} --> {__name__}: Unable to create bin data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500
    except Exception as e:
        # Log any exceptions
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
