from flask import Blueprint, request, jsonify
from modules.security.routines.get_user_and_db_details import get_user_and_db_details	
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from modules.sales.routines.update_so_header_total_byline import update_so_header_total_by_line
from modules.common.routines.find_lowest_uom_and_cf import find_lowest_uom_and_cf
from modules.utilities.logger import logger

create_sales_order_line_api = Blueprint('create_sales_order_line_api', __name__)

@create_sales_order_line_api.route('/create_sales_order_line', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_sales_order_line():
    

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
            f"{appuser} --> {__name__}: Entered the 'create sales order line' function")

        mycursor = mydb.cursor()

        try:
            json_data = request.get_json()
            if not json_data:
                return 'error: No JSON data provided', 400

            sales_order_lines = json_data.get('sales_order_lines')
            if not sales_order_lines or not isinstance(sales_order_lines, list):
                return 'error: Invalid sales order lines data', 400

            print("Sales order lines request", sales_order_lines)
            response_lines = []

            logger.debug(f"{appuser} --> {__name__}: Process the Sales order lines")

            for line_data in sales_order_lines:
                header_id = int(line_data.get('header_id'))
                so_lnum = int(line_data.get('so_lnum'))
                print("Header id -",header_id, so_lnum)
                # Check if header_id is present in sal.sales_order_headers
                mycursor.execute("SELECT header_id FROM sal.sales_order_headers WHERE header_id = %s", (header_id,))
                if not mycursor.fetchone():
                    print("Header id not found")
                    return f'error: Header with id {header_id} not found', 400

                # Check if same so_lnum is present in sal.sales_order_lines
                mycursor.execute("SELECT so_lnum FROM sal.sales_order_lines WHERE so_lnum = %s", (so_lnum,))
                if mycursor.fetchone():
                    print("The Line number already exists")
                    return f'error: Line number {so_lnum} already exists', 400
                item_id = int(line_data.get('item_id'))
                quantity = float(line_data.get('quantity'))
                unit_price = float(line_data.get('unit_price'))
                line_total = float(line_data.get('line_total'))
                notes = str(line_data.get('notes'))
                uom_id = int(line_data.get('uom_id'))
                status = str(line_data.get('status'))  # Extract status from JSON

                logger.debug(f"{appuser} --> {__name__}: Going to call find_lowest_uom_and_cf function ")

                result = find_lowest_uom_and_cf(uom_id, mydb, appuserid, __name__)
                base_uom_id = result['base_unit']
                base_uom_cf = result['conversion_factor']
                base_quantity = quantity * base_uom_cf

                logger.debug(f"{appuser} --> {__name__}: Retrieved base uom id from the function function {base_uom_id}")
                logger.debug(f"{appuser} --> {__name__}: Retrieved conversion factor from the function function {base_uom_cf}")
                logger.debug(f"{appuser} --> {__name__}: Calculated base quantity  {base_quantity}")

                query = """
                    INSERT INTO sal.sales_order_lines (
                        header_id, so_lnum, item_id, quantity, unit_price,
                        line_total,  uom_id, base_uom_id, uom_conversion_factor,base_quantity,notes, created_by, updated_by, status
                    ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s,%s,%s,%s);
                """
                values = (
                    header_id, so_lnum, item_id, quantity, unit_price,
                    line_total, uom_id, base_uom_id,base_uom_cf,base_quantity,notes, appuserid, appuserid, status
                )
                mycursor.execute(query, values)

                line_id = mycursor.lastrowid
                sum_of_line_total += line_data.get('line_total')

                response_lines.append({
                    'so_lnum': so_lnum,
                    'line_id': line_id
                })

            logger.debug(
                f"{appuser} --> {__name__}: Successfully created sales order lines")
            print("Header id before calling totals", header_id)
            success = update_so_header_total_by_line(appuser, __name__, mydb, header_id, sum_of_line_total)

            if success:
                mydb.commit()
                logger.debug(
                    f"{appuser} --> {__name__}: Successfully created sales order lines")

                response = {
                    'success': True,
                    'message': 'Sales order lines created successfully',
                    'so_lines': response_lines
                }
            else:
                mydb.rollback()
                logger.error(
                    f"{appuser} --> {__name__}: Failed to update total_amount for header_id {header_id}")

                response = {
                    'success': False,
                    'message': 'Failed to update total_amount for the sales order header',
                }

            return response, 201 if success else 500

        except Exception as json_error:
            logger.error(
                f"{appuser} --> {__name__}: Error processing JSON input - {str(json_error)}")
            return 'error: Invalid JSON input', 400

    except Exception as e:
        logger.error(
            f"{appuser} --> {__name__}: Error creating sales order lines - {str(e)}")
        mydb.rollback()
        return 'error: Internal Server Error', 500

    finally:
        mycursor.close()
        mydb.close()
