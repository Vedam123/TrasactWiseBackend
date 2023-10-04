from flask import Blueprint, jsonify, request
import base64
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE

get_partner_data_api = Blueprint('get_partner_data_api', __name__)

@get_partner_data_api.route('/get_partner_data', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_partner_data():
    mydb = get_database_connection()

    partner_id = request.args.get('partnerid')
    partner_name = request.args.get('partnername')

    try:
        mycursor = mydb.cursor()

        if partner_id is not None:
            query = "SELECT * FROM com.businesspartner WHERE partnerid = %s"
            mycursor.execute(query, (partner_id,))
        elif partner_name is not None:
            query = "SELECT * FROM com.businesspartner WHERE partnername LIKE %s"
            mycursor.execute(query, ('%' + partner_name + '%',))
        else:
            query = "SELECT * FROM com.businesspartner"
            mycursor.execute(query)

        partner_data = mycursor.fetchall()
        partner_list = []

        # Get the column names from the cursor's description
        column_names = [desc[0] for desc in mycursor.description]

        for partner in partner_data:
            partner_dict = {}
            for i, value in enumerate(partner):
                column_name = column_names[i]

                if column_name == 'customerimage' and isinstance(value, bytes):
                    try:
                        decoded_image = base64.b64encode(value).decode('utf-8')
                        partner_dict[column_name] = decoded_image
                    except Exception as e:
                        print("Error decoding image:", str(e))
                else:
                    partner_dict[column_name] = value

            partner_list.append(partner_dict)

        mycursor.close()
        mydb.close()

        return jsonify(partner_list)
    except Exception as e:
        mydb.close()
        print("Error fetching partner data:", str(e))
        return jsonify({'error': str(e)}), 500
