from flask import Blueprint, jsonify, request
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger

bom_api = Blueprint('bom_api', __name__)

@bom_api.route('/update_bom', methods=['PUT'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def update_bom():
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

        logger.debug(f"{appuser} --> {__name__}: Entered upsert BOM function")

        if request.content_type != 'application/json':
            return jsonify({'error': 'Invalid content type. Expected application/json'}), 400

        data = request.get_json()

        # Log the received data
        logger.debug(f"{appuser} --> {__name__}: Received data: {data}")

        bom_data = data.get('bom', [])
        if not bom_data:
            return jsonify({'error': 'No BOM data provided'}), 400

        mycursor = mydb.cursor()

        try:
            insert_query = """
                INSERT INTO com.bom
                (ModelItem, ParentItem, ComponentItem, Quantity, uom, Revision, EffectiveDate, EndDate, NotesComments, Level, ScrapPercentage, RoutingOperation, created_by, updated_by)
                VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
            """

            update_query_base = """
                UPDATE com.bom SET 
            """
            update_query_conditions = " WHERE ID = %s"

            for entry in bom_data:
                bom_id = entry.get('ID')

                if bom_id:
                    # Update existing entry
                    mycursor.execute("SELECT * FROM com.bom WHERE ID = %s", (bom_id,))
                    existing_bom = mycursor.fetchone()

                    if not existing_bom:
                        return jsonify({'error': f'BOM entry with ID {bom_id} not found'}), 404

                    # Dynamically build the update query based on the provided fields
                    update_fields = []
                    update_values = []

                    if 'ModelItem' in entry:
                        update_fields.append("ModelItem = %s")
                        update_values.append(entry['ModelItem'])
                    if 'ParentItem' in entry:
                        update_fields.append("ParentItem = %s")
                        update_values.append(entry['ParentItem'])
                    if 'ComponentItem' in entry:
                        update_fields.append("ComponentItem = %s")
                        update_values.append(entry['ComponentItem'])
                    if 'Quantity' in entry:
                        update_fields.append("Quantity = %s")
                        update_values.append(entry['Quantity'])
                    if 'uom' in entry:
                        update_fields.append("uom = %s")
                        update_values.append(entry['uom'])
                    if 'Revision' in entry:
                        update_fields.append("Revision = %s")
                        update_values.append(entry['Revision'])
                    if 'EffectiveDate' in entry:
                        update_fields.append("EffectiveDate = %s")
                        update_values.append(entry['EffectiveDate'])
                    if 'EndDate' in entry:
                        update_fields.append("EndDate = %s")
                        update_values.append(entry['EndDate'])
                    if 'NotesComments' in entry:
                        update_fields.append("NotesComments = %s")
                        update_values.append(entry['NotesComments'])
                    if 'Level' in entry:
                        update_fields.append("Level = %s")
                        update_values.append(entry['Level'])
                    if 'ScrapPercentage' in entry:
                        update_fields.append("ScrapPercentage = %s")
                        update_values.append(entry['ScrapPercentage'])
                    if 'RoutingOperation' in entry:
                        update_fields.append("RoutingOperation = %s")
                        update_values.append(entry['RoutingOperation'])

                    # Add the updated_by field
                    update_fields.append("updated_by = %s")
                    update_values.append(appuserid)

                    # Add bom_id to the values list
                    update_values.append(bom_id)

                    update_query = update_query_base + ", ".join(update_fields) + update_query_conditions
                    mycursor.execute(update_query, update_values)

                else:
                    # Insert new entry
                    insert_values = (
                        entry.get('ModelItem'), entry.get('ParentItem'), entry.get('ComponentItem'),
                        entry.get('Quantity'), entry.get('uom'), entry.get('Revision'),
                        entry.get('EffectiveDate'), entry.get('EndDate'), entry.get('NotesComments'),
                        entry.get('Level'), entry.get('ScrapPercentage'), entry.get('RoutingOperation'),
                        appuserid, appuserid
                    )

                    # Validate required fields for insert
                    if not all([entry.get('ModelItem'), entry.get('ParentItem'), entry.get('ComponentItem'),
                                entry.get('Quantity'), entry.get('uom'), entry.get('Revision'),
                                entry.get('EffectiveDate'), entry.get('Level')]):
                        return jsonify({'error': 'Missing required fields in BOM entry for insert'}), 400

                    mycursor.execute(insert_query, insert_values)

            mydb.commit()

            logger.info(f"{appuser} --> {__name__}: BOM entries upserted successfully")
            mycursor.close()
            mydb.close()

            return jsonify({'message': 'BOM entries upserted successfully'})
        except Exception as e:
            logger.error(f"{appuser} --> {__name__}: Unable to upsert BOM entries: {str(e)}")
            mycursor.close()
            mydb.close()
            return jsonify({'error': str(e)}), 500
    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)}")
        return jsonify({'error': str(e)}), 500
