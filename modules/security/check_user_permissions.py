# permissions.py

from modules.admin.databases.mydb import get_database_connection
from config import APPLICATION_CREDENTIALS

def check_user_permissions(current_user_id, usernamex, module, access_type):
    try:       
        # Check if usernamex is present in APPLICATION_CREDENTIALS
        current_user_id = str(current_user_id).strip()
        user_info = next((user for user in APPLICATION_CREDENTIALS if user["userid"] == current_user_id), None)
        
        if user_info:
            return True
        print("User is not in super user list")

        db_connection = get_database_connection()
        permission_cursor = db_connection.cursor()
        user_id = ""
        print("User name -- to check in db ", usernamex)
        permission_cursor.execute("SELECT id FROM adm.users WHERE username like %s", (usernamex,))
        result = permission_cursor.fetchone()
        print(result)
        if result:
            user_id = result[0]
        else:
            return False
        if int(current_user_id) != int(user_id):
            print("user id don't match")
            return False
        
        permission_cursor.execute(
            "SELECT 1 FROM adm.user_module_permissions WHERE module = %s LIMIT 1",
            (module,)
            )

        module_exists = bool(permission_cursor.fetchone())

        if not module_exists:
            print(f"Module '{module}' not found in user_module_permissions")
            return False

        permission_cursor.execute(
            f"SELECT {access_type}_permission FROM adm.user_module_permissions "
            "WHERE user_id = %s AND module = %s",
            (user_id, module)
        )
        permission = permission_cursor.fetchone()
        if not permission:
            return False

        permission_cursor.close()
        db_connection.close()
        return bool(permission[0])

    except Exception as e:
        print("Error checking permissions:", str(e))
        return False
