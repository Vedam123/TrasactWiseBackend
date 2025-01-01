from config import APPLICATION_CREDENTIALS
from modules.utilities.logger import logger  # Import the logger module

def check_user_permissions(current_file_name, appuserid, appuser, module, access_type, connect_db):
    try:       
        # Check if appuser is present in APPLICATION_CREDENTIALS
        logger.debug(f"{appuser} --> {__name__}: appuserid '{appuserid}'")
        logger.debug(f"{appuser} --> {__name__}: appuser '{appuser}'")
        logger.debug(f"{appuser} --> {__name__}: module '{module}'")
        logger.debug(f"{appuser} --> {__name__}: access_type '{access_type}'") 

        if appuserid is None or appuserid == "":
            # Fetch user_info based on appuser
            user_info = next((user for user in APPLICATION_CREDENTIALS if user["username"] == appuser), None)
            
            if user_info:
                logger.debug(f"{appuser} --> {__name__}: User '{appuser}' found in Super user list.")
                return True

        appuserid = str(appuserid).strip()
        user_info = next((user for user in APPLICATION_CREDENTIALS if user["userid"] == appuserid), None)
        
        if user_info:
            logger.debug(f"{appuser} --> {__name__}: User '{appuserid}' is in Super user list.")
            return True

        logger.debug(f"{appuser} --> {__name__}: User '{appuser}' not found in Super user list.")

        # Get the cursor from the db connection
        permission_cursor = connect_db.cursor()

        user_id = ""
        logger.debug(f"{appuser} --> {__name__}: User name to check in db: {appuser}")

        permission_cursor.execute("SELECT id FROM adm.users WHERE username like %s", (appuser,))
        result = permission_cursor.fetchone()
        logger.debug(f"{appuser} --> {__name__}: {result}")
        if result:
            user_id = result[0]
        else:
            logger.debug(f"{appuser} --> {__name__}: User '{appuser}' not found in adm.users table")
            permission_cursor.close()
            return False
        
        permission_cursor.execute(
            "SELECT 1 FROM adm.user_module_permissions WHERE module = %s LIMIT 1",
            (module,)
        )
        
        module_exists = bool(permission_cursor.fetchone())
        logger.debug(f"{appuser} --> {__name__}: Seems user found in adm.users")

        if not module_exists:
            logger.debug(f"{appuser} --> {__name__}: Module '{module}' not found in user_module_permissions")
            permission_cursor.close()
            return False

        permission_cursor.execute(
            f"SELECT {access_type}_permission FROM adm.user_module_permissions "
            "WHERE user_id = %s AND module = %s",
            (user_id, module)
        )
        permission = permission_cursor.fetchone()
        if not permission:
            logger.debug(f"{appuser} --> {__name__}: No permission found for user '{appuser}' in module '{module}' with access type '{access_type}'")
            permission_cursor.close()
            return False

        permission_cursor.close()
        logger.debug(f"{appuser} --> {__name__}: Permission for user '{appuser}' in module '{module}' with access type '{access_type}' is granted")
        return bool(permission[0])

    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Error checking permissions: {str(e)}")
        return False
