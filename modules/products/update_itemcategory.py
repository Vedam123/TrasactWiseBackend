from flask import Blueprint, jsonify, request
from modules.security.routines.get_user_and_db_details import get_user_and_db_details	
from modules.security.permission_required import permission_required
from config import UPDATE_ACCESS_TYPE
from modules.utilities.logger import logger

update_itemcategory_api = Blueprint('update_itemcategory_api', __name__)

@update_itemcategory_api.route('/update_itemcategory', methods=['PUT'])
@permission_required(UPDATE_ACCESS_TYPE, __file__)
def update_itemcategory():
  
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

    if request.content_type == 'application/json':
        data = request.get_json()
    else:
        data = request.form

    # Log entry point
    logger.debug(f"{appuser} --> {__name__}: Entered in the update item data function")

   
    cursor = mydb.cursor()

    # Extract required fields
    category_id = data.get('category_id')
    category_name = data.get('category_name')
    description = data.get('description', '')
    is_active = data.get('is_active', True)
    tax_information = data.get('tax_information')
    default_uom = data.get('default_uom')

    # Validate required fields
    if not category_id or not category_name:
        logger.warning(f"{appuser} --> {__name__}: Missing required fields category_id or category_name.")
        return jsonify({'message': 'category_id and category_name are required fields.'}), 400

    try:
        # Prepare the update query
        update_query = """
            UPDATE com.itemcategory 
            SET category_name = %s, description = %s, is_active = %s, tax_information = %s, default_uom = %s, 
                updated_by = %s 
            WHERE category_id = %s
        """
        update_values = (category_name, description, is_active, tax_information, default_uom, appuserid 
        , category_id)

        # Execute the update query
        cursor.execute(update_query, update_values)
        mydb.commit()

        # Log successful update
        logger.info(f"{appuser} --> {__name__}: Category updated with category_id={category_id}")

        # Return the updated category details
        return jsonify({
            'category_id': category_id,
            'category_name': category_name,
            'description': description,
            'is_active': is_active,
            'tax_information': tax_information,
            'default_uom': default_uom
        }), 200

    except Exception as e:
        mydb.rollback()
        logger.error(f"{appuser} --> {__name__}: Failed to update itemcategory: {str(e)}")
        return jsonify({'message': 'Failed to update item category.', 'error': str(e)}), 500

    finally:
        cursor.close()
        mydb.close()
