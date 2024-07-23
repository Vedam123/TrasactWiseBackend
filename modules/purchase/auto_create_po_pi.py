from flask import Blueprint, jsonify, request
import uuid
from flask_jwt_extended import decode_token
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger
from config import WRITE_ACCESS_TYPE
from datetime import datetime, timedelta
from modules.purchase.routines.log_auto_purchase_invoice import log_auto_purchase_invoice
from modules.purchase.routines.update_poheader_and_lines_status import update_poheader_and_lines_status
from modules.finance.routines.get_account_details import get_account_details
from decimal import Decimal,ROUND_HALF_UP

# Helper function to create purchase invoice header
def create_purchase_invoice(data, USER_ID, MODULE_NAME, mydb):
    try:
        cursor = mydb.cursor(dictionary=True) 

        insert_query = """
            INSERT INTO fin.purchaseinvoice (invoice_number, partnerid, invoicedate, totalamount, status, 
            payment_terms, payment_duedate, tax_id, currency_id, department_id, company_id, transaction_source, 
            created_by, updated_by)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """

        cursor.execute(insert_query, (
            data["invoice_number"],
            data["partnerid"],
            data["invoicedate"],
            data["totalamount"],
            data["status"],
            data["payment_terms"],
            data["payment_duedate"],
            data["tax_id"],
            data["currency_id"],
            data["department_id"],
            data["company_id"],
            data["transaction_source"],
            data["created_by"],
            data["updated_by"]
        ))

        mydb.commit()
        header_id = cursor.lastrowid
        cursor.close()

        logger.debug("Is the Last row id is a header id newly created in PI {header_id}")
        
        return {
            "header_id": header_id,
            "message": "Purchase Invoice created successfully",
            "success": True,
            "totalamount": data["totalamount"]
        }, 200

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Unable to create purchase invoice header: {str(e)}")
        return {"error": str(e)}, 500

