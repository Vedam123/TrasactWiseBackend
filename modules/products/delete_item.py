from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import DELETE_ACCESS_TYPE
from modules.utilities.logger import logger

delete_item_api = Blueprint('delete_item_api', __name__)

@delete_item_api.route('/delete_item', methods=['DELETE'])
@permission_required(DELETE_ACCESS_TYPE, __file__)
def delete_item():
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

    
    item_id = request.args.get('item_id')  # Fetch item_id from query parameter

    if not item_id:
        return jsonify({'message': 'item_id is required'}), 400

    logger.debug(f"{appuser} --> {__name__}: Entered the delete item function")

    mycursor = mydb.cursor()

    try:
        # Check if the item exists
        reference_query = "SELECT COUNT(*) FROM com.items WHERE item_id = %s"
        mycursor.execute(reference_query, (item_id,))
        referenced_count = mycursor.fetchone()[0]

        if referenced_count == 0:
            logger.warning(f"{appuser} --> {__name__}: Item {item_id} does not exist.")
            return jsonify({'message': f'Item {item_id} does not exist.'}), 404

        # Attempt to delete the item from com.items
        item_delete_query = "DELETE FROM com.items WHERE item_id = %s"
        mycursor.execute(item_delete_query, (item_id,))
        mydb.commit()

        # Check if the item was deleted (affected rows > 0)
        if mycursor.rowcount == 0:
            logger.warning(f"{appuser} --> {__name__}: Unable to delete item {item_id} due to foreign key constraint.")
            return jsonify({'message': f'Unable to delete item {item_id} due to foreign key constraint.'}), 400

        logger.info(f"{appuser} --> {__name__}: Successfully deleted item {item_id}")

        # Now delete from com.item_image_mapping
        mapping_delete_query = "DELETE FROM com.item_image_mapping WHERE item_id = %s"
        mycursor.execute(mapping_delete_query, (item_id,))
        mydb.commit()
        logger.info(f"{appuser} --> {__name__}: Deleted image mappings for item_id={item_id}")

        # Delete orphaned images from com.item_images
        image_delete_query = """
            DELETE ii FROM com.item_images ii
            LEFT JOIN com.item_image_mapping iim ON ii.image_id = iim.image_id
            WHERE iim.item_id IS NULL
        """
        mycursor.execute(image_delete_query)
        mydb.commit()
        logger.info(f"{appuser} --> {__name__}: Deleted orphaned item images for item_id={item_id}")

        mycursor.close()
        mydb.close()

        return jsonify({'message': f'Item {item_id} and its associated images were successfully deleted.'}), 200

    except Exception as e:
        mycursor.close()
        mydb.close()

        logger.error(f"{appuser} --> {__name__}: Error while deleting item {item_id}: {str(e)}")
        return jsonify({'message': f'Error while deleting item {item_id}.', 'error': str(e)}), 500
