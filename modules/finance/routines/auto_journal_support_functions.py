from modules.utilities.logger import logger

def create_journal_header_logic(data, mydb, module_name, appuser,appuserid):
    try:
        logger.debug(f"{appuser} --> {module_name}: Received data: {data}")

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
            appuserid,
            appuserid
        )

        cursor = mydb.cursor()
        cursor.execute(insert_query, insert_values)
        mydb.commit()

        header_id = cursor.lastrowid
        response = {
            "header_id": header_id,
            "journal_number": data.get('journal_number')
        }

        cursor.close()
        return response, 200

    except Exception as e:
        logger.error(f"{appuser} --> {module_name}: Error in create_journal_header_logic: {str(e)}")
        return {"error": str(e)}, 500

def create_journal_line_logic(lines, mydb, module_name, appuser,appuserid):
    try:
        cursor = mydb.cursor()

        insert_query = """
            INSERT INTO fin.journal_lines (line_number, header_id, account_id, debit, credit, status, created_by, updated_by)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
        """

        for line in lines:
            insert_values = (
                line['line_number'],
                line['header_id'],
                line['account_id'],
                line['debit'],
                line['credit'],
                line['status'],
                appuserid,
                appuserid
            )
            cursor.execute(insert_query, insert_values)

        mydb.commit()
        cursor.close()
        return {"success": True}, 200

    except Exception as e:
        logger.error(f"{appuser} --> {module_name}: Error in create_journal_line_logic: {str(e)}")
        return {"success": False, "error": str(e)}, 500

def update_sales_invoice_status(invoice_id, target_status, mydb, module_name, appuser,appuserid):
    try:
        cursor = mydb.cursor()
        update_query = "UPDATE fin.salesinvoice SET status = %s WHERE header_id = %s"
        cursor.execute(update_query, (target_status, invoice_id))
        mydb.commit()
        cursor.close()
        return {"success": True}, 200
    except Exception as e:
        logger.error(f"{appuser} --> {module_name}: Error in update_sales_invoice_status: {str(e)}")
        return {"success": False, "error": str(e)}, 500

def update_purchase_invoice_status(invoice_id, target_status, mydb, module_name, appuser,appuserid):
    try:
        cursor = mydb.cursor()
        update_query = "UPDATE fin.purchaseinvoice SET status = %s WHERE header_id = %s"
        cursor.execute(update_query, (target_status, invoice_id))
        mydb.commit()
        cursor.close()
        return {"success": True}, 200
    except Exception as e:
        logger.error(f"{appuser} --> {module_name}: Error in update_purchase_invoice_status: {str(e)}")
        return {"success": False, "error": str(e)}, 500
