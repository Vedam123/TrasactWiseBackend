from flask import Blueprint, jsonify
from modules.admin.databases.mydb import get_database_connection

list_exchange_rates_api = Blueprint('list_exchange_rates_api', __name__)

@list_exchange_rates_api.route('/list_taxcodes', methods=['GET'])
def list_tax_data():
    mydb = get_database_connection()
    mycursor = mydb.cursor()
    mycursor.execute("SELECT * FROM com.tax")
    result = mycursor.fetchall()
    taxes = []

    for row in result:
        tax_id, tax_code, tax_description, tax_rate, tax_type, tax_authority, tax_jurisdiction, tax_applicability, effective_date, exemption, reporting_codes, integration_info, status, notes, created_at, updated_at = row
        taxes.append({
            'tax_id': tax_id,
            'tax_code': tax_code,
            'tax_description': tax_description,
            'tax_rate': str(tax_rate),
            'tax_type': tax_type,
            'tax_authority': tax_authority,
            'tax_jurisdiction': tax_jurisdiction,
            'tax_applicability': tax_applicability,
            'effective_date': str(effective_date),
            'exemption': exemption,
            'reporting_codes': reporting_codes,
            'integration_info': integration_info,
            'status': status,
            'notes': notes,
            'created_at': str(created_at),
            'updated_at': str(updated_at)
        })
    # Close the cursor and connection
    mycursor.close()
    mydb.close()
    return jsonify({'taxes': taxes})
