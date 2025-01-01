from flask import Blueprint, jsonify, request
import uuid
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.security.permission_required import permission_required
from modules.utilities.logger import logger
from config import WRITE_ACCESS_TYPE
from datetime import datetime, timedelta
from modules.purchase.routines.log_auto_purchase_invoice import log_auto_purchase_invoice
from modules.purchase.routines.update_poheader_and_lines_status import update_poheader_and_lines_status
from modules.finance.routines.get_account_details import get_account_details
from modules.common.routines.get_tax_rate_by_company_id import get_tax_rate_by_company_id
from modules.purchase.routines.auto_process_tax_accounts import auto_process_tax_accounts
from decimal import Decimal,ROUND_HALF_UP

# Helper function to create purchase invoice header
def create_purchase_invoice(data, appuser, __name__, mydb):
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
            "invoice_number" : data["invoice_number"],
            "status":"Sucess",
        }, 200

    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Unable to create purchase invoice header: {str(e)}")
        return {"error": str(e)}, 500

# Helper function to create purchase invoice lines
def create_purchase_invoice_lines(header_id, lines, appuser, __name__, mydb):
    logger.debug(f"{appuser} --> {__name__}: Entered the create purchase invoice lines function for header id: {header_id}")
    try:
        cursor = mydb.cursor(dictionary=True)
        logger.debug(f"{appuser} --> {__name__}: Try block with cursor: {header_id}")
        insert_query = """
            INSERT INTO fin.purchaseinvoicelines (line_number, header_id, item_id, quantity, unit_price, line_total, uom_id, created_by, updated_by)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s)
        """
        logger.debug(f"{appuser} --> {__name__}: The query : {insert_query}")
        logger.debug(f"{appuser} --> {__name__}: Before forloop : {lines}")
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
                Decimal(line["quantity"]).quantize(Decimal('0.01'), rounding=ROUND_HALF_UP),
                Decimal(line["unit_price"]).quantize(Decimal('0.01'), rounding=ROUND_HALF_UP),
                Decimal(line["line_total"]).quantize(Decimal('0.01'), rounding=ROUND_HALF_UP),
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
        logger.debug(f"{appuser} --> {__name__}: After For loop : {lines}")
        cursor.close()
        logger.debug(f"{appuser} --> {__name__}: Before leaving the function: {response_lines}")
   
        return {
            "header_id": header_id,
            "line_id" : line_id,
            "line_number": next_val,
            "status":"Sucess",
        }, 200

    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Unable to create purchase invoice lines: {str(e)}")
        return {"error": str(e)}, 500

# Main API to create purchase invoice and distribute

