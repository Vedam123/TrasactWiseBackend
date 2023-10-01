from flask import jsonify, request, Blueprint
from modules.admin.databases.mydb import get_database_connection
import requests
from collections import OrderedDict
from modules.security.permission_required import permission_required  # Import the decorator
from config import READ_ACCESS_TYPE  # Import READ_ACCESS_TYPE

process_exploded_bom_api = Blueprint('process_exploded_bom_api', __name__)

def get_item_id_by_code(item_code):
    # Assuming you have a database connection here
    mydb = get_database_connection()
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


def get_item_details_by_id(item_id):
    item_code = ''

    # Assuming you have a database connection here
    mydb = get_database_connection()
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

def get_item_bom_id(item_id):

    # Assuming you have a database connection here
    mydb = get_database_connection()
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


def get_uom_details_by_id(uom_id):
    uom_name= ''

    # Assuming you have a database connection here
    mydb = get_database_connection()
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
@permission_required(READ_ACCESS_TYPE ,  __file__)  # Pass READ_ACCESS_TYPE as an argument
def process_exploded_bom():
    try:
        model_item_code = request.args.get('item_code')
        required_quantity = float(request.args.get('required_quantity'))
        print("Item Code and Required Qty ", model_item_code, required_quantity)
        model_item_id = get_item_id_by_code(model_item_code)
        print(" Item ID , Item Code and Required Qty ",
              model_item_id, model_item_code, required_quantity)

        if model_item_id is None:
            return jsonify({'error': 'The Model item is not present in Items table.'})

        
        bom_id = get_item_bom_id(model_item_id)
        if model_item_id != bom_id:
            return jsonify({'error': 'The Model item is not present in BOM table.'})

        # Construct the URL for explode_bom API
        explode_bom_url = f'{request.url_root}explode_bom?model_item={model_item_id}&required_quantity={required_quantity}'
        print("Exploded URL ", explode_bom_url)

        # Use the requests library to send a GET request
        response = requests.get(explode_bom_url)
        print("Response from Exploded BOM url ", response)

        exploded_bom_data = response.json().get('exploded_bom', [])
        print("Now exploded bom data based on response JSON get OUTPUT ",
              exploded_bom_data)

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

            item_code = get_item_details_by_id(item_id)
            uom_name = get_uom_details_by_id(uom_id)

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

