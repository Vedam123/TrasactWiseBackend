from flask import Flask, Blueprint, jsonify, request
from flask_jwt_extended import decode_token
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger
from config import WRITE_ACCESS_TYPE
from datetime import datetime, timedelta
from modules.finance.routines.get_default_tax_rates import get_default_tax_rates
from modules.finance.routines.get_account_details import get_account_details
from decimal import Decimal
import traceback

# Helper function to create sales invoice header
def create_sales_invoice(data, USER_ID, MODULE_NAME, mydb):
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
            "message": "Sales Invoice created successfully",
            "status": "Pending",
            "success": True,
            "totalamount": data["totalamount"]
        }, 200

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Unable to create sales invoice header: {str(e)}")
        return {"error": str(e)}, 500

# Helper function to create sales invoice lines
def create_sales_invoice_lines(header_id, lines, USER_ID, MODULE_NAME, mydb):
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the create sales invoice lines function for header id: {header_id}")
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
            
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: Display Line data1 {line}")
            next_val = result['@next_val']  # Assign the value to line_number

            logger.debug(f"{USER_ID} --> {MODULE_NAME}: Display Line data {line}")
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
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Before leaving the function: {response_lines}")

        return {
            "lines": response_lines,
            "message": "Sales Invoice Lines created successfully",
            "success": True
        }, 200

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Unable to create sales invoice lines: {str(e)}")
        return {"error": str(e)}, 500

# Helper function to distribute accounts

# Main API to create sales invoice and distribute
auto_create_so_si_api = Blueprint('auto_create_so_si_api', __name__)

