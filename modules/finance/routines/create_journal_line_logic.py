from modules.utilities.logger import logger

def create_journal_line_logic(data, mydb, module_name, appuser,appuserid):

    try:
        if not isinstance(data, list):
            return {'error': 'Invalid JSON input. Expected a list of journal lines.'}, 400

        insert_query = """
            INSERT INTO fin.journal_lines (line_number, header_id, account_id, debit, credit, status, created_by, updated_by)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        """

        mycursor = mydb.cursor()
        response_lines = []

        for line_data in data:
            insert_values = (
                line_data.get('line_number'),
                line_data.get('header_id'),
                line_data.get('account_id'),
                line_data.get('debit', 0.0),
                line_data.get('credit', 0.0),
                line_data.get('status'),
                appuserid,  # created_by
                appuserid   # updated_by
            )

            mycursor.execute(insert_query, insert_values)
            mydb.commit()

            response_lines.append({
                'line_id': mycursor.lastrowid,
                'header_id': line_data.get('header_id')
            })

        logger.info(f"{appuser} --> {module_name}: Journal line data created successfully")
        mycursor.close()
        logger.info(f"{appuser} --> {module_name}: Before Return from Journal lines response_lines  {response_lines}")
        return {'success': True, 'message': 'Journal Lines successfully created', 'journal_lines': response_lines}, 201

    except Exception as e:
        logger.error(f"{appuser} --> {module_name}: Unable to create journal line data: {str(e)}")
        if mycursor:
            mycursor.close()
        return {'error': str(e)}, 500
