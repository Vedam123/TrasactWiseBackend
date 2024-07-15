from modules.utilities.logger import logger

def create_journal_header_logic(data, context):
    USER_ID = context['USER_ID']
    MODULE_NAME = context['MODULE_NAME']
    current_userid = context['current_userid']
    mydb = context['mydb']

    try:
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Received data: {data}")

        insert_query = """
            INSERT INTO fin.journal_headers (journal_number, company_id, department_id, journal_date, journal_type, source_number, description, currency_id, status, created_by, updated_by)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """

        insert_values = (
            data.get('journal_number'),
            data.get('company_id'),
            data.get('department_id'),
            data.get('journal_date'),
            data.get('journal_type'),
            data.get('source_number'),
            data.get('description'),
            data.get('currency_id'),
            data.get('status'),
            current_userid,
            current_userid
        )

        mycursor = mydb.cursor()

        try:
            mycursor.execute(insert_query, insert_values)
            mydb.commit()
            header_id = mycursor.lastrowid
            journal_number = data.get('journal_number')
            currency_id = data.get('currency_id')
            status = data.get('status')

            logger.info(f"{USER_ID} --> {MODULE_NAME}: Journal header data created successfully")
            mycursor.close()
            mydb.close()
            
            response = {
                'success': True,
                'message': 'Journal Header created successfully',
                'journal_number': journal_number,
                'header_id': header_id,
                'currency_id': currency_id,
                'status': status
            }
            
            return response, 200

        except Exception as e:
            logger.error(f"{USER_ID} --> {MODULE_NAME}: Unable to create journal header data: {str(e)}")
            mycursor.close()
            mydb.close()
            return {'error': str(e)}, 500

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred: {str(e)}")
        return {'error': str(e)}, 500
