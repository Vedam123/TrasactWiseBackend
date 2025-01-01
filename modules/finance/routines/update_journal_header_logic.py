from modules.utilities.logger import logger

def update_journal_header_logic(data, mydb, module_name, appuser,appuserid):

    try:
        logger.debug(f"{appuser} --> {module_name}: Received data: {data}")

        # Ensure journal_number is present
        journal_number = data.get('journal_number')
        if not journal_number:
            return {'error': 'journal_number is required'}, 400

        # Retrieve header_id for the given journal_number
        select_query = "SELECT header_id FROM fin.journal_headers WHERE journal_number = %s"
        mycursor = mydb.cursor()
        mycursor.execute(select_query, (journal_number,))
        header_id_row = mycursor.fetchone()
        
        if not header_id_row:
            return {'error': 'No journal header found with the given journal number'}, 404

        header_id = header_id_row[0]

        # Start building the update query
        update_query = "UPDATE fin.journal_headers SET "
        update_fields = []
        update_values = []

        # Add fields to update if they are present in the data
        optional_fields = [
            'company_id', 'department_id', 'journal_date', 'journal_type', 
            'source_number', 'description', 'currency_id', 'status'
        ]
        for field in optional_fields:
            if field in data:
                update_fields.append(f"{field} = %s")
                update_values.append(data[field])

        # Add the updated_by field
        update_fields.append("updated_by = %s")
        update_values.append(appuserid)

        # Complete the update query
        update_query += ", ".join(update_fields)
        update_query += " WHERE journal_number = %s"
        update_values.append(journal_number)

        logger.debug(f"{appuser} --> {module_name}: Update query: {update_query}")
        logger.debug(f"{appuser} --> {module_name}: Update values: {update_values}")

        try:
            mycursor.execute(update_query, update_values)
            mydb.commit()
            rows_affected = mycursor.rowcount

            logger.info(f"{appuser} --> {module_name}: Journal header data updated successfully")
            
            if rows_affected == 0:
                return {'error': 'No changes were made to the journal header.'}, 404

            response = {
                'success': True,
                'message': 'Journal Header updated successfully',
                'header_id': header_id,
                'journal_number': journal_number,
                'status': data.get('status')
            }
            return response, 200

        except Exception as e:
            logger.error(f"{appuser} --> {module_name}: Unable to update journal header data: {str(e)}")
            return {'error': str(e)}, 500

    except Exception as e:
        logger.error(f"{appuser} --> {module_name}: An error occurred: {str(e)}")
        return {'error': str(e)}, 500
    finally:
        mycursor.close()