# Helper function to create purchase invoice lines
def create_purchase_invoice_lines(header_id, lines, USER_ID, MODULE_NAME, mydb):
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the create purchase invoice lines function for header id: {header_id}")
    try:
        cursor = mydb.cursor(dictionary=True)
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Try block with cursor: {header_id}")
        insert_query = """
            INSERT INTO fin.purchaseinvoicelines (line_number, header_id, item_id, quantity, unit_price, line_total, uom_id, created_by, updated_by)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: The query : {insert_query}")
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Before forloop : {lines}")
        response_lines = []
        for line in lines:
            cursor.execute('SET @next_val = 0;')
            cursor.execute('CALL adm.get_next_sequence_value("PUR_LINE_NUMBER", @next_val);')
            cursor.execute('SELECT @next_val;')
            result = cursor.fetchone()
            if result is None or result['@next_val'] is None:
                raise Exception("Failed to retrieve next line number.")

            next_val = result['@next_val']
            logger.debug("Line data , {line}")
            cursor.execute(insert_query, (
                next_val,
                header_id,
                line["item_id"],
                line["quantity"],
                line["unit_price"],
                line["line_total"],
                line["uom_id"],
                line['created_by'],
                line['updated_by']
            ))
            mydb.commit()
            line_id = cursor.lastrowid

            response_lines.append({
                "line_id": line_id,
                "line_number": next_val,
                "line_total": line["line_total"]
            })
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: After For loop : {lines}")
        cursor.close()
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Before leaving the function: {response_lines}")

        return {
            "lines": response_lines,
            "message": "Purchase Invoice Lines created successfully",
            "success": True
        }, 200

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Unable to create purchase invoice lines: {str(e)}")
        return {"error": str(e)}, 500

# Main API to create purchase invoice and distribute

def create_purchase_invoice_accounts(header_id, account_lines, current_userid, mydb):
    logger.debug(f"Entered the create_purchase_invoice_accounts function for header_id: {header_id}")
    try:
        cursor = mydb.cursor(dictionary=True) 

        insert_accounts_query = """
            INSERT INTO fin.purchaseinvoiceaccounts (line_number, header_id, account_id, debitamount, creditamount, created_by, updated_by)
            VALUES (%s, %s, %s, %s, %s, %s, %s)
        """

        for account in account_lines:
            cursor.execute('SET @next_val = 0;')  # Initialize the variable
            cursor.execute('CALL adm.get_next_sequence_value("PUR_DIST_LINE_NUMBER", @next_val);')
            cursor.execute('SELECT @next_val;')
            result = cursor.fetchone()
            logger.debug(f"Sequence result: {result}")
            if result is None or result['@next_val'] is None:
                raise Exception("Failed to retrieve next line number.")
 
            line_number = int(result['@next_val'])
            cursor.execute(insert_accounts_query, (
                line_number,
                header_id,
                int(account["account_id"]),
                account["debitamount"],
                account["creditamount"],
                current_userid,
                current_userid
            ))

        mydb.commit()
        cursor.close()
        return {"message": "Purchase invoice accounts created successfully", "success": True}, 200

    except Exception as e:
        logger.error(f"Unable to create purchase invoice accounts: {str(e)}")
        return {"error": str(e)}, 500





auto_create_po_pi_api = Blueprint('auto_create_po_pi_api', __name__)

@auto_create_po_pi_api.route('/auto_create_po_pi', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def auto_create_po_pi():
    mydb = None
    execution_id = str(uuid.uuid4())
    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header) if authorization_header else None
        USER_ID = token_results["username"] if token_results else ""
        MODULE_NAME = __name__

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'auto_create_po_pi' function")

        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        current_userid = None
        authorization_header = request.headers.get('Authorization', '')
        if authorization_header.startswith('Bearer '):
            token = authorization_header.replace('Bearer ', '')
            decoded_token = decode_token(token)
            current_userid = decoded_token.get('Userid')

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Received data: {data}")

        purchase_order_numbers = data.get("purchase_order_numbers", [])
        po_new_status = data.get("po_new_status")
        po_payment_terms = data.get("payment_terms")
        invoice_status = data.get("invoice_status")
        account_types = data.get("account_types", {})
        po_order_status_filter = data.get("po_order_status_filter")

        mydb = get_database_connection(USER_ID, MODULE_NAME)
        cursor = mydb.cursor(dictionary=True)

        if not purchase_order_numbers:
            placeholders = ', '.join(['%s'] * len(po_order_status_filter))
            query = f"""
                SELECT * FROM pur.purchase_order_header
                WHERE status IN ({placeholders})
            """
            cursor.execute(query, po_order_status_filter)
        else:
            po_placeholders = ', '.join(['%s'] * len(purchase_order_numbers))
            status_placeholders = ', '.join(['%s'] * len(po_order_status_filter))
            query = f"""
                SELECT * FROM pur.purchase_order_header
                WHERE po_num IN ({po_placeholders}) AND status IN ({status_placeholders})
            """
            cursor.execute(query, purchase_order_numbers + po_order_status_filter)

        purchase_orders = cursor.fetchall()
        responses = []
        total_tax_amount = Decimal(0)

        for order in purchase_orders:
            try:
                header_id = order["header_id"]
                pur_order_header_id = header_id
                supplier_id = order["supplier_id"]
                totalamount = Decimal(order["total_amount"])
                tax_id = order["tax_id"]
                tax_rate = 0.1  # Replace with actual logic if needed

                cursor.execute('SET @next_val = 0;')
                cursor.execute('CALL adm.get_next_sequence_value("PUR_HDR_INV_NUM", @next_val);')
                cursor.execute('SELECT @next_val;')
                result = cursor.fetchone()

                if result is None or result['@next_val'] is None:
                    raise Exception("Failed to retrieve next invoice number.")

                invoice_number = result['@next_val']

                invoice_data = {
                    "invoice_number": invoice_number,
                    "partnerid": supplier_id,
                    "invoicedate": datetime.now().strftime('%Y-%m-%d'),
                    "totalamount": totalamount,
                    "status": invoice_status,
                    "payment_terms": po_payment_terms,
                    "payment_duedate": (datetime.now() + timedelta(days=30)).strftime('%Y-%m-%d'),
                    "tax_id": tax_id,
                    "currency_id": order["currency_id"],
                    "department_id": order["department_id"],
                    "company_id": order["company_id"],
                    "transaction_source": f"PO {order['header_id']}",
                    "created_by": current_userid,
                    "updated_by": current_userid
                }

                # Create Purchase Invoice
                header_response, status_code = create_purchase_invoice(invoice_data, USER_ID, MODULE_NAME, mydb)
                if status_code != 200:
                    raise Exception(header_response.get("message", "Failed to create purchase invoice"))

                header_id = header_response["header_id"]

                logger.debug(f"{USER_ID} --> {MODULE_NAME}: Main function VEDAM HEADER_ID  : {header_id}")

                # Fetch purchase order lines
                cursor.execute("""
                    SELECT * FROM pur.purchase_order_line
                    WHERE header_id = %s
                """, (pur_order_header_id,))
                order_lines = cursor.fetchall()

                line_data = []
                starting_line_number = 1  # Starting point for line numbers
                logger.debug(f"{USER_ID} --> {MODULE_NAME}: Main function VEDAM  : {order_lines}")
                for index, line in enumerate(order_lines):
                    line_number = starting_line_number + index
                    line_data.append({
                        "line_number": line_number,
                        "header_id": header_id,
                        "item_id": line["item_id"],
                        "quantity": line["quantity"],
                        "unit_price": line["unit_price"],
                        "line_total": line["line_total"],
                        "uom_id": line["uom_id"],
                        "created_by": current_userid,
                        "updated_by": current_userid
                    })

                # Create Purchase Invoice Lines
                lines_response, status_code = create_purchase_invoice_lines(header_id, line_data, USER_ID, MODULE_NAME, mydb)
                if status_code != 200:
                    raise Exception(lines_response.get("message", "Failed to create purchase invoice lines"))

                account_lines = []
                credit_total = Decimal(0)
                debit_total = Decimal(0)
                tax_total = Decimal(0)

                # Process Credit accounts first
                for credit_account in account_types.get("Credit", []):
                    account_details = get_account_details(order["company_id"], order["department_id"], order["currency_id"], credit_account["account_name"], mydb, USER_ID, MODULE_NAME)
                    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Decimal to float error  is it appeared here 00 , {account_details}") 
                    #distribution_percentage = credit_account.get("distribution_percentage", 0)

                    distribution_percentage = Decimal(credit_account.get("distribution_percentage", 0)) / 100
                    credit_amount = totalamount * distribution_percentage

                    credit_total += credit_amount

                    account_lines.append({
                        "line_number": None,
                        "header_id": header_id,
                        "account_id": int(account_details["account_id"]),
                        "debitamount": 0,
                        "creditamount": credit_amount,
                        "created_by": current_userid,
                        "updated_by": current_userid
                    })


                logger.debug(f"{USER_ID} --> {MODULE_NAME}: Decimal to float error  is it appeared here 0000")
                if tax_id :
                    for debit_account in account_types.get("Debit", []):                 
                        if "Tax" in debit_account["category"] :
                            debit_amount = totalamount * Decimal(tax_rate)  # Taxable amount based on total amount
                            tax_total += debit_amount
                            account_details = get_account_details(order["company_id"], order["department_id"], order["currency_id"], debit_account["account_name"], mydb, USER_ID, MODULE_NAME) 
                            logger.debug(f"{USER_ID} --> {MODULE_NAME}: Decimal to float error  is it appeared here 1")  
                            account_lines.append({
                                "line_number": debit_account["account_name"],
                                "header_id": header_id,
                                "account_id": int(account_details["account_id"]),
                                "debitamount": debit_amount,
                                "creditamount": 0,
                                "created_by": current_userid,
                                "updated_by": current_userid
                            })

                remaining_amount = totalamount - tax_total
                logger.debug(f"{USER_ID} --> {MODULE_NAME}: Decimal to float error  is it appeared here 2 Total, remaining, tax total ,{totalamount} , {remaining_amount} {tax_total}")  
                for debit_account in account_types.get("Debit", []):
                    if "Tax" not in debit_account["category"]:  # Only non-tax accounts
                        distribution_percentage = Decimal(debit_account.get("distribution_percentage", 0)) / 100
                        debit_amount = remaining_amount * distribution_percentage

                        debit_total += debit_amount
                        account_details = get_account_details(order["company_id"], order["department_id"], order["currency_id"], debit_account["account_name"], mydb, USER_ID, MODULE_NAME) 
                        account_lines.append({
                            "line_number": debit_account["account_name"],
                            "header_id": header_id,
                            "account_id": int(account_details["account_id"]),
                            "debitamount": debit_amount,
                            "creditamount": 0,
                            "created_by": current_userid,
                            "updated_by": current_userid
                        })
                
                debit_total = debit_total + tax_total
                logger.debug(f"{USER_ID} --> {MODULE_NAME}: Decimal to float error  is it appeared here 3 Debit total {debit_total}")  
                # Insert account lines into purchase invoice accounts table

                logger.debug(f"{USER_ID} --> {MODULE_NAME}: Total Debit and Credit amount Total amount comparision: {debit_total} {credit_total} {totalamount}")            
                #rounded_debit_total = round(debit_total, 2)
                #rounded_credit_total = round(credit_total, 2)
                #rounded_totalamount = round(totalamount, 2)

                # Check if all rounded values are equal
                #if not (rounded_debit_total == rounded_credit_total == rounded_totalamount):
                #    raise Exception("Debit, Credit totals, and Total amount do not match after rounding to two decimal places.")
                # Convert values to Decimal and round to two decimal places
                debit_total = Decimal(debit_total).quantize(Decimal('0.01'), rounding=ROUND_HALF_UP)
                credit_total = Decimal(credit_total).quantize(Decimal('0.01'), rounding=ROUND_HALF_UP)
                totalamount = Decimal(totalamount).quantize(Decimal('0.01'), rounding=ROUND_HALF_UP)

                # Check if all rounded values are equal
                if not (debit_total == credit_total == totalamount):
                    raise Exception("Debit, Credit totals, and Total amount do not match after rounding to two decimal places.")                 


                # Insert Purchase Invoice Accounts
                accounts_response, status_code = create_purchase_invoice_accounts(header_id, account_lines, current_userid, mydb)
                if status_code != 200:
                    raise Exception(accounts_response.get("message", "Failed to create purchase invoice accounts"))


                # Log the purchase invoice creation
                log_data = {
                    "execution_id": execution_id,
                    "purchase_header_id": header_id,
                    "purchase_invoice_id": header_id,
                    "po_header_prev_status": order["status"],
                    "po_header_update_status": po_new_status,
                    "purchase_invoice_status": "CREATED",
                    "auto_purchase_status": "SUCCESS",
                    "created_by": current_userid,
                    "updated_by": current_userid
                }
                log_auto_purchase_invoice(log_data, mydb)

                # Update the purchase order status

                logger.debug(f"{USER_ID} --> {MODULE_NAME}: Now going to update a function to update PO header and lines for the header {header_id}")
                update_poheader_and_lines_status(USER_ID, MODULE_NAME, mydb, pur_order_header_id, po_new_status)
                logger.debug(f"{USER_ID} --> {MODULE_NAME}: The Function is executed successfully for the header {header_id}")

                responses.append({
                    "header_response": header_response,
                    "accounts": accounts_response,
                    "lines": lines_response,
                    "message": "Purchase order status updated to INVOICED successfully"
                })

            except Exception as e:
                logger.error(f"{USER_ID} --> {MODULE_NAME}: Error processing order {order['header_id']}: {str(e)}")
                continue

        return jsonify({"success": True, "invoices": responses}), 200

    except Exception as e:
        logger.error(f"Execution ID {execution_id}: An error occurred: {str(e)}")
        return jsonify({"error": str(e)}), 500

    finally:
        if mydb:
            mydb.close()

