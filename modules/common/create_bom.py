from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from modules.security.routines.get_user_and_db_details import get_user_and_db_details	
from modules.utilities.logger import logger

bom_api = Blueprint('bom_api', __name__)

@bom_api.route('/create_bom', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_bom():
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

        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            return jsonify({'error': 'Invalid content type. Expected application/json'}), 400

        # Log the received data
        logger.debug(f"{appuser} --> {__name__}: Received data: {data}")

        bom_data = data.get('bom', [])

        if not bom_data:
            return jsonify({'error': 'No BOM data provided'}), 400

        mycursor = mydb.cursor()

        try:
            # Loop through each BOM entry and insert into the com.bom table
            query = """
                INSERT INTO com.bom
                (ModelItem, ParentItem, ComponentItem, Quantity, uom, Revision, EffectiveDate, EndDate, NotesComments, Level, created_by, updated_by)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """
            for entry in bom_data:
                ModelItem = entry.get('ModelItem')
                ParentItem = entry.get('ParentItem')
                ComponentItem = entry.get('ComponentItem')
                Quantity = entry.get('Quantity')
                uom = entry.get('uom')
                Revision = entry.get('Revision')
                EffectiveDate = entry.get('EffectiveDate')
                EndDate = entry.get('EndDate')
                NotesComments = entry.get('NotesComments')
                Level = entry.get('Level')

                # Validate required fields
                if not all([ModelItem, ParentItem, ComponentItem, Quantity, uom, Revision, EffectiveDate, Level]):
                    return jsonify({'error': 'Missing required fields in BOM entry'}), 400

                # Prepare values for insertion
                values = (
                    ModelItem, ParentItem, ComponentItem, Quantity, uom, Revision, 
                    EffectiveDate, EndDate, NotesComments, Level, appuserid, appuserid
                )

                mycursor.execute(query, values)

            mydb.commit()

            # Log success and close the cursor and connection
            logger.info(f"{appuser} --> {__name__}: BOM data created successfully")
            mycursor.close()
            mydb.close()

            return jsonify({'message': 'BOM data created successfully'})
        except Exception as e:
            # Log the error and close the cursor and connection
            logger.error(f"{appuser} --> {__name__}: Unable to create BOM data: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500
    except Exception as e:
        # Log any exceptions
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
