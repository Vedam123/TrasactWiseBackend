from modules.admin.databases.mydb import get_database_connection
from config import APPLICATION_CREDENTIALS
from modules.utilities.logger import logger  # Import the logger module

def check_user_permissions(current_user_id, usernamex, module, access_type):
    try:       
        # Check if usernamex is present in APPLICATION_CREDENTIALS
        current_user_id = str(current_user_id).strip()
        user_info = next((user for user in APPLICATION_CREDENTIALS if user["userid"] == current_user_id), None)
        
        if user_info:
            logger.debug(f"User '{current_user_id}' is in APPLICATION_CREDENTIALS super user list.")
            return True

        logger.debug("User is not in super user list")

        db_connection = get_database_connection(usernamex,module)
        permission_cursor = db_connection.cursor()
        user_id = ""
        logger.debug(f"User name -- to check in db: {usernamex}")
        permission_cursor.execute("SELECT id FROM adm.users WHERE username like %s", (usernamex,))
        result = permission_cursor.fetchone()
        logger.debug(result)
        if result:
            user_id = result[0]
        else:
            return False
        if int(current_user_id) != int(user_id):
            logger.debug("User id doesn't match")
            return False
        
        permission_cursor.execute(
            "SELECT 1 FROM adm.user_module_permissions WHERE module = %s LIMIT 1",
            (module,)
            )

        module_exists = bool(permission_cursor.fetchone())

        if not module_exists:
            logger.debug(f"Module '{module}' not found in user_module_permissions")
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
        logger.error("Error checking permissions: %s", str(e))
        return False
