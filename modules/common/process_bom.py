from flask import jsonify, request, Blueprint
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
import requests
from collections import OrderedDict
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.utilities.logger import logger  # Import the logger module
from modules.common.routines.explode_model_bom import get_exploded_bom_data

process_exploded_bom_api = Blueprint('process_exploded_bom_api', __name__)

# Define a helper function for getting the item code
def get_item_code_by_id(item_id,mydb,__name__):
    mycursor = mydb.cursor()
    query = f"""
        SELECT item_code
        FROM com.items
        WHERE item_id = {item_id}
    """
    mycursor.execute(query)
    result = mycursor.fetchone()
    item_code = result[0] if result else None
    mycursor.close()
    return item_code


def get_item_id_by_code(item_code,mydb,__name__):
    # Assuming you have a database connection here
    mycursor = mydb.cursor()

    query = f"""
        SELECT item_id
        FROM com.items
        WHERE item_code = '{item_code}'
    """
    mycursor.execute(query)
    result = mycursor.fetchone()

    if result:
        item_id = result[0]
    else:
        item_id = None

    mycursor.close()

    return item_id


def get_item_details_by_id(item_id,mydb,__name__):
    item_code = ''

    mycursor = mydb.cursor()

    query = f"""
        SELECT item_code
        FROM com.items
        WHERE item_id = {item_id}
    """
    mycursor.execute(query)
    result = mycursor.fetchone()
    
    if result:
        item_code = result[0]
    else:
        item_code = None

    mycursor.close()

    return item_code

def get_item_bom_id(item_id,mydb,__name__):

    mycursor = mydb.cursor()

    query = f"SELECT COUNT(*) FROM com.bom WHERE ModelItem = {item_id}"
    mycursor.execute(query)
    count = mycursor.fetchone()[0]
    if count == 0:
        mycursor.close()
        print("No BOM for this item", item_id)
        return jsonify({'message': 'No BOM defined for this item'})
    mycursor.close()

    return item_id


def get_uom_details_by_id(uom_id,mydb,__name__):
    uom_name= ''
    mycursor = mydb.cursor()

    query = f"""
        SELECT uom_name
        FROM com.uom
        WHERE uom_id = {uom_id}
    """
    mycursor.execute(query)
    result = mycursor.fetchone()

    if result:
        uom_name = result[0]
    else:
        uom_name = None

    mycursor.close()

    return uom_name

@process_exploded_bom_api.route('/process_exploded_bom', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def process_exploded_bom():
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
    # Log entry point
    logger.debug(f"{appuser} --> {__name__}: Entered in the explode BOM data function")

    try:
        model_item_code = request.args.get('item_code')
        required_quantity = float(request.args.get('required_quantity'))

        # Log the inputs
        logger.debug(f"{appuser} --> {__name__}: Model Item Code: {model_item_code}, Required Quantity: {required_quantity}")

        model_item_id = get_item_id_by_code(model_item_code,mydb,__name__)
        print("Model item id",model_item_id)

        if model_item_id is None:
            # Log an error message
            logger.error(f"{appuser} --> {__name__}: The Model item is not present in Items table. Model Item Code: {model_item_code}")
            return jsonify({'error': 'The Model item is not present in Items table.'})
        
        bom_id = get_item_bom_id(model_item_id,mydb,__name__)

        print("Model Item bom id ",model_item_id,bom_id)



        if model_item_id != bom_id:
            # Log an error message
            logger.error(f"{appuser} --> {__name__}: The Model item is not present in BOM table. Model Item ID: {model_item_id}")
            return jsonify({'error': 'The Model item is not present in BOM table.'})


        response = get_exploded_bom_data(model_item_id,required_quantity,mydb, appuser,__name__)
        
        logger.error(f"{appuser} --> {__name__}: Responses received from the get_exploded_bom_data function for the Model item: {model_item_id}")

       
        logger.error(f"{appuser} --> {__name__}: Response formatation : {model_item_id}")

        exploded_bom_data = response.get('exploded_bom', [])

        logger.error(f"{appuser} --> {__name__}: Aftr Response formation  : {exploded_bom_data}")

        # Log successful completion
        logger.debug(f"{appuser} --> {__name__}: Successfully retrieved exploded BOM data. Model Item Code: {model_item_code}")


        item_ids = set()
        uom_ids = set()

        for item in exploded_bom_data:
            item_ids.add(item['Item'])
            uom_ids.add(item['UOM'])

        logger.error(f"{appuser} --> {__name__}: For Loop1 executed for  : {exploded_bom_data}")

        processed_data = []

        for item in exploded_bom_data:
            item_id = item['Item']
            fetched_qty = item['Quantity']
            model_item = item['Model']
            required_qty_for_model = item['Required Qty for Model']
            uom_id = item['UOM']
            level = item['Level']

            item_code = get_item_details_by_id(item_id,mydb,__name__)
            uom_name = get_uom_details_by_id(uom_id,mydb,__name__)

            processed_data.append({
                'ModelItemID': model_item_id,
                'ModelItemCode': model_item_code,
                'RequiredModelQty': required_quantity,
                'ComponentItemId': item_id,
                'ComponentItemCode': item_code,
                'ComponentLevelInBOM': level,
                'ComponetDefaultQty': fetched_qty,
                'ComponentRequiredQty': required_qty_for_model,
                'ComponentUOMID': uom_id,
                'ComponentUOMName': uom_name
            })

        desired_order = [
            'ModelItemID', 'ModelItemCode', 'RequiredModelQty',
            'ComponentItemId', 'ComponentItemCode', 'ComponentLevelInBOM',
            'ComponetDefaultQty', 'ComponentRequiredQty', 'ComponentUOMID',
            'ComponentUOMName'
        ]
        ordered_processed_data = [OrderedDict(
            (key, item[key]) for key in desired_order) for item in processed_data]
        
        logger.error(f"{appuser} --> {__name__}: AFter For Loop2 executed and Before return : {exploded_bom_data}")

        return jsonify({'processed_data': ordered_processed_data})

    except Exception as e:
        return jsonify({'error': str(e)})

