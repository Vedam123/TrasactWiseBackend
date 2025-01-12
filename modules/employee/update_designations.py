import json
from flask import Blueprint, jsonify, request
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger

update_designations_data_api = Blueprint('update_designation_data_api', __name__)

@update_designations_data_api.route('/update_designations', methods=['PUT'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def update_designations():
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

        # Log input parameters
        logger.debug(f"{appuser} --> {__name__}: Entered the 'update designations' function")
        mycursor = mydb.cursor()

        # Extract data from JSON input
        try:
            json_data = request.get_json()
            if not json_data:
                return jsonify({'error': 'No JSON data provided'}), 400

            # Extracting fields from JSON input
            fields_to_update = {}
            if 'designation_name' in json_data:
                fields_to_update['designation_name'] = json_data['designation_name']
            if 'description' in json_data:
                fields_to_update['description'] = json_data['description']
            if 'salary_range' in json_data:
                fields_to_update['salary_range'] = json_data['salary_range']
            if 'responsibilities' in json_data:
                fields_to_update['responsibilities'] = json_data['responsibilities']
            if 'qualifications' in json_data:
                fields_to_update['qualifications'] = json_data['qualifications']
            
            # Log JSON input
            logger.info(f"{appuser} --> {__name__}: JSON Input Parameters - {fields_to_update}")

            # Extract query parameters
            designation_id = request.args.get('designation_id')
            if not designation_id:
                return jsonify({'error': "'designation_id' must be provided in query parameters."}), 400
            
            # Log query parameters
            logger.info(f"{appuser} --> {__name__}: Query Parameters - designation_id: {designation_id}")

            # Build WHERE clause based on provided parameters
            where_clause = "designation_id = %s"
            where_query_values = [int(designation_id)]

            # Select query to check if the record exists
            select_query = f"""
                SELECT COUNT(*) FROM com.designations WHERE {where_clause};
            """
            mycursor.execute(select_query, where_query_values)
            record_count = mycursor.fetchone()[0]
            if record_count == 0:
                logger.warning(f"{appuser} --> {__name__}: No designation found with the provided ID {designation_id}")
                return jsonify({'error': 'No designation found with the provided ID'}), 404

            # Build the SET clause and values dynamically
            set_clause = ", ".join([f"{key} = %s" for key in fields_to_update.keys()])
            update_query_values = list(fields_to_update.values())

            # Include updated_by and its value
            set_clause += ", updated_by = %s"
            update_query_values.append(appuserid)

            # Perform the update query
            update_query = f"""
                UPDATE com.designations
                SET {set_clause}
                WHERE {where_clause};
            """
            update_query_values.extend(where_query_values)

            mycursor.execute(update_query, update_query_values)
            logger.info(f"{appuser} --> {__name__}: The Query  : {update_query}")
            logger.info(f"{appuser} --> {__name__}: The Where clause  : {where_clause}")

            # Commit the transaction
            mydb.commit()

            if mycursor.rowcount > 0:
                logger.info(f"{appuser} --> {__name__}: Successfully updated designation ID {designation_id}")
                mycursor.close()
                mydb.close()
                return jsonify({'status': True, 'message': 'Designation updated successfully'}), 200
            else:
                logger.warning(f"{appuser} --> {__name__}: No designation updated for ID {designation_id}")
                mycursor.close()
                mydb.close()
                return jsonify({'status': False, 'message': 'Designation update failed'}), 404

        except Exception as json_error:
            logger.error(f"{appuser} --> {__name__}: Error processing JSON input - {str(json_error)}")
            return jsonify({'error': 'Invalid JSON input'}), 400

    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Error updating designation - {str(e)}")
        mydb.rollback()
        return jsonify({'error': 'Internal Server Error'}), 500

    finally:
        try:
            mycursor.close()
        except NameError:
            pass  # Cursor was not defined
