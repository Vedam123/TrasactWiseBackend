# permissions.py

from modules.admin.databases.mydb import get_database_connection
from config import APPLICATION_CREDENTIALS

def check_user_permissions(current_user_id, usernamex, module, access_type):
    try:       
        print("Enterd in check permssions function file ",usernamex)
        # Check if usernamex is present in APPLICATION_CREDENTIALS
        current_user_id = str(current_user_id).strip()
        user_info = next((user for user in APPLICATION_CREDENTIALS if user["userid"] == current_user_id), None)

        print("User info ",user_info)
        
        if user_info:
            print("User found in APPLICATION_CREDENTIALS")
            return True
        print("User is not in super user list")

        db_connection = get_database_connection()
        permission_cursor = db_connection.cursor()
        user_id = ""
        permission_cursor.execute("SELECT id FROM adm.users WHERE username = %s", (usernamex,))
        result = permission_cursor.fetchone()
        if result:
            user_id = result[0]
        else:
            print("No user found in the user table")
            return False

        if int(current_user_id) != int(user_id):
            print("user id don't match")
            return False

        permission_cursor.execute(
            f"SELECT {access_type}_permission FROM adm.user_module_permissions "
            "WHERE user_id = %s AND module = %s",
            (user_id, module)
        )

        permission = permission_cursor.fetchone()

        if not permission:
            print("NO PERMISSION IN PERMISSION MODULE")
            return False

        permission_cursor.close()
        db_connection.close()

        return bool(permission[0])

    except Exception as e:
        print("Error checking permissions:", str(e))
        return False
