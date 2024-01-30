from flask import abort, Blueprint, request, jsonify
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.purchase.routines.update_po_header_total import update_po_header_total
from modules.utilities.logger import logger

create_purchase_order_line_api = Blueprint('create_purchase_order_line_api', __name__)

@create_purchase_order_line_api.route('/create_purchase_order_line', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_purchase_order_line():
    MODULE_NAME = __name__

    try:
        sum_of_line_total = 0
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        logger.debug(
            f"{USER_ID} --> {MODULE_NAME}: Entered the 'create purchase order line' function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)
        mycursor = mydb.cursor()

        current_userid = None
        authorization_header = request.headers.get('Authorization', '')
        if authorization_header.startswith('Bearer '):
            token = authorization_header.replace('Bearer ', '')
            decoded_token = decode_token(token)
            current_userid = decoded_token.get('Userid')

        try:
            json_data = request.get_json()
            if not json_data:
                return 'error: No JSON data provided', 400

            purchase_order_lines = json_data.get('purchase_order_lines')
            if not purchase_order_lines or not isinstance(purchase_order_lines, list):
                return 'error: Invalid purchase order lines data', 400

            print("Purchase order lines request",purchase_order_lines)
            response_lines = []

            for line_data in purchase_order_lines:
                header_id = int(line_data.get('header_id'))
                po_lnum = int(line_data.get('po_lnum'))
                item_id = int(line_data.get('item_id'))
                quantity = float(line_data.get('quantity'))
                unit_price = float(line_data.get('unit_price'))
                line_total = float(line_data.get('line_total'))
                tax_id = int(line_data.get('tax_id'))
                notes = str(line_data.get('notes'))
                uom_id = int(line_data.get('uom_id'))
                status = str(line_data.get('status'))  # Extract status from JSON

                query = """
                    INSERT INTO pur.purchase_order_line (
                        header_id, po_lnum, item_id, quantity, unit_price,
                        line_total, tax_id, uom_id, notes, created_by, updated_by, status
                    ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);
                """
                values = (
                    header_id, po_lnum, item_id, quantity, unit_price,
                    line_total, tax_id, uom_id, notes, current_userid, current_userid, status
                )
                mycursor.execute(query, values)

                line_id = mycursor.lastrowid
                sum_of_line_total += line_data.get('line_total')

                response_lines.append({
                    'po_lnum': po_lnum,
                    'line_id': line_id
                })

            logger.debug(
                f"{USER_ID} --> {MODULE_NAME}: Successfully created purchase order lines")

            success = update_po_header_total(USER_ID, MODULE_NAME, mydb, header_id, sum_of_line_total)

            if success:
                mydb.commit()
                logger.debug(
                    f"{USER_ID} --> {MODULE_NAME}: Successfully created purchase order lines")

                response = {
                    'success': True,
                    'message': 'Purchase order lines created successfully',
                    'po_lines': response_lines
                }
            else:
                mydb.rollback()
                logger.error(
                    f"{USER_ID} --> {MODULE_NAME}: Failed to update total_amount for header_id {header_id}")

                response = {
                    'success': False,
                    'message': 'Failed to update total_amount for the purchase order header',
                }

            return response, 201 if success else 500

        except Exception as json_error:
            logger.error(
                f"{USER_ID} --> {MODULE_NAME}: Error processing JSON input - {str(json_error)}")
            return 'error: Invalid JSON input', 400

    except Exception as e:
        logger.error(
            f"{USER_ID} --> {MODULE_NAME}: Error creating purchase order lines - {str(e)}")
        mydb.rollback()
        return 'error: Internal Server Error', 500

    finally:
        mycursor.close()
        mydb.close()
