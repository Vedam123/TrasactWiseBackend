from modules.utilities.logger import logger

def update_journal_line_logic(data, mydb, module_name, appuser,appuserid):

    try:
        if not isinstance(data, list):
            return {'error': 'Invalid JSON input. Expected a list of journal lines.'}, 400

        mycursor = mydb.cursor()
        response_lines = []

        for line_data in data:
            header_id = line_data.get('header_id')
            line_id = line_data.get('line_id')
            if not header_id or not line_id:
                return {'error': 'header_id and line_id are required'}, 400

            # Start building the update query
            update_query = "UPDATE fin.journal_lines SET "
            update_fields = []
            update_values = []

            # Add fields to update if they are present in the data
            optional_fields = ['account_id', 'debit', 'credit', 'status']
            for field in optional_fields:
                if field in line_data:
                    update_fields.append(f"{field} = %s")
                    update_values.append(line_data[field])

            # Add the updated_by field
            update_fields.append("updated_by = %s")
            update_values.append(appuserid)

            # Complete the update query
            update_query += ", ".join(update_fields)
            update_query += " WHERE header_id = %s AND line_id = %s"
            update_values.extend([header_id, line_id])

            logger.debug(f"{appuser} --> {module_name}: Update query: {update_query}")
            logger.debug(f"{appuser} --> {module_name}: Update values: {update_values}")

            try:
                mycursor.execute(update_query, update_values)
                mydb.commit()
                rows_affected = mycursor.rowcount

                if rows_affected == 0:
                    logger.debug(f"{appuser} --> {module_name}: No rows were updated for header_id {header_id} and line_id {line_id}. This might be due to identical values.")
                    # This can be a non-error case, so we do not return an error response here
                    response_lines.append({
                        'header_id': header_id,
                        'line_id': line_id,
                        'message': 'No changes made to the row, identical values'
                    })
                else:
                    response_lines.append({
                        'header_id': header_id,
                        'line_id': line_id,
                        'message': 'Row updated successfully'
                    })

            except Exception as e:
                logger.error(f"{appuser} --> {module_name}: Unable to update journal line data: {str(e)}")
                return {'error': str(e)}, 500

        logger.info(f"{appuser} --> {module_name}: Journal line data update process is completed")
        mycursor.close()
        return {'success': True, 'message': 'Journal Lines successfully updated', 'journal_lines': response_lines}, 200

    except Exception as e:
        logger.error(f"{appuser} --> {module_name}: An error occurred: {str(e)}")
        if mycursor:
            mycursor.close()
        return {'error': str(e)}, 500
