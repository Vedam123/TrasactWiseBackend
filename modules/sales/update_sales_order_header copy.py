from flask import Blueprint, request, jsonify
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from flask_jwt_extended import decode_token
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

update_sales_order_header_api = Blueprint('update_sales_order_header_api', __name__)

# Update sales order header API endpoint
@update_sales_order_header_api.route('/update_sales_order_header', methods=['PUT'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def update_sales_order_header():
    MODULE_NAME = __name__

    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        logger.debug(
            f"{USER_ID} --> {MODULE_NAME}: Entered the 'update sales order header' function")

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
            so_date = json_data.get('so_date')
            customer_id = int(json_data.get('customer_id'))
            currency_id = int(json_data.get('currency_id'))
            tax_id = int(json_data.get('tax_id'))
            total_amount = float(json_data.get('total_amount'))
            status = str(json_data.get('status'))
            shipping_method = json_data.get('shipping_method')
            payment_terms = json_data.get('payment_terms')
            order_type = json_data.get('type')  # New field
            department_id = int(json_data.get('department_id'))
            company_id = int(json_data.get('company_id'))
            billing_address = json_data.get('billing_address')
            shipping_address = json_data.get('shipping_address')
            rep_id = json_data.get('rep_id')
            comments = json_data.get('comments')

            # Handle potential None values
            if rep_id is not None:
                rep_id = int(rep_id)

            # Log input parameters
            logger.info(f"{USER_ID} --> {MODULE_NAME}: JSON Input Parameters - so_date: {so_date}, customer_id: {customer_id}, currency_id: {currency_id}, tax_id: {tax_id}, total_amount: {total_amount}, status: {status}, shipping_method: {shipping_method}, payment_terms: {payment_terms}, type: {order_type}, department_id: {department_id}, company_id: {company_id}, billing_address: {billing_address}, shipping_address: {shipping_address}, rep_id: {rep_id}, comments: {comments}")

            # Extract query parameters
            header_id = request.args.get('header_id')
            so_num = request.args.get('so_num')
            opportunity_id_query = request.args.get('opportunity_id')

            # Convert query parameters to appropriate types if they are not None
            if header_id is not None:
                header_id = int(header_id)
            if so_num is not None:
                so_num = int(so_num)
            if opportunity_id_query is not None:
                opportunity_id_query = int(opportunity_id_query)

            # Log query parameters
            logger.info(f"{USER_ID} --> {MODULE_NAME}: Query Parameters - header_id: {header_id}, so_num: {so_num}, opportunity_id: {opportunity_id_query}")

            # Ensure at least one parameter is sent
            if header_id is None and so_num is None and opportunity_id_query is None:
                return jsonify({'error': "At least one of 'header_id', 'so_num', or 'opportunity_id' must be provided."}), 400

            # Build WHERE clause based on provided parameters
            where_conditions = []
            where_query_values = []

            print("Stage 1")

            if header_id is not None:
                where_conditions.append("header_id = %s")
                where_query_values.append(header_id)
            if so_num is not None:
                where_conditions.append("so_num = %s")
                where_query_values.append(so_num)
            if opportunity_id_query is not None:
                where_conditions.append("opportunity_id = %s")
                where_query_values.append(opportunity_id_query)

            where_clause = " AND ".join(where_conditions)

            print("Stage 2")

            # Check if customer_id exists
            customer_check_query = "SELECT COUNT(*) FROM com.businesspartner WHERE partnerid = %s;"
            mycursor.execute(customer_check_query, (customer_id,))
            customer_exists = mycursor.fetchone()[0]

            if customer_exists == 0:
                logger.warning(f"{USER_ID} --> {MODULE_NAME}: Customer with ID {customer_id} does not exist")
                return jsonify({'error': f"Customer with ID {customer_id} does not exist"}), 404

            # Check if tax_id exists
            tax_check_query = "SELECT COUNT(*) FROM com.tax WHERE tax_id = %s;"
            mycursor.execute(tax_check_query, (tax_id,))
            tax_exists = mycursor.fetchone()[0]

            if tax_exists == 0:
                logger.warning(f"{USER_ID} --> {MODULE_NAME}: Tax with ID {tax_id} does not exist")
                return jsonify({'error': f"Tax with ID {tax_id} does not exist"}), 404

            # Check if currency_id exists
            currency_check_query = "SELECT COUNT(*) FROM com.currency WHERE currency_id = %s;"
            mycursor.execute(currency_check_query, (currency_id,))
            currency_exists = mycursor.fetchone()[0]

            if currency_exists == 0:
                logger.warning(f"{USER_ID} --> {MODULE_NAME}: Currency with ID {currency_id} does not exist")
                return jsonify({'error': f"Currency with ID {currency_id} does not exist"}), 404
            
            print("Stage 3")

            # Check if opportunity_id exists
            if opportunity_id_query is not None:
                opportunity_check_query = "SELECT COUNT(*) FROM com.opportunity WHERE opportunity_id = %s;"
                mycursor.execute(opportunity_check_query, (opportunity_id_query,))
                opportunity_exists = mycursor.fetchone()[0]

                if opportunity_exists == 0:
                    logger.warning(f"{USER_ID} --> {MODULE_NAME}: Opportunity with ID {opportunity_id_query} does not exist")
                    return jsonify({'error': f"Opportunity with ID {opportunity_id_query} does not exist"}), 404

            # Check if department_id exists
            department_check_query = "SELECT COUNT(*) FROM com.department WHERE id = %s;"
            mycursor.execute(department_check_query, (department_id,))
            department_exists = mycursor.fetchone()[0]
            print("Stage 4")
            if department_exists == 0:
                logger.warning(f"{USER_ID} --> {MODULE_NAME}: Department with ID {department_id} does not exist")
                return jsonify({'error': f"Department with ID {department_id} does not exist"}), 404

            # Check if company_id exists
            company_check_query = "SELECT COUNT(*) FROM com.company WHERE id = %s;"
            mycursor.execute(company_check_query, (company_id,))
            company_exists = mycursor.fetchone()[0]

            if company_exists == 0:
                logger.warning(f"{USER_ID} --> {MODULE_NAME}: Company with ID {company_id} does not exist")
                return jsonify({'error': f"Company with ID {company_id} does not exist"}), 404

            select_query = f"""
                SELECT COUNT(*) FROM sal.sales_order_headers WHERE {where_clause};
            """
            mycursor.execute(select_query, where_query_values)
            record_count = mycursor.fetchone()[0]

            if record_count == 0:
                logger.warning(f"{USER_ID} --> {MODULE_NAME}: No record found with the given parameters")
                return jsonify({'error': 'No record found with the given parameters'}), 404

            update_query_values = []
            # Perform the update
            update_query = f"""
                UPDATE sal.sales_order_headers
                SET so_date = %s, customer_id = %s, currency_id = %s, tax_id = %s, total_amount = %s, status = %s,
                    shipping_method = %s, payment_terms = %s, type = %s, department_id = %s,
                    company_id = %s, billing_address = %s, shipping_address = %s, rep_id = %s, comments = %s,
                    updated_by = %s
                WHERE {where_clause};
            """

            update_query_values.extend([so_date, customer_id, currency_id, tax_id, total_amount, status, shipping_method,
                                        payment_terms, order_type, department_id, company_id, billing_address,
                                        shipping_address, rep_id, comments, current_userid] + where_query_values)

            mycursor.execute(update_query, update_query_values)

            # Commit the transaction
            mydb.commit()

            if mycursor.rowcount > 0:
                # Log success
                logger.info(f"{USER_ID} --> {MODULE_NAME}: Updated sales order header")
                # Close the cursor and connection
                mycursor.close()
                mydb.close()
                # Return success message
                return jsonify({'status': True, 'message': 'Sales Order updated successfully'}), 200
            else:
                # Log that no rows were updated
                logger.warning(f"{USER_ID} --> {MODULE_NAME}: No changes are done to update")
                # Close the cursor and connection
                mycursor.close()
                mydb.close()
                # Return appropriate message
                return jsonify({'status': False, 'message': 'No changes are done to update'}), 404

        except Exception as json_error:
            logger.error(
                f"{USER_ID} --> {MODULE_NAME}: Error processing JSON input - {str(json_error)}")
            return jsonify({'error': 'Invalid JSON input'}), 400

    except Exception as e:
        logger.error(
            f"{USER_ID} --> {MODULE_NAME}: Error updating sales order header - {str(e)}")
        mydb.rollback()
        return jsonify({'error': 'Internal Server Error'}), 500

    finally:
        try:
            mycursor.close()
        except NameError:
            pass  # Cursor was not defined
