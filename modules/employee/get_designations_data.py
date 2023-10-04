from flask import Blueprint, jsonify
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required
from config import READ_ACCESS_TYPE

get_designations_data_api = Blueprint('get_designations_data_api', __name__)

@get_designations_data_api.route('/designations/get_designations_data', methods=['GET'])
@permission_required(READ_ACCESS_TYPE, __file__)
def get_designations_data():
    mydb = get_database_connection()
    mycursor = mydb.cursor()
    mycursor.execute("SELECT * FROM com.designations")
    result = mycursor.fetchall()
    designations = []

    # Get the column names from the cursor's description
    column_names = [desc[0] for desc in mycursor.description]

    for row in result:
        designation_dict = {}
        for i, value in enumerate(row):
            column_name = column_names[i]
            designation_dict[column_name] = value

        designations.append(designation_dict)

    # Close the cursor and connection
    mycursor.close()
    mydb.close()

    return jsonify(designations)
