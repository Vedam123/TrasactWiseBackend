from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
from modules.security.permission_required import permission_required  # Import the decorator
from config import READ_ACCESS_TYPE  # Import READ_ACCESS_TYPE

conversion_api = Blueprint('conversion_api', __name__)

def fetch_conversion_factor(mycursor, target_uom):
    try:
        query = "SELECT conversion_factor FROM com.uom WHERE abbreviation = %s"
        print("Executing query:", query)
        
        mycursor.execute(query, (target_uom,))
        row = mycursor.fetchone()
        print("Fetched row:", row)
        
        if row:
            return row[0]
        else:
            print("No conversion factor found.")
            return None
        
    except Exception as e:
        print("Error fetching conversion factor:", e)
        return None

def convert_quantity(source_quantity, source_uom, target_uom, mycursor):
    source_conversion_factor = fetch_conversion_factor(mycursor, source_uom)
    target_conversion_factor = fetch_conversion_factor(mycursor, target_uom)
    
    if source_conversion_factor is None or target_conversion_factor is None:
        return None
        
    converted_quantity = (source_quantity * source_conversion_factor) / target_conversion_factor
    return converted_quantity

@conversion_api.route('/uom_conversion', methods=['GET'])
@permission_required(READ_ACCESS_TYPE ,  __file__)  # Pass READ_ACCESS_TYPE as an argument
def convert_quantity_endpoint():
    try:
        source_uom = request.args.get('source_uom')
        source_quantity = float(request.args.get('source_quantity'))
        target_uom = request.args.get('target_uom')

        print(source_uom, source_quantity, target_uom)
        
        mydb = get_database_connection()
        mycursor = mydb.cursor()

        converted_quantity = convert_quantity(source_quantity, source_uom, target_uom, mycursor)
        if converted_quantity is None:
            mycursor.close()
            mydb.close()
            return jsonify({'message': 'Conversion not possible'})

        mycursor.close()
        mydb.close()

        return jsonify({'target_uom': target_uom, 'converted_quantity': converted_quantity})

    except Exception as e:
        return jsonify({'error': str(e)})
