from datetime import datetime
from modules.finance.routines.create_journal_header_logic import create_journal_header_logic
from modules.finance.routines.create_journal_line_logic import create_journal_line_logic
from modules.finance.routines.update_sales_invoice_status import update_sales_invoice_status
from modules.finance.routines.update_purchase_invoice_status import update_purchase_invoice_status
from modules.finance.routines.auto_journal_support_functions import (
    create_journal_header_logic,
    create_journal_line_logic,
    update_purchase_invoice_status,
    update_sales_invoice_status
)

from modules.utilities.logger import logger

def auto_create_journal_logic(data, mydb, module_name, appuser,appuserid):
    #appuser = context['appuser']
    #module_name = context['module_name']
    #appuserid = context['appuserid']

    logger.debug(f"{appuser} --> {module_name}: Entered in the auto_create_journal_logic function with the data : {data}")

    cursor = mydb.cursor(dictionary=True)

    journal_category = data.get("journal_category")
    journal_type = data.get("journal_type")
    description = data.get("description")
    journal_status = data.get("journal_status")
    invoice_status = data.get("invoice_status")
    invoice_target_status = data.get("invoice_target_status")
    invoices = data.get("invoices", [])

    logger.debug(f"{appuser} --> {module_name}: Before Journal Category check : {invoice_status}")

    logger.debug(f"{appuser} --> {module_name}: What is the Journal category received : {journal_category}")

    if journal_category == "Sales":
        invoice_account_table = "fin.salesinvoiceaccounts"
        base_query = "SELECT * FROM fin.salesinvoice WHERE status = %s"
    elif journal_category == "Purchase":
        invoice_account_table = "fin.purchaseinvoiceaccounts"
        base_query = "SELECT * FROM fin.purchaseinvoice WHERE status = %s"
    else:
        return [{"error": "Invalid Journal_category"}]

    logger.debug(f"{appuser} --> {module_name}: Input invoices list : {invoices}")
    logger.debug(f"{appuser} --> {module_name}: Journal Category : {journal_category}")
    if invoices:
        logger.debug(f"{appuser} --> {module_name}: invoices NOT EMPTY : {invoices}")
        placeholders = ', '.join(['%s'] * len(invoices))
        query = f"{base_query} AND invoice_number IN ({placeholders})"
        cursor.execute(query, [invoice_status] + invoices)
    else:
        logger.debug(f"{appuser} --> {module_name}: invoices ARE EMPTY : {invoices}")
        query = base_query
        cursor.execute(query, (invoice_status,))

    logger.debug(f"{appuser} --> {module_name}: Query Formed : {query}, Invoice status {invoice_status}")

    invoices = cursor.fetchall()
    logger.debug(f"{appuser} --> {module_name}: Before For loop invoices : {invoices}")

    responses = []
    for invoice in invoices:
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
            "status": journal_status
        }

        logger.debug(f"{appuser} --> {module_name}: Journal Header Data: {header_data}")

        header_response, status_code = create_journal_header_logic(header_data, mydb, module_name, appuser,appuserid)
        if status_code != 200:
            logger.debug(f"{appuser} --> {module_name}: Create Journal Header function response: {header_response}")
            responses.append({"header_response": header_response, "line_response": None})
            continue

        journal_header_id = header_response['header_id']
        cursor.execute(f"""
            SELECT * FROM {invoice_account_table}
            WHERE header_id = %s
        """, (invoice["header_id"],))
        account_lines = cursor.fetchall()

        line_data = []
        for account in account_lines:
            line_number = get_next_sequence_value("JOURNAL_LINE_NUMBER", mydb)
            line_data.append({
                "line_number": line_number,
                "header_id": journal_header_id,
                "account_id": account["account_id"],
                "debit": account["debitamount"],
                "credit": account["creditamount"],
                "status": journal_status
            })

        logger.info(f"{appuser} --> {module_name}: Before calling line ")
        line_response, line_status_code = create_journal_line_logic(line_data, mydb, module_name, appuser,appuserid)

        if not line_response["success"]:
            return [{"error": "Failed to create journal lines"}]

        logger.info(f"{appuser} --> {module_name}: After return from lines and now line response is {line_response}")

        responses.append({
            "header_response": header_response,
            "line_response": line_response
        })
        logger.info(f"{appuser} --> {module_name}: Before updating invoices {journal_category}")

        if journal_category == "Sales":
            update_response, update_status = update_sales_invoice_status(invoice["header_id"], invoice_target_status, mydb, module_name, appuser,appuserid)
        elif journal_category == "Purchase":
            update_response, update_status = update_purchase_invoice_status(invoice["header_id"], invoice_target_status, mydb, module_name, appuser,appuserid)

        if update_status != 200:
            logger.debug(f"{appuser} --> {module_name}: Update invoice status function response: {update_response}")

    cursor.close()

    logger.debug(f"{appuser} --> {module_name}: After for loop before returning from the function : {responses}")
    logger.info(f"{appuser} --> {module_name}: Before return from Main function {responses}")
    return responses

def get_next_sequence_value(sequence_name, mydb):
    cursor = mydb.cursor(dictionary=True)
    cursor.execute('SET @next_val = 0;')
    cursor.execute(f'CALL adm.get_next_sequence_value("{sequence_name}", @next_val);')
    cursor.execute('SELECT @next_val;')
    result = cursor.fetchone()
    cursor.close()
    logger.debug(f"Sequence result: {result}")
    if result is None or result['@next_val'] is None:
        raise Exception("Failed to retrieve next sequence value.")
    return int(result['@next_val'])