@auto_create_so_si_api.route('/auto_create_so_si', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def auto_create_so_si():
    mydb = None
    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header) if authorization_header else None
        USER_ID = token_results["username"] if token_results else ""
        MODULE_NAME = __name__

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'auto_create_so_si' function")

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

        sales_order_numbers = data.get("sales_order_numbers", [])
        invoice_number = data.get("invoice_number")
        status = data.get("status", "Pending")
        account_types = data.get("account_types", {})

        mydb = get_database_connection(USER_ID, MODULE_NAME)
        cursor = mydb.cursor(dictionary=True)

        if not sales_order_numbers:
            cursor.execute("""
                SELECT * FROM sal.sales_order_headers
                WHERE status IN ('APPROVED', 'PARTPICKED', 'PICKED')
            """)
        else:
            placeholders = ', '.join(['%s'] * len(sales_order_numbers))
            query = f"""
                SELECT * FROM sal.sales_order_headers
                WHERE so_num IN ({placeholders})
            """
            cursor.execute(query, sales_order_numbers)

        sales_orders = cursor.fetchall()
        responses = []
        total_tax_amount = Decimal(0)

        for order in sales_orders:
            header_id = order["header_id"]
            sales_header_id = header_id
            partnerid = order["customer_id"]
            totalamount = order["total_amount"]
            tax_id = order["tax_id"] or get_default_tax_rates(order["company_id"], "some_tax_types", mydb, USER_ID, MODULE_NAME)["tax_id"]
            tax_rate = 0.1  # Replace with actual logic if needed
            tax_account_type = data.get("tax_account_type")


            cursor.execute('SET @next_val = 0;')  # Initialize the variable
            cursor.execute('CALL adm.get_next_sequence_value("SAL_HDR_INV_NUM", @next_val);')
            cursor.execute('SELECT @next_val;')
            result = cursor.fetchone()

            if result is None or result['@next_val'] is None:
                raise Exception("Failed to retrieve next line number.")

            invoice_number = result['@next_val']  # Assign the value to line_number

            invoice_data = {
                "invoice_number": invoice_number,
                "partnerid": partnerid,
                "invoicedate": datetime.now().strftime('%Y-%m-%d'),
                "totalamount": totalamount,
                "status": status,
                "payment_terms": order["payment_terms"],
                "payment_duedate": (datetime.now() + timedelta(days=30)).strftime('%Y-%m-%d'),
                "tax_id": tax_id,
                "currency_id": order["currency_id"],
                "department_id": order["department_id"],
                "company_id": order["company_id"],
                "transaction_source": f"SO {order['header_id']}",
                "created_by": current_userid,
                "updated_by": current_userid
            }

            # Create Sales Invoice
            header_response, status_code = create_sales_invoice(invoice_data, USER_ID, MODULE_NAME, mydb)
            if status_code != 200:
                return jsonify(header_response), status_code
            
            header_id = header_response["header_id"]
            logger.info(f"{USER_ID} --> {MODULE_NAME}: What is the header id  VEDAM {sales_header_id}")
            # Fetch sales order lines
            cursor = mydb.cursor(dictionary=True)
            cursor.execute("""
                SELECT * FROM sal.sales_order_lines
                WHERE header_id = %s
            """, (sales_header_id,))
            order_lines = cursor.fetchall()
            #cursor.close()
            logger.info(f"{USER_ID} --> {MODULE_NAME}: bEFORE FORMING THE LINE what is the data in order lines VEDAM {order_lines}")
            line_data = []
            starting_line_number = 1  # Starting point for line numbers

            for index, line in enumerate(order_lines):
                line_number = starting_line_number + index
                line_data.append({
                    "line_number": line_number,  # Use sequential numbers
                    "header_id": header_id,
                    "item_id": line["item_id"],
                    "quantity": line["quantity"],
                    "unit_price": line["unit_price"],
                    "line_total": line["line_total"],
                    "uom_id": line["uom_id"],
                    "created_by": current_userid,
                    "updated_by": current_userid
                })
            logger.info(f"{USER_ID} --> {MODULE_NAME}: Added line: {line}")


            logger.info(f"{USER_ID} --> {MODULE_NAME}: Completed processing order lines. Resulting line_data: {line_data}")

            
            logger.info(f"{USER_ID} --> {MODULE_NAME}: Lines data formed to send to create sales invoice lines function VEDAM {line_data}")

            # Create Sales Invoice Lines
            lines_response, status_code = create_sales_invoice_lines(header_id, line_data, USER_ID, MODULE_NAME, mydb)
            if status_code != 200:
                return jsonify(lines_response), status_code
            account_lines = []
            debit_total = Decimal(0)
            credit_total = Decimal(0)

            # Process Debit accounts
            for debit_account in account_types.get("Debit", []):
                account_details = get_account_details(order["company_id"], order["department_id"], order["currency_id"], debit_account["account_name"], mydb, USER_ID, MODULE_NAME)
                distribution_percentage = Decimal(debit_account.get("distribution_percentage", 0)) / 100
                debit_amount = totalamount * distribution_percentage

                account_lines.append({
                    "line_number": None,  # To be filled later with sequence
                    "account_id": int(account_details["account_id"]),
                    "debitamount": debit_amount,
                    "creditamount": 0
                })
                debit_total += debit_amount

            if tax_id :    # Process Tax accounts first
                for credit_account in account_types.get("Credit", []):
                    account_details = get_account_details(order["company_id"], order["department_id"], order["currency_id"], credit_account["account_name"], mydb, USER_ID, MODULE_NAME)
                    if credit_account["category"] == "Tax":
                        tax_amount = totalamount * Decimal(tax_rate)
                        account_lines.append({
                            "line_number": None,
                            "account_id": int(account_details["account_id"]),
                            "debitamount": 0,
                            "creditamount": tax_amount
                        })
                        total_tax_amount += tax_amount

            # Now process other Credit accounts
            for credit_account in account_types.get("Credit", []):
                account_details = get_account_details(order["company_id"], order["department_id"], order["currency_id"], credit_account["account_name"], mydb, USER_ID, MODULE_NAME)
                if credit_account["category"] != "Tax":
                    remaining_amount = totalamount - total_tax_amount
                    distribution_percentage = Decimal(credit_account.get("distribution_percentage", 0)) / 100
                    credit_amount = remaining_amount * distribution_percentage

                    account_lines.append({
                        "line_number": None,
                        "account_id": int(account_details["account_id"]),
                        "debitamount": 0,
                        "creditamount": credit_amount
                    })
                    credit_total += credit_amount

            credit_total = credit_total + total_tax_amount
            # Validate totals
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: Total Debit and Credit amount : {debit_total} {credit_total} {totalamount}")            
            if not (debit_total == credit_total == totalamount):
                raise Exception("Debit and Credit totals do not match the total amount.")

            # Distribute the accounts

            logger.debug(f"{USER_ID} --> {MODULE_NAME}: Before checking the cursor and before forloop for acount_lines : {cursor} {mydb} {account_lines}  ") 

            ##cursor = mydb.cursor(dictionary=True) 
         
            for line in account_lines:
                logger.debug(f"{USER_ID} --> {MODULE_NAME}: In the for loop line {line}") 
                cursor.execute('SET @next_val = 0;')
                cursor.execute('CALL adm.get_next_sequence_value("SAL_DIST_LINE_NUMBER", @next_val);')
                cursor.execute('SELECT @next_val;')
                result = cursor.fetchone()
                logger.debug(f"Result from sequence retrieval: {result}")

                if result is None or result['@next_val'] is None:
                    raise Exception("Failed to retrieve next line number.")

                logger.error(f"Successfully got the , result was: {result}")
                line_number = result['@next_val']  # Assign the value to line_number
                logger.debug(f"Using line number: {line_number}")

                logger.debug(f"{USER_ID} --> {MODULE_NAME}: In the for loop after  line_number assignment {line_number}")
                logger.debug(f"{USER_ID} --> {MODULE_NAME}: Using line number: {line_number}")

                cursor.execute("""
                    INSERT INTO fin.salesinvoiceaccounts (header_id, line_number, account_id, debitamount, creditamount, created_by, updated_by)
                    VALUES (%s, %s, %s, %s, %s, %s, %s)
                """, (
                    header_id,
                    line_number,
                    line["account_id"],
                    line["debitamount"],
                    line["creditamount"],
                    current_userid,
                    current_userid
                ))
                mydb.commit()

            responses.append({
                "header_response": header_response,
                "accounts": account_lines,
                "lines": lines_response
            })
        
        #cursor.close()
        mydb.close()
        return jsonify(responses), 200

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: An error occurred: {str(e)} at line {traceback.extract_stack()[-2].lineno}")
        if mydb:
            mydb.close()
        return jsonify({'error': str(e)}), 500
