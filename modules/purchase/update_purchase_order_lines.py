# Import necessary modules and functions

from flask import abort, Blueprint, request, jsonify
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.purchase.routines.update_po_header_total_cumulative import update_po_header_total_cumulative
from modules.utilities.logger import logger

# Define the blueprint
update_purchase_order_lines_api = Blueprint('update_purchase_order_lines_api', __name__)

# Define the route for updating purchase order lines
@update_purchase_order_lines_api.route('/update_purchase_order_lines', methods=['PUT'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def update_purchase_order_lines():
    MODULE_NAME = __name__

    try:
        # Extract user information from token
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        logger.debug(
            f"{USER_ID} --> {MODULE_NAME}: Entered the 'update purchase order line' function")

        # Get database connection
        mydb = get_database_connection(USER_ID, MODULE_NAME)
        mycursor = mydb.cursor()

        current_userid = None
        if authorization_header.startswith('Bearer '):
            token = authorization_header.replace('Bearer ', '')
            decoded_token = decode_token(token)
            current_userid = decoded_token.get('Userid')

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
                po_lnum = line.get('po_lnum')
                item_id = line.get('item_id')

                if not line_id and not po_lnum:
                    return 'error: line_id or po_lnum is required for each line', 400

                # Check if item_id is valid
                item_exists = check_item_id_existence(mydb, item_id)
                if not item_exists:
                    return jsonify({'error': f'Item with ID {item_id} does not exist'}), 400

                # Check if tax_id is present in the com.tax table
                tax_id = line.get('tax_id')
                if tax_id is not None:
                    tax_exists = check_tax_id_existence(mydb, tax_id)
                    if not tax_exists:
                        return jsonify({'error': f'Tax with ID {tax_id} does not exist'}), 400

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

                if 'tax_id' in line:
                    update_query_parts.append('tax_id = %s')
                    query_values.append(line.get('tax_id'))

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

                if line_id:
                    # Build the update query
                    print("line_id ", line_id)
                    update_query = f"""
                    UPDATE pur.purchase_order_line
                    SET {', '.join(update_query_parts)},
                    updated_by = %s
                    WHERE header_id = %s AND line_id = %s;
                    """

                    print("line_id ",line_id," Query", update_query)
                    print("line_id ",line_id,"  Values", query_values)                    
                    query_values.extend([current_userid, header_id, line_id])
                    mycursor.execute(update_query, query_values)

                    if mycursor.rowcount > 0:
                        updated_lines.append(line_id)
                else:
                    # Insert the line into the purchase_order_line table
                    print("No Line ID , Proceed to insert po_lnum",po_lnum)
                    insert_line(mydb, header_id, po_lnum, line, current_userid, MODULE_NAME)
                    updated_lines.append(po_lnum)
                all_lines.append({'line_id': line_id, 'po_lnum': po_lnum, 'header_id': header_id})

            if updated_lines:
                # Update total amount in the header table
                mycursor.execute("SELECT SUM(line_total) FROM pur.purchase_order_line WHERE header_id = %s", (header_id,))
                sum_of_line_total = mycursor.fetchone()[0]
                print("Sum of all the lines ",sum_of_line_total)
                success = update_po_header_total_cumulative(USER_ID, MODULE_NAME, mydb, header_id, sum_of_line_total)
                ##update_po_header_total(mydb, header_id,sum_of_line_total)


                if success:
                    mydb.commit()
                    logger.debug(
                        f"{USER_ID} --> {MODULE_NAME}: Successfully created purchase order lines")

                    response = {
                        'success': True,
                        'message': 'Purchase order lines created successfully',
                        'po_lines': all_lines
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
            else:
                mydb.rollback()
                logger.error(
                    f"{USER_ID} --> {MODULE_NAME}: Failed to update purchase order lines")
                return jsonify({'error': 'Failed to update records'}), 500

        except Exception as json_error:
            logger.error(
                f"{USER_ID} --> {MODULE_NAME}: Error processing JSON input - {str(json_error)}")
            return jsonify({'error': 'Invalid JSON input'}), 400

    except Exception as e:
        logger.error(
            f"{USER_ID} --> {MODULE_NAME}: Error updating purchase order lines - {str(e)}")
        mydb.rollback()
        return 'error: Internal Server Error', 500

    finally:
        mycursor.close()
        mydb.close()


# Define the function to insert line
def insert_line(mydb, header_id, po_lnum, line_data, current_userid, MODULE_NAME):
    try:
        # Build the insert query
        print("No Line ID , Inside insert Line function ",po_lnum, " and line data", line_data)        
        insert_query = """
            INSERT INTO pur.purchase_order_line (header_id, po_lnum, quantity, unit_price, line_total, tax_id, notes, uom_id, status, item_id, created_by, updated_by)
            VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)
        """

        # Extract line data
        quantity = line_data.get('quantity')
        unit_price = line_data.get('unit_price')
        line_total = line_data.get('line_total')
        tax_id = line_data.get('tax_id')
        notes = line_data.get('notes')
        uom_id = line_data.get('uom_id')
        status = line_data.get('status')
        item_id = line_data.get('item_id')

        # Check if item_id is valid
        item_exists = check_item_id_existence(mydb, item_id)
        if not item_exists:
            raise ValueError(f'Item with ID {item_id} does not exist')
        
        # Execute the insert query
        mycursor = mydb.cursor()
       # Execute the insert query
        query_values = (header_id, po_lnum, quantity, unit_price, line_total, tax_id, notes, uom_id, status, item_id, current_userid, current_userid)
        print("No Line ID , Inside insert Line function Query --> ",insert_query, " and Query Values --> ", query_values)             
        mycursor.execute(insert_query, query_values)


        mydb.commit()

    except Exception as e:
        raise e
    
    finally:
        mycursor.close()
        logger.debug(
            f"{current_userid} --> {MODULE_NAME}: Successfully inserted purchase order line with po_lnum {po_lnum}")


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


# Define the function to check tax_id existence
def check_tax_id_existence(mydb, tax_id):
    try:
        mycursor = mydb.cursor()
        query = "SELECT COUNT(*) FROM com.tax WHERE tax_id = %s"
        mycursor.execute(query, (tax_id,))
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
