from flask import Blueprint, jsonify
from modules.admin.databases.mydb import get_database_connection

get_designations_data_api = Blueprint('get_designations_data_api', __name__)

@get_designations_data_api.route('/designations/get_designations_data', methods=['GET'])
def get_designations_data():
    mydb = get_database_connection()
    mycursor = mydb.cursor()
    mycursor.execute("SELECT * FROM com.designations")
    result = mycursor.fetchall()
    designations = []

    for row in result:
        designation_id, designation_name, description, salary_range, responsibilities, qualifications, created_at, updated_at = row

        designations.append({
            'designation_id': designation_id,
            'designation_name': designation_name,
            'description': description,
            'salary_range': salary_range,
            'responsibilities': responsibilities,
            'qualifications': qualifications,
            'created_at': created_at,
            'updated_at': updated_at
        })
    # Close the cursor and connection
    mycursor.close()
    mydb.close()
    
    return jsonify(designations)
