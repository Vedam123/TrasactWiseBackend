import logging
from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from config import DELETE_ACCESS_TYPE
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from modules.utilities.logger import logger

delete_item_category_api = Blueprint('delete_item_category_api', __name__)

@delete_item_category_api.route('/delete_item_category', methods=['DELETE'])
@permission_required(DELETE_ACCESS_TYPE, __file__)
def delete_item_category():
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
    category_id = request.args.get('category_id')  # Fetch category_id from query parameter

    if not category_id:
        return jsonify({'message': 'category_id is required'}), 400

    logger.debug(f"{appuser} --> {__name__}: Entered the delete category function")
    mycursor = mydb.cursor()

    try:
        # Check if the category_id is referenced in the `com.items` table
        reference_query = "SELECT COUNT(*) FROM com.items WHERE category_id = %s"
        mycursor.execute(reference_query, (category_id,))
        referenced_count = mycursor.fetchone()[0]

        if referenced_count > 0:
            logger.warning(f"{appuser} --> {__name__}: Cannot delete category {category_id} because it is referenced in {referenced_count} items.")
            return jsonify({'message': f'Cannot delete category {category_id} because it is referenced in {referenced_count} items.'}), 400

        # Delete from com.category_image_mapping
        mapping_delete_query = "DELETE FROM com.category_image_mapping WHERE category_id = %s"
        mycursor.execute(mapping_delete_query, (category_id,))
        mydb.commit()
        logger.info(f"{appuser} --> {__name__}: Deleted category image mappings for category_id={category_id}")

        # Delete from com.category_images (only orphaned images)
        image_delete_query = """
            DELETE ci FROM com.category_images ci
            LEFT JOIN com.category_image_mapping cim ON ci.image_id = cim.image_id
            WHERE cim.category_id IS NULL
        """
        mycursor.execute(image_delete_query)
        mydb.commit()
        logger.info(f"{appuser} --> {__name__}: Deleted orphaned category images for category_id={category_id}")

        # Delete from com.itemcategory
        category_delete_query = "DELETE FROM com.itemcategory WHERE category_id = %s"
        mycursor.execute(category_delete_query, (category_id,))
        mydb.commit()

        logger.info(f"{appuser} --> {__name__}: Successfully deleted category {category_id}")

        mycursor.close()
        mydb.close()

        return jsonify({'message': f'Category {category_id} and its associated images were successfully deleted.'}), 200

    except Exception as e:
        mycursor.close()
        mydb.close()

        logger.error(f"{appuser} --> {__name__}: Error while deleting category {category_id}: {str(e)}")
        return jsonify({'message': f'Error while deleting category {category_id}.', 'error': str(e)}), 500
