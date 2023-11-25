from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from modules.utilities.logger import logger

list_bom_api = Blueprint('list_bom_api', __name__)

@list_bom_api.route('/list_bom', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def list_bom_data():
    MODULE_NAME = __name__

    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Entered the 'get BOM data' function")

        mydb = get_database_connection(USER_ID, MODULE_NAME)
        mycursor = mydb.cursor()

        # Check if 'model_item' parameter is in the request.args
        model_item = request.args.get('model_item')
        print("The requested model item -->",model_item)
        if model_item:
            mycursor.execute("""
                SELECT ID, ModelItem, ParentItem, ComponentItem, Quantity, uom, ScrapPercentage,
                    RoutingOperation, Revision, EffectiveDate, EndDate, NotesComments, Level,
                    created_at, updated_at, created_by, updated_by
                FROM com.bom
                WHERE ModelItem = %s
            """, (model_item,))
        else:
            mycursor.execute("""
                SELECT ID, ModelItem, ParentItem, ComponentItem, Quantity, uom, ScrapPercentage,
                    RoutingOperation, Revision, EffectiveDate, EndDate, NotesComments, Level,
                    created_at, updated_at, created_by, updated_by
                FROM com.bom
            """)

        result = mycursor.fetchall()
        bom_list = []

        # Get column names and create a mapping
        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        for row in result:
            bom_dict = {}

            bom_dict['ComponentItem'] = row[column_indices['ComponentItem']]
            bom_dict['EffectiveDate'] = str(row[column_indices['EffectiveDate']])
            bom_dict['EndDate'] = str(row[column_indices['EndDate']])
            bom_dict['ID'] = row[column_indices['ID']]
            bom_dict['Level'] = row[column_indices['Level']]
            bom_dict['ModelItem'] = row[column_indices['ModelItem']]
            bom_dict['NotesComments'] = row[column_indices['NotesComments']]
            bom_dict['ParentItem'] = row[column_indices['ParentItem']]
            bom_dict['Quantity'] = str(row[column_indices['Quantity']])
            bom_dict['Revision'] = row[column_indices['Revision']]
            bom_dict['RoutingOperation'] = row[column_indices['RoutingOperation']]
            bom_dict['ScrapPercentage'] = str(row[column_indices['ScrapPercentage']])
            bom_dict['created_at'] = str(row[column_indices['created_at']])
            bom_dict['created_by'] = row[column_indices['created_by']]
            bom_dict['uom'] = row[column_indices['uom']]
            bom_dict['updated_at'] = str(row[column_indices['updated_at']])
            bom_dict['updated_by'] = row[column_indices['updated_by']]

            bom_dict['ComponentItem_code'], bom_dict['ComponentItem_name'] = get_item_info(row[column_indices['ComponentItem']], mycursor)
            bom_dict['ModelItem_code'], bom_dict['ModelItem_name'] = get_item_info(row[column_indices['ModelItem']], mycursor)
            bom_dict['ParentItem_code'], bom_dict['ParentItem_name'] = get_item_info(row[column_indices['ParentItem']], mycursor)
            bom_dict['uom_abbr'], bom_dict['uom_des'] = get_uom_info(row[column_indices['uom']], mycursor)

            bom_list.append(bom_dict)

        # Close the cursor and connection
        mycursor.close()
        mydb.close()

        # Log successful completion
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Successfully retrieved BOM data")

        return jsonify({'bom_list': bom_list})

    except Exception as e:
        # Log error and return Internal Server Error response
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error retrieving BOM data - {str(e)}")
        import traceback
        traceback.print_exc()  # Add this line to print the full stack trace
        return jsonify({'error': 'Internal Server Error'}), 500


def get_item_info(item_id, cursor):
    try:
        cursor.execute("SELECT item_code, item_name FROM com.items WHERE item_id = %s", (item_id,))
        item_info = cursor.fetchone()
        return item_info[0], item_info[1] if item_info else (None, None)
    except Exception as e:
        # Log error and return None
        logger.error(f"Error fetching item information - {str(e)}")
        return None, None

def get_uom_info(uom_id, cursor):
    try:
        cursor.execute("SELECT abbreviation, uom_name FROM com.uom WHERE uom_id = %s", (uom_id,))
        uom_info = cursor.fetchone()
        return uom_info[0], uom_info[1] if uom_info else (None, None)
    except Exception as e:
        # Log error and return None
        logger.error(f"Error fetching UOM information - {str(e)}")
        return None, None
