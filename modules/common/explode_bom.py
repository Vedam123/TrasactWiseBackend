from flask import Blueprint, jsonify, request
from modules.security.permission_required import permission_required  # Import the decorator
from config import READ_ACCESS_TYPE  # Import READ_ACCESS_TYPE
from modules.security.routines.get_user_and_db_details import get_user_and_db_details	
from modules.utilities.logger import logger  # Import the logger module


explode_bom_api = Blueprint('explode_bom_api', __name__)

def explode_bom(mycursor, model_item, revision, required_quantity):

    results = []
    queue = [(model_item, revision, 1)]
    while queue:
        current_item, current_revision, current_level = queue.pop(0)
       ## print("Round ",current_item,current_level)
        query = f"""
            SELECT ComponentItem, Quantity, uom,level
            FROM com.bom
            WHERE ModelItem = {current_item} AND Revision = '{current_revision}'
        """
        mycursor.execute(query)
        result = mycursor.fetchall()
        
        if result:
            for row in result:
                sub_component_item, quantity, uom, level = row
                fetched_qty = quantity
                quantity = float(quantity) * required_quantity
                results.append({
                    'Item': sub_component_item,
                    "Quantity": fetched_qty,
                    "Model": current_item,
                    'Required Qty for Model': quantity,
                    'UOM': uom,
                    'Level': level
                })
            queue.append((sub_component_item, current_revision, current_level + 1))

    return results

@explode_bom_api.route('/explode_bom', methods=['GET'])
@permission_required(READ_ACCESS_TYPE ,  __file__)  # Pass READ_ACCESS_TYPE as an argument
def explode_bom_data():
           	
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
    logger.debug(f"{appuser} --> {__name__}: Entered in the explode BOM data function")

    try:
        model_item = request.args.get('model_item')
        revision = "A"
        required_quantity = float(request.args.get('required_quantity'))
        mycursor = mydb.cursor()

        check_query = f"SELECT COUNT(*) FROM com.bom WHERE ModelItem = {model_item} AND Revision = '{revision}'"
        mycursor.execute(check_query)
        count = mycursor.fetchone()[0]
        logger.debug(f"{appuser} --> {__name__}: Count {check_query}")
        if count == 0:
            mycursor.close()
            logger.debug(f"{appuser} --> {__name__}: No BOM for this item and revision {model_item}, {revision}")
            return jsonify({'message': 'No BOM defined for this item and '})
        
        logger.debug(f"{appuser} --> {__name__}: No BOM for this item and revision {model_item}, {revision}")
        exploded_bom = explode_bom(mycursor, model_item, revision, required_quantity)
 
        mycursor.close()
        mydb.close()
        logger.debug(f"{appuser} --> {__name__}: Base URL {request.url_root} ")

        return jsonify({'exploded_bom': exploded_bom})

    except Exception as e:
        return jsonify({'error': str(e)})
