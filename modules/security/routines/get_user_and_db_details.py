from modules.security.get_user_from_token import get_user_from_token
from modules.admin.databases.mydb import get_database_connection
from modules.security.routines.read_instance_cnf import read_instance_cnf
from modules.security.routines.get_user_and_emp_details import get_user_info, fetch_employee_details
from modules.utilities.logger import logger  # Import logger module
from config import  APPLICATION_CREDENTIALS

def get_user_and_db_details(authorization_header):
    """
    Extract user details from the authorization token and establish a database connection.

    Args:
    - authorization_header (str): The authorization header containing the token.

    Returns:
    - tuple: A tuple containing all the required details (user, employee, and system details).
    """
    # Extract user details from the token
    token_results = {}
    print("Received auth header",authorization_header)
    if authorization_header:
        token_results = get_user_from_token(authorization_header)
        logger.debug(f"Token extracted for authorization: {token_results}")
    else:
        logger.error(f"{appuser} --> {__name__}: Authorization header missing or invalid")
        return None, None, None, None, None, None, "Authorization header missing or invalid"

    # Extract user details from the token results
    appuser = token_results.get("username", None)
    instance = token_results.get("instance", None)
    company = token_results.get("company", None)
    appuserid = token_results.get("Userid", None)
    app_user_status = token_results.get("appuserstatus", None)

    # Check if the required user details are present
    if not appuser:
        logger.error(f"{appuser} --> {__name__}: User not authorized or username not found in the token")
        return None, None, None, None, None, None, "User not authorized or username not found in the token"
    
    logger.debug(f"{appuser} --> {__name__}: Extracted user details from token: appuser={appuser}, instance={instance}, company={company}")

    # Get system details (user, host, port, password) using read_instance_cnf function
    try:
        dbuser, host, port, password = read_instance_cnf(company, instance,appuser,appuserid)
        logger.debug(f"{appuser} --> {__name__}: System details retrieved: dbuser={dbuser}, host={host}, port={port}")
    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Error retrieving system details: {str(e)}")
        return None, None, None, None, None, None, f"Error retrieving system details: {str(e)}"

    # Establish a database connection
    try:
        mydb = get_database_connection(dbuser, __name__, host, port, password,appuser)
        logger.debug(f"{appuser} --> {__name__}: Database connection established")
    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Error establishing database connection: {str(e)}")
        return None, None, None, None, None, None, f"Error establishing database connection: {str(e)}"

    user_info, status_code = get_user_info(appuser, mydb, app_user_status)

    if status_code != 200:
        logger.error(f"{appuser} --> {__name__}: User info can't be successfully retrieved from the function get_user_info: {status_code}")
        return user_info, status_code  # Handle the error response properly

    if user_info is None:
        logger.error(f"{appuser} --> {__name__}: Error fetching user info")
        return company, instance, dbuser, mydb, appuser, appuserid, "Error fetching user info"
    
    logger.debug(f"{appuser} --> {__name__}: User info fetched successfully for {appuser}")

    empid = user_info.get("empid")
    
    logger.debug(f"{appuser} --> {__name__}: Extracted empid={empid} from user info")

     # Check if empid is 0, and handle accordingly
    if int(empid) == 0:
        # If empid is 0, get employee details from APPLICATION_CREDENTIALS  
        employee_info = next((user for user in APPLICATION_CREDENTIALS if user["username"] == appuser and user["status"].lower() == "active"), None)
        
        if employee_info:
            # If found, form employee_info with name and pic as None
            employee_info = {
                "name": employee_info["name"],
                "pic": None
            }
            logger.debug(f"{appuser} --> {__name__}: Employee info fetched from APPLICATION_CREDENTIALS: {employee_info}")
        else:
            logger.error(f"{appuser} --> {__name__}: Employee info for empid=0 not found in APPLICATION_CREDENTIALS")
            return company, instance, dbuser, mydb, appuser, appuserid, "Employee info not found for empid=0"

    else:
        # If empid is not 0, fetch employee details from the database
        try:
            employee_info = fetch_employee_details(empid, mydb)
            logger.debug(f"{appuser} --> {__name__}: Employee details fetched for empid={empid}")
        except Exception as e:
            logger.error(f"{appuser} --> {__name__}: Error fetching employee details for empid={empid}: {str(e)}")
            return company, instance, dbuser, mydb, appuser, appuserid, f"Error fetching employee details: {str(e)}"
        
    logger.debug(
        f"{appuser} --> {__name__}: Error fetching employee details for empid={empid}. "
        f"company={company}, instance={instance}, dbuser={dbuser},"
        f"appuser={appuser}, appuserid={appuserid}"
    )
    return company, instance, dbuser, mydb, appuser, appuserid, user_info, employee_info
