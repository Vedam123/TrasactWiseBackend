from flask import Blueprint, request, jsonify
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

update_purchase_order_header_api = Blueprint('update_purchase_order_header_api', __name__)

@update_purchase_order_header_api.route('/update_purchase_order_header', methods=['PUT'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def update_purchase_order_header():
    MODULE_NAME = __name__

    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        logger.debug(
            f"{USER_ID} --> {MODULE_NAME}: Entered the 'update purchase order header' function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)
        mycursor = mydb.cursor()

        current_userid = None
        authorization_header = request.headers.get('Authorization', '')
        if authorization_header.startswith('Bearer '):
            token = authorization_header.replace('Bearer ', '')
            decoded_token = decode_token(token)
            current_userid = decoded_token.get('Userid')

        # Extract data from JSON input
        try:
            json_data = request.get_json()
            if not json_data:
                return jsonify({'error': 'No JSON data provided'}), 400

            # Extracting fields from JSON input
            fields_to_update = {}
            if 'po_date' in json_data:
                fields_to_update['po_date'] = json_data['po_date']
            if 'supplier_id' in json_data:
                fields_to_update['supplier_id'] = int(json_data['supplier_id'])
            if 'currency_id' in json_data:
                fields_to_update['currency_id'] = int(json_data['currency_id'])
            if 'tax_id' in json_data:
                fields_to_update['tax_id'] = int(json_data['tax_id'])
            if 'total_amount' in json_data:
                fields_to_update['total_amount'] = float(json_data['total_amount'])
            if 'status' in json_data:
                fields_to_update['status'] = str(json_data['status'])
            if 'company_id' in json_data:
                fields_to_update['company_id'] = int(json_data['company_id'])
            if 'department_id' in json_data:
                fields_to_update['department_id'] = int(json_data['department_id'])
            
            # Log input parameters
            logger.info(f"{USER_ID} --> {MODULE_NAME}: JSON Input Parameters - {fields_to_update}")

            # Extract query parameters
            header_id = request.args.get('header_id')
            po_num = request.args.get('po_num')
            rfq_header_id = request.args.get('rfq_header_id')
            
            # Log query parameters
            logger.info(f"{USER_ID} --> {MODULE_NAME}: Query Parameters - header_id: {header_id}, po_num: {po_num}, rfq_header_id: {rfq_header_id}")
            # Ensure at least one parameter is sent
            if not header_id and not po_num and not rfq_header_id:
                return jsonify({'error': "At least one of 'header_id', 'po_num', or 'rfq_header_id' must be provided."}), 400

            # Build WHERE clause based on provided parameters
            where_conditions = []
            where_query_values = []

            if header_id:
                where_conditions.append("header_id = %s")
                where_query_values.append(int(header_id))
            if po_num:
                where_conditions.append("po_num = %s")
                where_query_values.append(int(po_num))
            if rfq_header_id:
                where_conditions.append("rfq_header_id = %s")
                where_query_values.append(int(rfq_header_id))

            where_clause = " AND ".join(where_conditions)

            # Find header_id if not provided
            if not header_id:
                select_header_id_query = f"""
                    SELECT header_id FROM pur.purchase_order_header WHERE {where_clause};
                """
                mycursor.execute(select_header_id_query, where_query_values)
                result = mycursor.fetchone()
                if result:
                    header_id = result[0]
                else:
                    logger.warning(f"{USER_ID} --> {MODULE_NAME}: No record found with the given parameters")
                    return jsonify({'error': 'No record found with the given parameters'}), 404

            # Check if supplier_id exists, if provided
            if 'supplier_id' in fields_to_update:
                supplier_check_query = "SELECT COUNT(*) FROM com.businesspartner WHERE partnerid = %s;"
                mycursor.execute(supplier_check_query, (fields_to_update['supplier_id'],))
                supplier_exists = mycursor.fetchone()[0]

                if supplier_exists == 0:
                    logger.warning(f"{USER_ID} --> {MODULE_NAME}: Supplier with ID {fields_to_update['supplier_id']} does not exist")
                    return jsonify({'error': f"Supplier with ID {fields_to_update['supplier_id']} does not exist"}), 404

            # Check if tax_id exists, if provided
            if 'tax_id' in fields_to_update:
                tax_check_query = "SELECT COUNT(*) FROM com.tax WHERE tax_id = %s;"
                mycursor.execute(tax_check_query, (fields_to_update['tax_id'],))
                tax_exists = mycursor.fetchone()[0]

                if tax_exists == 0:
                    logger.warning(f"{USER_ID} --> {MODULE_NAME}: Tax with ID {fields_to_update['tax_id']} does not exist")
                    return jsonify({'error': f"Tax with ID {fields_to_update['tax_id']} does not exist"}), 404

            # Check if currency_id exists, if provided
            if 'currency_id' in fields_to_update:
                currency_check_query = "SELECT COUNT(*) FROM com.currency WHERE currency_id = %s;"
                mycursor.execute(currency_check_query, (fields_to_update['currency_id'],))
                currency_exists = mycursor.fetchone()[0]

                if currency_exists == 0:
                    logger.warning(f"{USER_ID} --> {MODULE_NAME}: Currency with ID {fields_to_update['currency_id']} does not exist")
                    return jsonify({'error': f"Currency with ID {fields_to_update['currency_id']} does not exist"}), 404
                
            if 'company_id' in fields_to_update:
                company_check_query = "SELECT COUNT(*) FROM com.company WHERE id = %s;"
                mycursor.execute(company_check_query, (fields_to_update['company_id'],))
                company_exists = mycursor.fetchone()[0]

                if company_exists == 0:
                    logger.warning(f"{USER_ID} --> {MODULE_NAME}: Company with ID {fields_to_update['company_id']} does not exist")
                    return jsonify({'error': f"Company with ID {fields_to_update['company_id']} does not exist"}), 404
                
            if 'department_id' in fields_to_update:
                department_check_query = "SELECT COUNT(*) FROM com.department WHERE id = %s;"
                mycursor.execute(department_check_query, (fields_to_update['department_id'],))
                department_exists = mycursor.fetchone()[0]

                if department_exists == 0:
                    logger.warning(f"{USER_ID} --> {MODULE_NAME}: Department with ID {fields_to_update['department_id']} does not exist")
                    return jsonify({'error': f"Department with ID {fields_to_update['department_id']} does not exist"}), 404

            select_query = f"""
                SELECT COUNT(*) FROM pur.purchase_order_header WHERE {where_clause};
            """
            mycursor.execute(select_query, where_query_values)
            record_count = mycursor.fetchone()[0]
            if record_count == 0:
                logger.warning(f"{USER_ID} --> {MODULE_NAME}: No record found with the given parameters")
                return jsonify({'error': 'No record found with the given parameters'}), 404

            # Build the SET clause and values dynamically
            set_clause = ", ".join([f"{key} = %s" for key in fields_to_update.keys()])
            update_query_values = list(fields_to_update.values())

            # Include updated_by and its value
            set_clause += ", updated_by = %s"
            update_query_values.append(current_userid)

            # Perform the update
            update_query = f"""
                UPDATE pur.purchase_order_header
                SET {set_clause}
                WHERE {where_clause};
            """
            update_query_values.extend(where_query_values)

            mycursor.execute(update_query, update_query_values)
            logger.info(f"{USER_ID} --> {MODULE_NAME}: The Query  : {update_query}")
            logger.info(f"{USER_ID} --> {MODULE_NAME}: The Where clause  : {where_clause}")

            # Commit the transaction
            mydb.commit()

            if mycursor.rowcount > 0:
                # Update the status in purchase_order_line if status is changed
                if 'status' in fields_to_update:
                    update_purchase_order_lines_status(mydb, header_id, fields_to_update['status'], current_userid)
                
                # Log success
                logger.info(f"{USER_ID} --> {MODULE_NAME}: Updated purchase order")
                # Close the cursor and connection
                mycursor.close()
                mydb.close()
                # Return success message
                return jsonify({'status': True, 'message': 'Purchase Order updated successfully'}), 200
            else:
                # Log that no rows were updated
                logger.warning(f"{USER_ID} --> {MODULE_NAME}: There is no purchase order with the given data")
                # Close the cursor and connection
                mycursor.close()
                mydb.close()
                # Return appropriate message
                return jsonify({'status': False, 'message': 'There is no purchase order with the given data'}), 404

        except Exception as json_error:
            logger.error(
                f"{USER_ID} --> {MODULE_NAME}: Error processing JSON input - {str(json_error)}")
            return jsonify({'error': 'Invalid JSON input'}), 400

    except Exception as e:
        logger.error(
            f"{USER_ID} --> {MODULE_NAME}: Error updating purchase order header - {str(e)}")
        mydb.rollback()
        return jsonify({'error': 'Internal Server Error'}), 500

    finally:
        try:
            mycursor.close()
        except NameError:
            pass  # Cursor was not defined

def update_purchase_order_lines_status(mydb, header_id, new_status, current_userid):
    MODULE_NAME = __name__
    USER_ID = "system"
    try:
        mycursor = mydb.cursor()
        update_lines_query = """
            UPDATE pur.purchase_order_line
            SET status = %s, updated_by = %s
            WHERE header_id = %s;
        """
        mycursor.execute(update_lines_query, (new_status, current_userid, header_id))
        mydb.commit()
        logger.info(f"{USER_ID} --> {MODULE_NAME}: Updated purchase order lines status for header_id: {header_id} to status: {new_status}")
        mycursor.close()
    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error updating purchase order lines status - {str(e)}")
        mydb.rollback()
        raise
