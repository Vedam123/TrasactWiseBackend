from flask import abort, Blueprint, request, jsonify
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from modules.purchase.routines.update_po_header_total_byline import update_po_header_total_byline
from modules.utilities.logger import logger

create_purchase_order_line_api = Blueprint('create_purchase_order_line_api', __name__)

@create_purchase_order_line_api.route('/create_purchase_order_line', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_purchase_order_line():
    

    try:
        sum_of_line_total = 0
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

        logger.debug(
            f"{appuser} --> {__name__}: Entered the 'create purchase order line' function")

        mycursor = mydb.cursor()

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
                    line_total, tax_id, uom_id, notes, appuserid, appuserid, status
                )
                mycursor.execute(query, values)

                line_id = mycursor.lastrowid
                sum_of_line_total += line_data.get('line_total')

                response_lines.append({
                    'po_lnum': po_lnum,
                    'line_id': line_id
                })

            logger.debug(
                f"{appuser} --> {__name__}: Successfully created purchase order lines")

            success = update_po_header_total_byline(appuser, __name__, mydb, header_id, sum_of_line_total)

            if success:
                mydb.commit()
                logger.debug(
                    f"{appuser} --> {__name__}: Successfully created purchase order lines")

                response = {
                    'success': True,
                    'message': 'Purchase order lines created successfully',
                    'po_lines': response_lines
                }
            else:
                mydb.rollback()
                logger.error(
                    f"{appuser} --> {__name__}: Failed to update total_amount for header_id {header_id}")

                response = {
                    'success': False,
                    'message': 'Failed to update total_amount for the purchase order header',
                }

            return response, 201 if success else 500

        except Exception as json_error:
            logger.error(
                f"{appuser} --> {__name__}: Error processing JSON input - {str(json_error)}")
            return 'error: Invalid JSON input', 400

    except Exception as e:
        logger.error(
            f"{appuser} --> {__name__}: Error creating purchase order lines - {str(e)}")
        mydb.rollback()
        return 'error: Internal Server Error', 500

    finally:
        mycursor.close()
        mydb.close()
