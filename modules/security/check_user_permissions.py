from modules.admin.databases.mydb import get_database_connection
from config import APPLICATION_CREDENTIALS
from modules.utilities.logger import logger  # Import the logger module

def check_user_permissions(current_user_id, usernamex, module, access_type):
    try:       
        # Check if usernamex is present in APPLICATION_CREDENTIALS
        logger.debug(f"current_user_id '{current_user_id}'")
        logger.debug(f"usernamex '{usernamex}'")
        logger.debug(f"module '{module}'")
        logger.debug(f"access_type '{access_type}'")    

        if current_user_id is None or current_user_id == "":
            # Fetch user_info based on usernamex
            user_info = next((user for user in APPLICATION_CREDENTIALS if user["username"] == usernamex), None)
            
            if user_info:
                logger.debug(f"User '{usernamex}' found in Super user list.")
                return True

        # Continue with the rest of the function as before
        current_user_id = str(current_user_id).strip()
        user_info = next((user for user in APPLICATION_CREDENTIALS if user["userid"] == current_user_id), None)
        
        if user_info:
            logger.debug(f"User '{current_user_id}' is in Super user list super user list.")
            return True

        logger.debug(f"User '{usernamex}' not found in Super user list .")

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
