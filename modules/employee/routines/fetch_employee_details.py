from modules.utilities.logger import logger  # Import your logger module

def fetch_employee_details(USER_ID, MODULE_NAME, mydb, user_id=None, username=None):
    """
    Fetch the empid and name from the employee table based on id or username or both from the users table.

    :param USER_ID: ID of the user making the request
    :param MODULE_NAME: Name of the module
    :param mydb: Database connection
    :param user_id: ID of the user (optional)
    :param username: Username of the user (optional)
    :return: Dictionary containing empid and name if found, otherwise None
    """
    try:
        mycursor = mydb.cursor(dictionary=True)
        logger.debug(f"Fetching employee details for User ID: {user_id} and Username: {username}")

        # Prepare the query based on input parameters
        if user_id and username:
            query = "SELECT e.empid, e.name FROM adm.users u JOIN com.employee e ON u.empid = e.empid WHERE u.id = %s AND u.username = %s"
            params = (user_id, username)
        elif user_id:
            query = "SELECT e.empid, e.name FROM adm.users u JOIN com.employee e ON u.empid = e.empid WHERE u.id = %s"
            params = (user_id,)
        elif username:
            query = "SELECT e.empid, e.name FROM adm.users u JOIN com.employee e ON u.empid = e.empid WHERE u.username = %s"
            params = (username,)
        else:
            error_message = "Fail: At least one of 'id' or 'username' must be provided."
            logger.error(error_message)
            return None

        # Execute the query
        mycursor.execute(query, params)
        result = mycursor.fetchone()

        if result:
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: Successfully fetched employee details for User ID: {user_id}, Username: {username}")
            return result
        else:
            logger.debug(f"{USER_ID} --> {MODULE_NAME}: No details found for User ID: {user_id}, Username: {username}")
            return None

    except Exception as e:
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Error fetching employee details for User ID: {user_id}, Username: {username} - {str(e)}")
        return None

    finally:
        mycursor.close()
