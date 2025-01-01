from flask import Blueprint, request, jsonify
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.security.permission_required import permission_required
from config import WRITE_ACCESS_TYPE
from modules.utilities.logger import logger

create_purchase_order_header_api = Blueprint('create_purchase_order_header_api', __name__)

@create_purchase_order_header_api.route('/create_purchase_order_header', methods=['POST'])
@permission_required(WRITE_ACCESS_TYPE, __file__)
def create_purchase_order_header():
    

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

        logger.debug(
            f"{appuser} --> {__name__}: Entered the 'create purchase order header' function")

        mycursor = mydb.cursor()

        # Extract data from JSON input
        try:
            json_data = request.get_json()
            if not json_data:
                return 'error: No JSON data provided', 400

            # Extracting fields from JSON input
            po_num = int(json_data.get('po_num'))
            company_id = int(json_data.get('company_id'))
            department_id = int(json_data.get('department_id'))
            rfq_header_id = int(json_data.get('rfq_header_id')) if json_data.get('rfq_header_id') else None
            po_date = json_data.get('po_date')
            supplier_id = int(json_data.get('supplier_id'))
            currency_id = int(json_data.get('currency_id'))
            tax_id = int(json_data.get('tax_id'))
            total_amount = float(json_data.get('total_amount'))
            status = str(json_data.get('status'))

            # Perform the insertion
            query = """
                INSERT INTO pur.purchase_order_header (
                    po_num, company_id, department_id, rfq_header_id, po_date,
                    supplier_id, currency_id, tax_id, total_amount, status,
                    created_by, updated_by
                ) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s);
            """
            values = (
                po_num, company_id, department_id, rfq_header_id, po_date,
                supplier_id, currency_id, tax_id, total_amount, status,
                appuserid, appuserid
            )
            mycursor.execute(query, values)

            # Get the generated header_id
            header_id = mycursor.lastrowid

            # Commit the transaction
            mydb.commit()

            logger.debug(
                f"{appuser} --> {__name__}: Successfully created purchase order header")

            response = {
                'success': True,
                'message': 'Purchase order created successfully',
                'po_num': po_num,
                'header_id': header_id,
                'currency': currency_id,
                'tax_id':tax_id
            }

            return response, 201

        except Exception as json_error:
            logger.error(
                f"{appuser} --> {__name__}: Error processing JSON input - {str(json_error)}")
            return 'error: Invalid JSON input', 400

    except Exception as e:
        logger.error(
            f"{appuser} --> {__name__}: Error creating purchase order header - {str(e)}")
        mydb.rollback()
        return 'error: Internal Server Error', 500

    finally:
        mycursor.close()
        mydb.close()
