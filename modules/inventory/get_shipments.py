from flask import jsonify, request, Blueprint
from modules.security.permission_required import permission_required
from modules.security.routines.get_user_and_db_details import get_user_and_db_details
from config import READ_ACCESS_TYPE
from modules.utilities.logger import logger

shipments_api = Blueprint('shipments_api', __name__)

@shipments_api.route('/shipments', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_shipments():
    try:
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

        logger.debug(f"{appuser} --> {__name__}: Entered the 'get shipments' function")

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

        logger.debug(f"{appuser} --> {__name__}: Successfully retrieved shipments data")

        return jsonify({'shipments_list': shipments_list})

    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Error retrieving shipments data - {str(e)}")
        return jsonify({'error': 'Internal Server Error'}), 500