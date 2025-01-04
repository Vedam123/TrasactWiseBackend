from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger

create_invrow_api = Blueprint('create_invrow_api', __name__)

@create_invrow_api.route('/create_invrow', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_invrow():
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
        logger.debug(f"{appuser} --> {__name__}: Entered in the create invrow function")

        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        # Log the received data
        logger.debug(f"{appuser} --> {__name__}: Received data: {data}")

        # Handle capacity (if provided) and uom_id
        capacity = data.get('capacity')
        if capacity == '':  # Handle empty capacity
            capacity = None
        
        # Handle uom_id: only set it if capacity is provided
        uom_id = None
        if capacity is not None:
            uom_id = data.get('uom_id', None)

        aisle_id = data['aisle_id']
        row_name = data['row_name']
        description = data.get('description')
        created_by = appuserid
        updated_by = appuserid

        # Log parsed data
        logger.debug(f"{appuser} --> {__name__}: Parsed Aisle ID: {aisle_id}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Row Name: {row_name}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Description: {description}")
        logger.debug(f"{appuser} --> {__name__}: Parsed Capacity: {capacity}")
        logger.debug(f"{appuser} --> {__name__}: Parsed UOM ID: {uom_id}")

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
                INSERT INTO inv.invrows (aisle_id, row_name, description, capacity, uom_id, created_by, updated_by)
                VALUES (%s, %s, %s, %s, %s, %s, %s)
            """
            values = (aisle_id, row_name, description, capacity, uom_id, created_by, updated_by)

            mycursor.execute(query, values)
            mydb.commit()

            # Log success and close the cursor and connection
            logger.info(f"{appuser} --> {__name__}: Invrow data created successfully")
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Invrow data created successfully'}), 200

        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{appuser} --> {__name__}: Unable to create invrow data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500
    except Exception as e:
        # Log any exceptions
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
