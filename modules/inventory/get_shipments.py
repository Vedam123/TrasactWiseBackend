from flask import jsonify, request, Blueprint
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE
from modules.security.get_user_from_token import get_user_from_token
from flask_jwt_extended import decode_token
from modules.utilities.logger import logger

shipments_api = Blueprint('shipments_api', __name__)

@shipments_api.route('/shipments', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_shipments():
    try:
        authorization_header = request.headers.get('Authorization')
        token_results = get_user_from_token(authorization_header)

        if token_results:
            USER_ID = token_results["username"]
        else:
            USER_ID = ""

        logger.debug(f"{USER_ID} --> {__name__}: Entered the 'get shipments' function")

        mydb = get_database_connection(USER_ID, __name__)
        mycursor = mydb.cursor()

        query = """
            SELECT s.*, l.location_name, l.location_type, u.uom_name, u.abbreviation, i.item_code, i.item_name, s.status  -- Include new field
            FROM inv.shipments s
            JOIN inv.locations l ON s.staging_location_id = l.location_id
            JOIN com.uom u ON s.uom_id = u.uom_id
            JOIN com.items i ON s.item_id = i.item_id
        """

        mycursor.execute(query)

        result = mycursor.fetchall()
        shipments_list = []

        columns = [desc[0] for desc in mycursor.description]
        column_indices = {column: index for index, column in enumerate(columns)}

        for row in result:
            shipment_dict = {}

            for column in columns:
                shipment_dict[column] = row[column_indices[column]]

            shipments_list.append(shipment_dict)

        mycursor.close()
        mydb.close()

        logger.debug(f"{USER_ID} --> {__name__}: Successfully retrieved shipments data")

        return jsonify({'shipments_list': shipments_list})

    except Exception as e:
        logger.error(f"{USER_ID} --> {__name__}: Error retrieving shipments data - {str(e)}")
        return jsonify({'error': 'Internal Server Error'}), 500