def create_purchase_invoice_accounts(header_id, account_lines, appuserid, mydb):
    logger.debug(f"Entered the create_purchase_invoice_accounts function for header_id: {header_id}, account lines --> {account_lines}")
    try:
        cursor = mydb.cursor(dictionary=True) 

        insert_accounts_query = """
            INSERT INTO fin.purchaseinvoiceaccounts (line_number, header_id, account_id, debitamount, creditamount, is_tax_line, created_by, updated_by)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
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
            logger.debug(f"New line number to insert into accounts:  {line_number}")
            
            # Include is_tax_line in the insert query
            cursor.execute(insert_accounts_query, (
                line_number,
                header_id,
                int(account["account_id"]),
                Decimal(account["debitamount"]).quantize(Decimal('0.01'), rounding=ROUND_HALF_UP),         
                Decimal(account["creditamount"]).quantize(Decimal('0.01'), rounding=ROUND_HALF_UP),        
                account.get("is_tax_line", False),  # Add is_tax_line field
                appuserid,
                appuserid
            ))

        mydb.commit()
        cursor.close()

        return {
            "header_id": header_id,
            "account_line_number": line_number,
            "status":"Sucess",
        }, 200

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

        try:
            company, instance, dbuser, mydb, appuser, appuserid, user_info, employee_info = get_user_and_db_details(authorization_header)
            logger.debug(f"{appuser} --> {__name__}: Successfully retrieved user details from the token.")
        except ValueError as e:
            logger.error(f"Failed to retrieve user details from token. Error: {str(e)}")
            return jsonify({"error": str(e)}), 401
        
        if not appuser:
            logger.error(f"Unauthorized access attempt: {appuser} --> {__name__}: Application user not found.")
            return jsonify({"error": "Unauthorized. Username not found."}), 401
        

        logger.debug(f"{appuser} --> {__name__}: Entered the 'auto_create_po_pi' function")

        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        logger.debug(f"{appuser} --> {__name__}: Received data: {data}")

        purchase_order_numbers = data.get("purchase_order_numbers", [])
        po_new_status = data.get("po_new_status")
        po_payment_terms = data.get("payment_terms")
        invoice_status = data.get("invoice_status")
        account_types = data.get("account_types", {})
        po_order_status_filter = data.get("po_order_status_filter")

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
        total_tax_amount= Decimal(total_tax_amount).quantize(Decimal('0.01'), rounding=ROUND_HALF_UP)

        new_input_tax_type = None
        for find_tax_type in account_types.get("Credit", []):
            if find_tax_type["category"] == "Tax":
                new_input_tax_type = find_tax_type["tax_type"]
                break

        for order in purchase_orders:
            try:
                header_id = order["header_id"]
                pur_order_header_id = header_id
                supplier_id = order["supplier_id"]
                company_id = order["company_id"]
                totalamount = Decimal(order["total_amount"]).quantize(Decimal('0.01'), rounding=ROUND_HALF_UP)
                tax_id = order["tax_id"]
                new_tax_id = None
                if not tax_id:
                    new_tax_id, new_tax_rate = get_tax_rate_by_company_id(company_id, new_input_tax_type, appuser, __name__, mydb)

                tax_rate = 0.1  # Replace with actual logic if needed

                cursor.execute('SET @next_val = 0;')
                cursor.execute('CALL adm.get_next_sequence_value("PUR_HDR_INV_NUM", @next_val);')
                cursor.execute('SELECT @next_val;')
                result = cursor.fetchone()

                if result is None or result['@next_val'] is None:
                    raise Exception("Failed to retrieve next invoice number.")

                invoice_number = result['@next_val']
                if tax_id :
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
                        "created_by": appuserid,
                        "updated_by": appuserid
                    }
                else:
                    invoice_data = {
                        "invoice_number": invoice_number,
                        "partnerid": supplier_id,
                        "invoicedate": datetime.now().strftime('%Y-%m-%d'),
                        "totalamount": totalamount,
                        "status": invoice_status,
                        "payment_terms": po_payment_terms,
                        "payment_duedate": (datetime.now() + timedelta(days=30)).strftime('%Y-%m-%d'),
                        "tax_id": new_tax_id,
                        "currency_id": order["currency_id"],
                        "department_id": order["department_id"],
                        "company_id": order["company_id"],
                        "transaction_source": f"PO {order['header_id']}",
                        "created_by": appuserid,
                        "updated_by": appuserid
                    }

                # Create Purchase Invoice
                header_response, status_code = create_purchase_invoice(invoice_data, appuser, __name__, mydb)
                if status_code != 200:
                    raise Exception(header_response.get("message", "Failed to create purchase invoice"))

                header_id = header_response["header_id"]

                logger.debug(f"{appuser} --> {__name__}: Main function   : {header_id}")

                # Fetch purchase order lines
                cursor.execute("""
                    SELECT * FROM pur.purchase_order_line
                    WHERE header_id = %s
                """, (pur_order_header_id,))
                order_lines = cursor.fetchall()

                line_data = []
                starting_line_number = 1  # Starting point for line numbers
                logger.debug(f"{appuser} --> {__name__}: Main function   : {order_lines}")
                for index, line in enumerate(order_lines):
                    line_number = starting_line_number + index
                    line_data.append({
                        "line_number": line_number,
                        "header_id": header_id,
                        "item_id": line["item_id"],                     
                        "quantity":Decimal(line["quantity"]).quantize(Decimal('0.01'), rounding=ROUND_HALF_UP),
                        "unit_price": Decimal(line["unit_price"]).quantize(Decimal('0.01'), rounding=ROUND_HALF_UP),
                        "line_total": Decimal(line["line_total"]).quantize(Decimal('0.01'), rounding=ROUND_HALF_UP),                       
                        "uom_id": line["uom_id"],
                        "created_by": appuserid,
                        "updated_by": appuserid
                    })

                # Create Purchase Invoice Lines
                lines_response, status_code = create_purchase_invoice_lines(header_id, line_data, appuser, __name__, mydb)
                if status_code != 200:
                    raise Exception(lines_response.get("message", "Failed to create purchase invoice lines"))

                account_lines = []
                credit_total = Decimal(0)
                debit_total = Decimal(0)
                tax_total = Decimal(0)

                # Process Credit accounts first
                for credit_account in account_types.get("Credit", []):
                    account_details = get_account_details(order["company_id"], order["department_id"], order["currency_id"], credit_account["account_type"], mydb, appuser, __name__)
                    logger.debug(f"{appuser} --> {__name__}: Decimal to float error  is it appeared here 00 , {account_details}") 
                    #distribution_percentage = credit_account.get("distribution_percentage", 0)

                    distribution_percentage = Decimal(credit_account.get("distribution_percentage", 0)) / 100
                    credit_amount = totalamount * distribution_percentage

                    credit_total += credit_amount
                    logger.debug(f"{appuser} --> {__name__}: TO BE INSERTED CREDIT before  ROUNDING: {credit_amount}")
                    credit_amount = Decimal(credit_amount).quantize(Decimal('0.01'), rounding=ROUND_HALF_UP)
                    logger.debug(f"{appuser} --> {__name__}: TO BE INSERTED CREDIT AMOUNT AFTER ROUNDING: {credit_amount}")

                    account_lines.append({
                        "line_number": None,
                        "header_id": header_id,
                        "account_id": int(account_details["account_id"]),
                        "debitamount": 0,
                        "is_tax_line": False,  # Add is_tax_line field
                        "creditamount": credit_amount,
                        "created_by": appuserid,
                        "updated_by": appuserid
                    })

                logger.debug(f"{appuser} --> {__name__}: Decimal to float error  is it appeared here 0000")
                total_tax_amount= auto_process_tax_accounts(order, totalamount, account_types, account_lines, appuser, __name__, mydb) 
                
                logger.debug(f"{appuser} --> {__name__}: Decimal to float error  is it appeared here 2 Total, remaining, tax total ,{totalamount} , {account_types} {total_tax_amount}")  
                for debit_account in account_types.get("Debit", []):
                    if "Tax" not in debit_account["category"]:  # Only non-tax accounts
                        logger.debug(f"{appuser} --> {__name__}: Total amount and total tax amount: {totalamount} {total_tax_amount} ") 
                        remaining_amount = totalamount - total_tax_amount
                        distribution_percentage = Decimal(debit_account.get("distribution_percentage", 0)) / 100
                        debit_amount = remaining_amount * distribution_percentage
                        debit_total += debit_amount
                        logger.debug(f"{appuser} --> {__name__}: TO BE INSERTED DEBIT AMOUNT before  ROUNDING: {debit_amount}")
                        debit_amount = Decimal(debit_amount).quantize(Decimal('0.01'), rounding=ROUND_HALF_UP)
                        logger.debug(f"{appuser} --> {__name__}: TO BE INSERTED DEBIT AMOUNT AFTER ROUNDING: {debit_amount}")

                        account_details = get_account_details(order["company_id"], order["department_id"], order["currency_id"], debit_account["account_type"], mydb, appuser, __name__) 
                        account_lines.append({
                            "line_number": debit_account["account_type"],
                            "header_id": header_id,
                            "account_id": int(account_details["account_id"]),
                            "debitamount": debit_amount,
                            "creditamount": 0,
                            "is_tax_line": False,  # Add is_tax_line field
                            "created_by": appuserid,
                            "updated_by": appuserid
                        })
                
                debit_total = debit_total + total_tax_amount
                logger.debug(f"{appuser} --> {__name__}: Decimal to float error  is it appeared here 3 Debit total {debit_total}")  
                # Insert account lines into purchase invoice accounts table

                logger.debug(f"{appuser} --> {__name__}: Total Debit and Credit amount Total amount comparision: {debit_total} {credit_total} {totalamount}")            

                debit_total = Decimal(debit_total).quantize(Decimal('0.01'), rounding=ROUND_HALF_UP)
                credit_total = Decimal(credit_total).quantize(Decimal('0.01'), rounding=ROUND_HALF_UP)
                totalamount = Decimal(totalamount).quantize(Decimal('0.01'), rounding=ROUND_HALF_UP)

                if not (debit_total == credit_total == totalamount):
                    logger.error(f"Debit total: {debit_total} , Taxm amount: {total_tax_amount}, Credit total: {credit_total}, Total amount: {totalamount}")
                    raise Exception("Debit, Credit totals, and Total amount do not match after rounding to two decimal places.")               

                # Insert Purchase Invoice Accounts
                accounts_response, status_code = create_purchase_invoice_accounts(header_id, account_lines, appuserid, mydb)
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
                    "created_by": appuserid,
                    "updated_by": appuserid
                }
                log_auto_purchase_invoice(log_data, mydb)

                # Update the purchase order status

                logger.debug(f"{appuser} --> {__name__}: Now going to update a function to update PO header and lines for the header {header_id}")
                update_poheader_and_lines_status(appuser, __name__, mydb, pur_order_header_id, po_new_status)
                logger.debug(f"{appuser} --> {__name__}: The Function is executed successfully for the header {header_id}")

                responses.append({
                    "header_response": header_response,
                    "accounts": accounts_response,
                    "lines": lines_response,
                    "message": "Purchase order status updated to INVOICED successfully"
                })

            except Exception as e:
                logger.error(f"{appuser} --> {__name__}: Error processing order {order['header_id']}: {str(e)}")
                continue

        return jsonify({"success": True, "invoices": responses}), 200

    except Exception as e:
        logger.error(f"Execution ID {execution_id}: An error occurred: {str(e)}")
        return jsonify({"error": str(e)}), 500

    finally:
        if mydb:
            mydb.close()

