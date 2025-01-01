from flask import  Blueprint, jsonify, request
import uuid
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details	
from modules.utilities.logger import logger
from config import WRITE_ACCESS_TYPE
from datetime import datetime, timedelta
from modules.finance.routines.get_account_details import get_account_details
from modules.sales.routines.update_soheader_and_lines_status import update_soheader_and_lines_status
from modules.sales.routines.log_auto_invoice import log_auto_invoice
from modules.common.routines.get_tax_rate_by_company_id import get_tax_rate_by_company_id
from modules.sales.routines.auto_process_tax_accounts import auto_process_tax_accounts
from decimal import Decimal,ROUND_HALF_UP
import traceback

# Helper function to create sales invoice header
def create_sales_invoice(data, appuser, __name__, mydb):
    try:
        cursor = mydb.cursor()

        insert_query = """
            INSERT INTO fin.salesinvoice (invoice_number, partnerid, invoicedate, totalamount, status, 
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

        return {
            "header_id": header_id,
            "invoice_number" : data["invoice_number"],
            "status":"Sucess",
        }, 200

    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Unable to create sales invoice header: {str(e)}")
        return {"error": str(e)}, 500

# Helper function to create sales invoice lines
def create_sales_invoice_lines(header_id, lines, appuser, __name__, mydb):
    logger.debug(f"{appuser} --> {__name__}: Entered the create sales invoice lines function for header id: {header_id}")
    try:
        cursor = mydb.cursor(dictionary=True)  # Create cursor with dictionary=True

        insert_query = """
            INSERT INTO fin.salesinvoicelines (line_number, header_id, item_id, quantity, unit_price, line_total, uom_id,created_by, updated_by)
            VALUES (%s, %s, %s, %s, %s, %s, %s,%s, %s)
        """

        response_lines = []
        for line in lines:
            # Call the stored procedure
            cursor.execute('SET @next_val = 0;')  # Initialize the variable
            
            # Call the stored procedure
            cursor.execute('CALL adm.get_next_sequence_value("SAL_LINE_NUMBER", @next_val);')
            
            # Retrieve the OUT parameter value
            cursor.execute('SELECT @next_val;')
            result = cursor.fetchone()
            if result is None or result['@next_val'] is None:
                raise Exception("Failed to retrieve next line number.")
            
            logger.debug(f"{appuser} --> {__name__}: Display Line data1 {line}")
            next_val = result['@next_val']  # Assign the value to line_number

            logger.debug(f"{appuser} --> {__name__}: Display Line data {line}")
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
            mydb.commit()  # Commit the transaction
            line_id = cursor.lastrowid

            response_lines.append({
                "line_id": line_id,
                "line_number": next_val,
                "line_total": line["line_total"]
            })

        cursor.close()
        logger.debug(f"{appuser} --> {__name__}: Before leaving the function: {response_lines}")
        
        return {
            "header_id": header_id,
            "line_id" : line_id,
            "line_number": next_val,
            "status":"Sucess",
        }, 200

    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Unable to create sales invoice lines: {str(e)}")
        return {"error": str(e)}, 500

def generate_execution_id():
    return str(uuid.uuid4())

# Main API to create sales invoice and distribute
auto_create_so_si_api = Blueprint('auto_create_so_si_api', __name__)

@auto_create_so_si_api.route('/auto_create_so_si', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def auto_create_so_si():
    mydb = None
    execution_id = generate_execution_id()
    responses = []
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
        

        logger.debug(f"{appuser} --> {__name__}: Entered the 'auto_create_so_si' function")

        if request.content_type == 'application/json':
            data = request.get_json()
        else:
            data = request.form

        logger.debug(f"{appuser} --> {__name__}: Received data: {data}")

        sales_order_numbers = data.get("sales_order_numbers", [])
        invoice_number = data.get("invoice_number")
        so_new_status = data.get("so_new_status")
        invoice_status = data.get("invoice_status")
        account_types = data.get("account_types", {})
        so_order_status_filter = data.get("so_order_status_filter")

        cursor = mydb.cursor(dictionary=True)

        logger.debug(f"{appuser} --> {__name__}: Sales order numbers: {sales_order_numbers}")

        if not sales_order_numbers:
            placeholders = ', '.join(['%s'] * len(so_order_status_filter))
            query = f"""
                SELECT * FROM sal.sales_order_headers
                WHERE status IN ({placeholders})
            """
            cursor.execute(query, so_order_status_filter)
        else:
            so_placeholders = ', '.join(['%s'] * len(sales_order_numbers))
            status_placeholders = ', '.join(['%s'] * len(so_order_status_filter))
            query = f"""
                SELECT * FROM sal.sales_order_headers
                WHERE so_num IN ({so_placeholders}) AND status IN ({status_placeholders})
            """
            cursor.execute(query, sales_order_numbers + so_order_status_filter)

        sales_orders = cursor.fetchall()

        logger.debug(f"{appuser} --> {__name__}: Fetched Sales orders that match with status: {sales_orders}")

        #if not sales_orders:
        #    logger.debug(f"{appuser} --> {__name__}: No Sales Orders fetched with the given status: {sales_orders}")
        #    return jsonify({'message': 'No Sales Orders fetched with the given status', 'sales_orders': sales_orders}), 404
        
        new_input_tax_type = None
        for find_tax_type in account_types.get("Credit", []):
            if find_tax_type["category"] == "Tax":
                new_input_tax_type = find_tax_type["tax_type"]
                break

        for order in sales_orders:
            try:
                header_id = order["header_id"]
                sales_header_id = header_id
                so_current_status = order["status"]
                partnerid = order["customer_id"]
                company_id = order["company_id"]
                totalamount = order["total_amount"]
                tax_id = order["tax_id"]
                new_tax_id = None
                if not tax_id:
                    new_tax_id, new_tax_rate = get_tax_rate_by_company_id(company_id, new_input_tax_type, appuser, __name__, mydb)

                cursor.execute('SET @next_val = 0;')  # Initialize the variable
                cursor.execute('CALL adm.get_next_sequence_value("SAL_HDR_INV_NUM", @next_val);')
                cursor.execute('SELECT @next_val;')
                result = cursor.fetchone()

                if result is None or result['@next_val'] is None:
                    raise Exception("Failed to retrieve next line number.")

                invoice_number = result['@next_val']
                logger.debug(f"{appuser} --> {__name__}: Check the new tax_id  ? {new_tax_id}")                
                invoice_data = None
                if tax_id:
                    invoice_data = {
                        "invoice_number": invoice_number,
                        "partnerid": partnerid,
                        "invoicedate": datetime.now().strftime('%Y-%m-%d'),
                        "totalamount": totalamount,
                        "status": invoice_status,
                        "payment_terms": order["payment_terms"],
                        "payment_duedate": (datetime.now() + timedelta(days=30)).strftime('%Y-%m-%d'),
                        "tax_id": tax_id,
                        "currency_id": order["currency_id"],
                        "department_id": order["department_id"],
                        "company_id": order["company_id"],
                        "transaction_source": f"SO {order['header_id']}",
                        "created_by": appuserid,
                        "updated_by": appuserid
                    }
                else:
                    invoice_data = {
                        "invoice_number": invoice_number,
                        "partnerid": partnerid,
                        "invoicedate": datetime.now().strftime('%Y-%m-%d'),
                        "totalamount": totalamount,
                        "status": invoice_status,
                        "payment_terms": order["payment_terms"],
                        "payment_duedate": (datetime.now() + timedelta(days=30)).strftime('%Y-%m-%d'),
                        "tax_id": new_tax_id,
                        "currency_id": order["currency_id"],
                        "department_id": order["department_id"],
                        "company_id": order["company_id"],
                        "transaction_source": f"SO {order['header_id']}",
                        "created_by": appuserid,
                        "updated_by": appuserid
                    }
                # Create Sales Invoice
                logger.debug(f"{appuser} --> {__name__}: Invoice Header Creation failed for SO OBSERVE tax_id IS EMPTY ? {invoice_data}")
                header_response, status_code = create_sales_invoice(invoice_data, appuser, __name__, mydb)
                if status_code != 200:
                    logger.debug(f"{appuser} --> {__name__}: Invoice Header Creation failed for SO {sales_header_id}. Response: {header_response}")
                    continue  # Skip to the next sales order

                header_id = header_response["header_id"]

                # Fetch sales order lines
                cursor.execute("""
                    SELECT * FROM sal.sales_order_lines
                    WHERE header_id = %s
                """, (sales_header_id,))
                order_lines = cursor.fetchall()
                line_data = []
                starting_line_number = 1  # Starting point for line numbers

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
                        "created_by": appuserid,
                        "updated_by": appuserid
                    })

                # Create Sales Invoice Lines
                lines_response, status_code = create_sales_invoice_lines(header_id, line_data, appuser, __name__, mydb)
                if status_code != 200:
                    logger.debug(f"{appuser} --> {__name__}: Invoice Line Creation failed for SO {sales_header_id}. Response: {lines_response}")
                    continue  # Skip to the next sales order

                account_lines = []
                debit_total = Decimal(0)
                credit_total = Decimal(0)
                total_tax_amount = Decimal(0)  # Initialize the total tax amount

                # Process Debit accounts
                for debit_account in account_types.get("Debit", []):
                    account_details = get_account_details(order["company_id"], order["department_id"], order["currency_id"], debit_account["account_type"], mydb, appuser, __name__)
                    distribution_percentage = Decimal(debit_account.get("distribution_percentage", 0)) / 100
                    debit_amount = totalamount * distribution_percentage

                    account_lines.append({
                        "line_number": None,  # To be filled later with sequence
                        "account_id": int(account_details["account_id"]),
                        "debitamount": debit_amount,
                        "creditamount": 0,
                        "is_tax_line": False  # Set is_tax_line to False for debit accounts
                    })
                    debit_total += debit_amount

                # Process Tax accounts first
                logger.debug(f"{appuser} --> {__name__}: Before calling the Auto process tax accounts function START ----------->")
                logger.debug(f"{appuser} --> {__name__}: Before calling the Auto process tax accounts Orders ----------->: {order}")
                logger.debug(f"{appuser} --> {__name__}: Before calling the Auto process tax accounts account types  ----------->: {account_types} ")
                logger.debug(f"{appuser} --> {__name__}: Before calling the Auto process tax accounts account lines  ----------->: {account_lines} ")
                total_tax_amount = auto_process_tax_accounts(order, totalamount, account_types, account_lines, appuser, __name__, mydb)       
                logger.debug(f"{appuser} --> {__name__}: After calling the Auto process tax accounts Orders ----------->: {order}")
                logger.debug(f"{appuser} --> {__name__}: After calling the Auto process tax accounts account types  ----------->: {account_types} ")
                logger.debug(f"{appuser} --> {__name__}: After calling the Auto process tax accounts account lines  ----------->: {account_lines} ")
                logger.debug(f"{appuser} --> {__name__}: After calling the Auto process tax accounts function END  ----------->")
                
                # Now process other Credit accounts   
                for credit_account in account_types.get("Credit", []):
                    account_details = get_account_details(order["company_id"], order["department_id"], order["currency_id"], credit_account["account_type"], mydb, appuser, __name__)
                    if credit_account["category"] != "Tax":
                        remaining_amount = totalamount - total_tax_amount
                        distribution_percentage = Decimal(credit_account.get("distribution_percentage", 0)) / 100
                        credit_amount = remaining_amount * distribution_percentage

                        account_lines.append({
                            "line_number": None,
                            "account_id": int(account_details["account_id"]),
                            "debitamount": 0,
                            "creditamount": credit_amount,
                            "is_tax_line": False  # Set is_tax_line to False for credit accounts
                        })
                        credit_total += credit_amount

                credit_total += total_tax_amount
              
                debit_total = Decimal(debit_total).quantize(Decimal('0.01'), rounding=ROUND_HALF_UP)
                credit_total = Decimal(credit_total).quantize(Decimal('0.01'), rounding=ROUND_HALF_UP)
                totalamount = Decimal(totalamount).quantize(Decimal('0.01'), rounding=ROUND_HALF_UP)

                # Check if all rounded values are equal
                #if not (debit_total == credit_total == totalamount):
                #    raise Exception("Debit, Credit totals, and Total amount do not match after rounding to two decimal places.")  
                
                if not (debit_total == credit_total == totalamount):
                    logger.error(f"Debit total: {debit_total}, Credit total: {credit_total}, Total amount: {totalamount}")
                    raise Exception("Debit, Credit totals, and Total amount do not match after rounding to two decimal places.")                

                # Distribute the accounts
                for line in account_lines:
                    cursor.execute('SET @next_val = 0;')
                    cursor.execute('CALL adm.get_next_sequence_value("SAL_DIST_LINE_NUMBER", @next_val);')
                    cursor.execute('SELECT @next_val;')
                    result = cursor.fetchone()
                    if result is None or result['@next_val'] is None:
                        raise Exception("Failed to retrieve next line number.")

                    line_number = result['@next_val']  # Assign the value to line_number

                    cursor.execute("""
                        INSERT INTO fin.salesinvoiceaccounts (header_id, line_number, account_id, debitamount, creditamount, is_tax_line, created_by, updated_by)
                        VALUES (%s, %s, %s, %s, %s, %s, %s, %s)
                    """, (
                        header_id,
                        line_number,
                        line["account_id"],
                        line["debitamount"],
                        line["creditamount"],
                        line["is_tax_line"],  # Insert is_tax_line value
                        appuserid,
                        appuserid
                    ))
                    mydb.commit()

                if not update_soheader_and_lines_status(appuser, __name__, mydb, sales_header_id, so_new_status):
                    logger.debug(f"{appuser} --> {__name__}: Failed to update sales order status for SO {sales_header_id}")
                    continue  # Skip to the next sales order

                auto_invoice_log_data = {
                    'execution_id': execution_id,
                    'sales_header_id': sales_header_id,
                    'invoice_header_id': header_id,
                    'so_header_prev_status': so_current_status,
                    'so_header_update_status': so_new_status,
                    'sales_invoice_status': invoice_data["status"],
                    'auto_inv_status': 'COMPLETED',
                    'created_by': appuserid,
                    'updated_by': appuserid
                }

                log_auto_invoice(auto_invoice_log_data, mydb)

                responses.append({
                    "header_response": header_response,
                    "accounts": account_lines,
                    "lines": lines_response,
                    "message": "Sales order status updated to INVOICED successfully"
                })

            except Exception as e:
                logger.debug(f"{appuser} --> {__name__}: Error processing sales order {order['header_id']}: {str(e)}")
                continue  # Continue to the next sales order

        return jsonify({"success": True, "invoices": responses}), 200

    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: An error occurred: {str(e)} at line {traceback.extract_stack()[-2].lineno}")
        if mydb:
            mydb.close()
        return jsonify({'error': str(e)}), 500
        
    finally:
        if mydb:
            mydb.close()
