from flask import jsonify, request, Blueprint
from modules.admin.databases.mydb import get_database_connection
import requests
from collections import OrderedDict
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger  # Import the logger module

process_exploded_bom_api = Blueprint('process_exploded_bom_api', __name__)

# Define a helper function for getting the item code
def get_item_code_by_id(item_id,USER_ID,MODULE_NAME):
    mydb = get_database_connection(USER_ID,MODULE_NAME)
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
    mydb.close()
    return item_code


def get_item_id_by_code(item_code,USER_ID,MODULE_NAME):
    # Assuming you have a database connection here
    mydb = get_database_connection(USER_ID,MODULE_NAME)
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
    mydb.close()

    return item_id


def get_item_details_by_id(item_id,USER_ID,MODULE_NAME):
    item_code = ''

    # Assuming you have a database connection here
    mydb = get_database_connection(USER_ID,MODULE_NAME)
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
    mydb.close()

    return item_code

def get_item_bom_id(item_id,USER_ID,MODULE_NAME):

    # Assuming you have a database connection here
    mydb = get_database_connection(USER_ID,MODULE_NAME)
    mycursor = mydb.cursor()

    query = f"SELECT COUNT(*) FROM com.bom WHERE ModelItem = {item_id}"
    mycursor.execute(query)
    count = mycursor.fetchone()[0]
    if count == 0:
        mycursor.close()
        print("No BOM for this item", item_id)
        return jsonify({'message': 'No BOM defined for this item'})
    mycursor.close()
    mydb.close()

    return item_id


def get_uom_details_by_id(uom_id,USER_ID,MODULE_NAME):
    uom_name= ''

    # Assuming you have a database connection here
    mydb = get_database_connection(USER_ID,MODULE_NAME)
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
    mydb.close()

    return uom_name

@process_exploded_bom_api.route('/process_exploded_bom', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def process_exploded_bom():
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
    logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered in the explode BOM data function")

    try:
        model_item_code = request.args.get('item_code')
        required_quantity = float(request.args.get('required_quantity'))

        # Log the inputs
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Model Item Code: {model_item_code}, Required Quantity: {required_quantity}")

        model_item_id = get_item_id_by_code(model_item_code,USER_ID,MODULE_NAME)

        if model_item_id is None:
            # Log an error message
            logger.error(f"{USER_ID} --> {MODULE_NAME}: The Model item is not present in Items table. Model Item Code: {model_item_code}")
            return jsonify({'error': 'The Model item is not present in Items table.'})

        bom_id = get_item_bom_id(model_item_id,USER_ID,MODULE_NAME)

        if model_item_id != bom_id:
            # Log an error message
            logger.error(f"{USER_ID} --> {MODULE_NAME}: The Model item is not present in BOM table. Model Item ID: {model_item_id}")
            return jsonify({'error': 'The Model item is not present in BOM table.'})

        # Construct the URL for explode_bom API
        explode_bom_url = f'{request.url_root}explode_bom?model_item={model_item_id}&required_quantity={required_quantity}'

        # Log the constructed URL
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Constructed explode_bom URL: {explode_bom_url}")

        # Use the requests library to send a GET request
        response = requests.get(explode_bom_url, headers=request.headers)

        if response.status_code != 200:
            # Log an error message
            logger.error(f"{USER_ID} --> {MODULE_NAME}: Failed to get data from explode_bom API. Status Code: {response.status_code}")
            return jsonify({'error': 'Failed to get data from explode_bom API.'})

        exploded_bom_data = response.json().get('exploded_bom', [])

        # Log successful completion
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Successfully retrieved exploded BOM data. Model Item Code: {model_item_code}")


        item_ids = set()
        uom_ids = set()

        for item in exploded_bom_data:
            item_ids.add(item['Item'])
            uom_ids.add(item['UOM'])

        # item_details = get_item_details(item_ids)
        # uom_details = get_uom_details(uom_ids)

        processed_data = []

        for item in exploded_bom_data:
            item_id = item['Item']
            fetched_qty = item['Quantity']
            model_item = item['Model']
            required_qty_for_model = item['Required Qty for Model']
            uom_id = item['UOM']
            level = item['Level']

            item_code = get_item_details_by_id(item_id,USER_ID,MODULE_NAME)
            uom_name = get_uom_details_by_id(uom_id,USER_ID,MODULE_NAME)

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

        return jsonify({'processed_data': ordered_processed_data})

    except Exception as e:
        return jsonify({'error': str(e)})

