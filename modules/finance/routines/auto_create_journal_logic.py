from datetime import datetime
from modules.finance.routines.create_journal_header_logic import create_journal_header_logic
from modules.finance.routines.create_journal_line_logic import create_journal_line_logic
from modules.admin.databases.mydb import get_database_connection
from modules.utilities.logger import logger

def auto_create_journal_logic(data, context):
    
    USER_ID = context['USER_ID']
    MODULE_NAME = context['MODULE_NAME']
    current_userid = context['current_userid']
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Enterd in the auto_create_journal_logic function : {data}")

    mydb = get_database_connection(USER_ID, MODULE_NAME)  # Es     
    cursor = mydb.cursor(dictionary=True)

    mydb_context = {
        'USER_ID': USER_ID,
        'MODULE_NAME': MODULE_NAME,
        'current_userid': current_userid,
        'mydb': mydb
        }

    mydb1 = get_database_connection(USER_ID, MODULE_NAME)  # Es     
    cursor1 = mydb1.cursor(dictionary=True)

    mydb1_context = {
        'USER_ID': USER_ID,
        'MODULE_NAME': MODULE_NAME,
        'current_userid': current_userid,
        'mydb': mydb1
        }

    journal_category = data["Journal_category"]
    journal_type = data["journal_type"]
    description = data["description"]
    status = data["status"]
    invoice_status = data["invoice_status"]

    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Before Journal Category check  : {invoice_status}")

    if journal_category == "Sales":
        cursor.execute("""
            SELECT * FROM fin.salesinvoice
            WHERE status = %s
        """, (invoice_status,))
        invoices = cursor.fetchall()
        invoice_account_table = "fin.salesinvoiceaccounts"
    elif journal_category == "Purchase":
        cursor.execute("""
            SELECT * FROM fin.purchaseinvoice
            WHERE status = %s
        """, (invoice_status,))
        invoices = cursor.fetchall()
        invoice_account_table = "fin.purchaseinvoiceaccounts"
    else:
        return [{"error": "Invalid Journal_category"}]
    
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Before For loop invoices  : {invoices}")

    responses = []
    for invoice in invoices:
        # Prepare data for create_journal_header function
        journal_number = get_next_sequence_value("JOURNAL_HDR_NUMBER", mydb)
        header_data = {
            "journal_number": journal_number,
            "company_id": invoice["company_id"],
            "department_id": invoice["department_id"],
            "journal_date": datetime.now().strftime('%Y-%m-%d'),
            "journal_type": journal_type,
            "source_number": invoice["header_id"],
            "description": description,
            "currency_id": invoice["currency_id"],
            "status": status
        }

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Journal Header Data: {header_data}")

        # Call create_journal_header function
        header_response, status_code = create_journal_header_logic(header_data, mydb_context)

        if status_code != 200:
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: Create Journal Header function response: {header_response}")
            responses.append({"header_response": header_response, "line_response": None})
            if mydb :
                    mydb.close()
            continue

        journal_header_id = header_response['header_id']

        # Fetch corresponding invoice account lines
        cursor1.execute(f"""
            SELECT * FROM {invoice_account_table}
            WHERE header_id = %s
        """, (invoice["header_id"],))
        account_lines = cursor1.fetchall()

        # Prepare data for create_journal_line function
        line_data = []
        for account in account_lines:
            line_number = get_next_sequence_value("JOURNAL_LINE_NUMBER", mydb1)
            line_data.append({
                "line_number": line_number,
                "header_id": journal_header_id,
                "account_id": account["account_id"],
                "debit": account["debitamount"],
                "credit": account["creditamount"],
                "status": status
            })

        # Call create_journal_line function
        logger.info(f"{USER_ID} --> {MODULE_NAME}: Before calling line ")
        line_response, line_status_code = create_journal_line_logic(line_data, mydb1_context)

        if not line_response["success"]:
            return [{"error": "Failed to create journal lines"}]
        
        logger.info(f"{USER_ID} --> {MODULE_NAME}: After retunr from lines and now line response is   {line_response}")

        responses.append({
            "header_response": header_response,
            "line_response": line_response
        })
        logger.info(f"{USER_ID} --> {MODULE_NAME}: Before closing mydb is if condtion check   {line_response}")
    if mydb :
        mydb.close()
    if mydb1 :
        mydb1.close()
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: After for loop before returning from the function  : {responses}")
    logger.info(f"{USER_ID} --> {MODULE_NAME}: Before return from Main function    {responses}")
    return responses

def get_next_sequence_value(sequence_name, mydb):
    cursor = mydb.cursor(dictionary=True)
    cursor.execute('SET @next_val = 0;')  # Initialize the variable
    cursor.execute(f'CALL adm.get_next_sequence_value("{sequence_name}", @next_val);')
    cursor.execute('SELECT @next_val;')
    result = cursor.fetchone()
    cursor.close()
    logger.debug(f"Sequence result: {result}")
    if result is None or result['@next_val'] is None:
        raise Exception("Failed to retrieve next sequence value.")
    return int(result['@next_val'])
