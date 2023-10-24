from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required  # Import the decorator
from config import READ_ACCESS_TYPE  # Import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
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
    token_results = ""
    USER_ID = ""
    MODULE_NAME = __name__
    if authorization_header:
        token_results = get_user_from_token(authorization_header)

    if token_results:
        USER_ID = token_results["username"]
        token_results = get_user_from_token(request.headers.get('Authorization')) if request.headers.get('Authorization') else None
        
    # Log entry point
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the create partner data function")


    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the explode BOM data function")
    try:
        model_item = request.args.get('model_item')
        revision = "A"
        required_quantity = float(request.args.get('required_quantity'))
        mydb = get_database_connection(USER_ID, MODULE_NAME)
        mycursor = mydb.cursor()

        check_query = f"SELECT COUNT(*) FROM com.bom WHERE ModelItem = {model_item} AND Revision = '{revision}'"
        mycursor.execute(check_query)
        count = mycursor.fetchone()[0]
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Count {check_query}")
        if count == 0:
            mycursor.close()
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: No BOM for this item and revision {model_item}, {revision}")
            return jsonify({'message': 'No BOM defined for this item and '})
        
        print("Yes BOM for this item and revision", model_item, revision, required_quantity)
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: No BOM for this item and revision {model_item}, {revision}")
        exploded_bom = explode_bom(mycursor, model_item, revision, required_quantity)
        print("After iterative call")

        mycursor.close()
        mydb.close()
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Base URL {request.url_root} ")

        return jsonify({'exploded_bom': exploded_bom})

    except Exception as e:
        return jsonify({'error': str(e)})
