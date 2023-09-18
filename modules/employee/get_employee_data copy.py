from flask import Blueprint, jsonify,request
import base64
from modules.admin.databases.mydb import get_database_connection
from flask_jwt_extended import decode_token
from config import READ_ACCESS_TYPE  # Import the ACCESS_TYPE constant

get_employee_data_api = Blueprint('get_employee_data_api', __name__)

@get_employee_data_api.route('/employee/get_employee_data', methods=['GET'])
def check_permission(current_user_id, usernamex, module, access_type):
    try:
        print(current_user_id, usernamex, module, access_type)
        db_connection = get_database_connection()
        permission_cursor = db_connection.cursor()
        user_id = ""
        permission_cursor.execute("SELECT id FROM adm.users WHERE username = %s", (usernamex,))
        result = permission_cursor.fetchone()
        if result:
            user_id = result[0]  # Access the first (and only) element of the tuple
        else:
            print("No user found in the user table")
            return False  # User not found

        print(user_id)

        if int(current_user_id) != int(user_id):
            print("user id don't match")
            return False

        # Step 2: Check permissions in adm.user_module_permissions
        permission_cursor.execute(
            f"SELECT {access_type}_permission FROM adm.user_module_permissions "
            "WHERE user_id = %s AND module = %s",
            (user_id, module)
        )

        permission = permission_cursor.fetchone()

        print("Found Permission-->",permission)

        if not permission:
            print("NO PERMISSION IN PERMISSION MODULE")
            return False  # No permission record found

        print("Now returning the permission from db")

        permission_cursor.close()
        db_connection.close()

        return bool(permission[0])  # Access the first (and only) element of the tuple

    except Exception as e:
        print("Error checking permissions:", str(e))
        return False


def get_employee_data():
    token = request.headers.get('Authorization')
    token_data = ""
    token_user = ""
    module = "employee"
    print("Received Token --> ",token)
    if token:
        token = token.replace('Bearer ', '')  # Remove 'Bearer ' prefix
        try:
            token_data = decode_token(token)
            print("Decoded Token Data -- full--> ",token_data)
            print("Decoded Token Data:", token_data.get('sub'))
            token_user = token_data.get('sub')
        except Exception as e:
            print("Error decoding token:", str(e))
            
    current_user_id = request.headers.get('userid')
    print("Current User id ",current_user_id)
    ##print("Current Token ",current_token)

    mydb = get_database_connection()

    has_permission = check_permission(current_user_id, token_user, module, READ_ACCESS_TYPE)

    if not has_permission:
        print("Check permission returned False")
        return jsonify({'message': 'Permission denied'}), 403

    mycursor = mydb.cursor()
    mycursor.execute("SELECT * FROM com.employee")
    result = mycursor.fetchall()
    employees = []
    print("Employee Array defined")
    for row in result:
        empid, name, manager, supervisor, pic, salary, role, dob, doj = row

        # Convert pic to base64 if it is of BLOB type, otherwise leave it as is
        if isinstance(pic, bytes):
            pic = base64.b64encode(pic).decode('utf-8')

        employees.append({
            'empid': empid,
            'name': name,
            'manager': manager,
            'supervisor': supervisor,
            'pic': pic,
            'salary': str(salary),
            'role': role,
            'dob': str(dob),
            'doj': str(doj)
        })
    # Close the cursor and connection
    mycursor.close()
    mydb.close()
    print("Employee Data has been retrieved and appended to the array")
    return jsonify(employees)
