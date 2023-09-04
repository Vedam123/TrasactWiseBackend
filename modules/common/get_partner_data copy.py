from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection

get_partner_data_api = Blueprint('get_partner_data_api', __name__)

@get_partner_data_api.route('/get_partner_data', methods=['GET'])
def get_partner_data():
    mydb = get_database_connection()

    partner_id = request.args.get('partnerid')
    partner_name = request.args.get('partnername')
    print(request)
    print(partner_id,partner_name)

    try:
        mycursor = mydb.cursor()

        if partner_id is not None:
            query = "SELECT * FROM com.businesspartner WHERE partnerid = %s"
            print(query)
            mycursor.execute(query, (partner_id,))
        elif partner_name is not None:
            query = "SELECT * FROM com.businesspartner WHERE partnername = %s"
            print(query)
            mycursor.execute(query, (partner_name,))
        else:
            query = "SELECT * FROM com.businesspartner"
            mycursor.execute(query)

        partner_data = mycursor.fetchall()
        partner_list = []
        for partner in partner_data:
            partner_dict = {
                'partnerid': partner[0],
                'partnertype': partner[1],
                'partnername': partner[2],
                'contactperson': partner[3],
                'email': partner[4],
                'phone': partner[5],
                'address': partner[6],
                'city': partner[7],
                'state': partner[8],
                'postalcode': partner[9],
                'country': partner[10],
                'taxid': partner[11],
                'registrationnumber': partner[12],
                'additionalinfo': partner[13],
                'currencycode': partner[14],
                'status': partner[15]
                # Exclude 'customerimage' as it's not included in the response
            }
            partner_list.append(partner_dict)

        mycursor.close()
        mydb.close()

        return jsonify(partner_list)
    except Exception as e:
        mydb.close()
        print("Error fetching partner data:", str(e))
        return jsonify({'error': str(e)}), 500
