# Import necessary modules and functions
from flask import Blueprint, request, jsonify
from modules.security.routines.get_user_and_db_details import get_user_and_db_details	
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from modules.common.routines.find_lowest_uom_and_cf import find_lowest_uom_and_cf
from modules.sales.routines.update_so_header_total_cumulative import update_so_header_total_cumulative
from modules.utilities.logger import logger

# Define the blueprint
update_sales_order_lines_api = Blueprint('update_sales_order_lines_api', __name__)

# Define the route for updating sales order lines
@update_sales_order_lines_api.route('/update_sales_order_lines', methods=['PUT'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def update_sales_order_lines():
    

    try:
        # Extract user information from token
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
            f"{appuser} --> {__name__}: Entered the 'update sales order line' function")

        mycursor = mydb.cursor()

        try:
            # Parse JSON request
            json_data = request.get_json()
            if not json_data:
                return 'error: No JSON data provided', 400

            header_id = json_data.get('header_id')
            lines = json_data.get('lines', [])

            if not header_id:
                return 'error: header_id is required', 400

            if not lines:
                return 'error: At least one line must be provided', 400

            # Initialize list to store updated line IDs
            updated_lines = []
            all_lines = []

            for line in lines:
                line_id = line.get('line_id')
                so_lnum = line.get('so_lnum')
                item_id = line.get('item_id')

                if not line_id and not so_lnum:
                    return 'error: line_id or so_lnum is required for each line', 400

                # Check if item_id is valid
                item_exists = check_item_id_existence(mydb, item_id)
                if not item_exists:
                    return jsonify({'error': f'Item with ID {item_id} does not exist'}), 400

                # Check if uom_id is present in the com.uom table
                uom_id = line.get('uom_id')
                if uom_id is not None:
                    uom_exists = check_uom_id_existence(mydb, uom_id)
                    if not uom_exists:
                        return jsonify({'error': f'UOM with ID {uom_id} does not exist'}), 400

                # Build the update query dynamically based on provided fields
                update_query_parts = []
                query_values = []

                if 'quantity' in line:
                    update_query_parts.append('quantity = %s')
                    query_values.append(line.get('quantity'))

                if 'unit_price' in line:
                    update_query_parts.append('unit_price = %s')
                    query_values.append(line.get('unit_price'))

                if 'line_total' in line:
                    update_query_parts.append('line_total = %s')
                    query_values.append(line.get('line_total'))

                if 'notes' in line:
                    update_query_parts.append('notes = %s')
                    query_values.append(line.get('notes'))

                if 'uom_id' in line:
                    update_query_parts.append('uom_id = %s')
                    query_values.append(line.get('uom_id'))

                if 'status' in line:
                    update_query_parts.append('status = %s')
                    query_values.append(line.get('status'))

                if 'item_id' in line:
                    update_query_parts.append('item_id = %s')
                    query_values.append(line.get('item_id'))

                if 'quantity' in line or 'unit_price' in line or 'uom_id' in line:
                    # Recalculate base_uom_id and base_quantity
                    result = find_lowest_uom_and_cf(uom_id, mydb, appuserid, __name__)
                    base_uom_id = result['base_unit']
                    base_uom_cf = result['conversion_factor']
                    base_quantity = line.get('quantity') * base_uom_cf
                    update_query_parts.append('base_uom_id = %s')
                    update_query_parts.append('base_quantity = %s')
                    update_query_parts.append('uom_conversion_factor = %s')
                    query_values.extend([base_uom_id, base_quantity,base_uom_cf])

                if line_id:
                    # Build the update query
                    update_query = f"""
                    UPDATE sal.sales_order_lines
                    SET {', '.join(update_query_parts)},
                    updated_by = %s
                    WHERE header_id = %s AND line_id = %s;
                    """
                    query_values.extend([appuserid, header_id, line_id])
                    mycursor.execute(update_query, query_values)

                    if mycursor.rowcount > 0:
                        updated_lines.append(line_id)
                else:
                    # Insert the line into the sales_order_line table
                    insert_line(mydb, header_id, so_lnum, line, appuserid, __name__)
                    updated_lines.append(so_lnum)

                all_lines.append({'line_id': line_id, 'so_lnum': so_lnum, 'header_id': header_id})

            if updated_lines:
                # Update total amount in the header table
                mycursor.execute("SELECT SUM(line_total) FROM sal.sales_order_lines WHERE header_id = %s", (header_id,))
                sum_of_line_total = mycursor.fetchone()[0]
                success = update_so_header_total_cumulative(appuser, __name__, mydb, header_id, sum_of_line_total)

                if success:
                    mydb.commit()
                    logger.debug(
                        f"{appuser} --> {__name__}: Successfully created/updated sales order lines")

                    response = {
                        'success': True,
                        'message': 'Sales order lines created/updated successfully',
                        'so_lines': all_lines
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
            else:
                mydb.rollback()
                logger.error(
                    f"{appuser} --> {__name__}: Failed to create/update sales order lines")
                return jsonify({'error': 'Failed to create/update records'}), 500

        except Exception as json_error:
            logger.error(
                f"{appuser} --> {__name__}: Error processing JSON input - {str(json_error)}")
            return jsonify({'error': 'Invalid JSON input'}), 400

    except Exception as e:
        logger.error(
            f"{appuser} --> {__name__}: Error updating sales order lines - {str(e)}")
        mydb.rollback()
        return 'error: Internal Server Error', 500

    finally:
        mycursor.close()
        mydb.close()


# Define the function to insert line
def insert_line(mydb, header_id, so_lnum, line_data, appuserid, __name__):
    try:
        # Build the insert query
        insert_query = """
            INSERT INTO sal.sales_order_lines (header_id, so_lnum, quantity, unit_price, line_total, notes, uom_id, status, item_id, base_uom_id, base_quantity, uom_conversion_factor, created_by, updated_by)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """

        # Extract line data
        quantity = line_data.get('quantity')
        unit_price = line_data.get('unit_price')
        line_total = line_data.get('line_total')
        notes = line_data.get('notes')
        uom_id = line_data.get('uom_id')
        status = line_data.get('status')
        item_id = line_data.get('item_id')

        # Calculate base_uom_id and base_quantity
        if uom_id is not None:
            result = find_lowest_uom_and_cf(uom_id, mydb, appuserid, __name__)
            base_uom_id = result['base_unit']
            base_uom_cf = result['conversion_factor']
            base_quantity = quantity * base_uom_cf
        else:
            base_uom_id = None
            base_quantity = None

        # Execute the insert query
        mycursor = mydb.cursor()
        query_values = (header_id, so_lnum, quantity, unit_price, line_total, notes, uom_id, status, item_id, base_uom_id, base_quantity, base_uom_cf,appuserid, appuserid)
        mycursor.execute(insert_query, query_values)
        mydb.commit()

    except Exception as e:
        raise e
    
    finally:
        mycursor.close()
        logger.debug(
            f"{appuserid} --> {__name__}: Successfully inserted sales order line with so_lnum {so_lnum}")


# Define the function to check item_id existence
def check_item_id_existence(mydb, item_id):
    try:
        mycursor = mydb.cursor()
        query = "SELECT COUNT(*) FROM com.items WHERE item_id = %s"
        mycursor.execute(query, (item_id,))
        count = mycursor.fetchone()[0]
        return count > 0
    finally:
        mycursor.close()


# Define the function to check uom_id existence
def check_uom_id_existence(mydb, uom_id):
    try:
        mycursor = mydb.cursor()
        query = "SELECT COUNT(*) FROM com.uom WHERE uom_id = %s"
        mycursor.execute(query, (uom_id,))
        count = mycursor.fetchone()[0]
        return count > 0
    finally:
        mycursor.close()
