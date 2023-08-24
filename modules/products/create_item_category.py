from flask import Blueprint, jsonify, request
from modules.admin.databases.mydb import get_database_connection
import base64

create_item_category_api = Blueprint('create_item_category_api', __name__)

@create_item_category_api.route('/create_item_category', methods=['POST'])
def create_item_category():
    mydb = get_database_connection()

    print("Before JSON parsing the incoming requests")
    
    # Get the data from the request's JSON payload
    if request.content_type == 'application/json':
        data = request.get_json()
    else:
        data = request.form
    category_name = data.get('category_name')
    description = data.get('description')
    is_active = data.get('is_active')
    tax_information = data.get('tax_information')
    default_uom = data.get('default_uom')
    # image is no longer included in the request JSON
    image = request.files['image'] if 'image' in request.files else None
    image_data = image.read() if image else None

    print("Got parsed the incoming requests")

    # Validate the required fields
    if not category_name or not description or not is_active or not tax_information or not default_uom:
        return jsonify({'message': 'category_name, description, is_active, tax_information, and default_uom are required fields.'}), 400

    # Insert new item category into the database
    query = "INSERT INTO com.itemcategory (category_name, description, is_active, tax_information, default_uom, image) VALUES (%s, %s, %s, %s, %s, %s)"
    values = (category_name, description, is_active, tax_information, default_uom, image_data)

    mycursor = mydb.cursor()
    try:
        mycursor.execute(query, values)
        mydb.commit()
        category_id = mycursor.lastrowid
        mycursor.close()
        mydb.close()
        # Return the newly created item category as JSON response
        return jsonify({'category_id': category_id, 'category_name': category_name, 'description': description, 'is_active': is_active, 'tax_information': tax_information, 'default_uom': default_uom, 'image': image_data}), 201

    except Exception as e:
        mycursor.close()
        mydb.close()
        return jsonify({'message': 'Failed to create item category.', 'error': str(e)}), 500
