import logging
from flask import jsonify
from config import  APPLICATION_CREDENTIALS

# Assuming logger is set up earlier in your code
logger = logging.getLogger(__name__)

# Routine 1: Fetch user info from the 'adm.users' table
def get_user_info(username, mydb, appuserstatus):
    """
    Fetch user info from the 'adm.users' table.

    Args:
    - username (str): The username to search for.
    - mydb (db connection): The database connection object.
    - appuserstatus (str): The status of the user.

    Returns:
    - dict: User data including empid or an error response (as a dictionary, not jsonify).
    """


        # Fetch user_info based on appuser and check if they are active
    user_info = next((user for user in APPLICATION_CREDENTIALS if user["username"] == username and user["status"].lower() == "active"), None)
        
    if user_info:
        # If the user is found in APPLICATION_CREDENTIALS, return that info
        logger.debug(f"User '{username}' found in APPLICATION_CREDENTIALS with active status.")
        
        user_info_return = {
            "username": user_info["username"],
            "password": user_info["password"],
            "emailid": user_info["emailid"],
            "empid": user_info["empid"],
            "id": user_info["userid"],  # Assuming 'userid' is the 'id' field in the user_info dictionary
            "status": user_info["status"],
            "start_date": user_info["start_date"],
            "expiry_date": user_info["expiry_date"]
        }
        
        return user_info_return, 200  # Return user info from APPLICATION_CREDENTIALS

    query = """
    SELECT username, password, emailid, empid, id, status, start_date, expiry_date 
    FROM adm.users WHERE username = %s AND status = %s
    """
    values = (username, appuserstatus,)

    try:
        with mydb.cursor() as mycursor:
            mycursor.execute(query, values)
            result = mycursor.fetchone()
            if result is None:
                logger.error(f"No data found for username {username} with status {appuserstatus}")
                return {"error": "User not found"}, 404  # Return error as a dict, not jsonify
            if len(result) != 8:
                logger.error(f"Unexpected result format: {result}. Expected 8 columns.")
                return {"error": "Unexpected result format"}, 500  # Return error as a dict, not jsonify
            
            # Return user info with empid
            user_info = {
                "username": result[0],
                "password": result[1],
                "emailid": result[2],
                "empid": result[3],
                "id": result[4],
                "status": result[5],
                "start_date": result[6],
                "expiry_date": result[7]
            }
            return user_info, 200  # Return success as a dict with a 200 status code

    except Exception as e:
        logger.error(f"An error occurred while querying adm.users table: {e}")
        return {"error": "An error occurred while querying user info"}, 500  # Retur

# Routine 2: Fetch employee details from the 'com.employee' table using empid
def fetch_employee_details(empid, mydb):
    """
    Fetch employee details from the 'com.employee' table.

    Args:
    - empid (int): The employee ID to search for.
    - mydb (db connection): The database connection object.

    Returns:
    - dict: Employee details like name and pic or an error response.
    """
    query = "SELECT name, pic FROM com.employee WHERE empid = %s"
    values = (int(empid),)
    
    print("Employee id ",empid)
    try:
        with mydb.cursor() as mycursor:
            mycursor.execute(query, values)
            result = mycursor.fetchone()
            if result is None:
                logger.error(f"No employee details found for empid {empid}")
                return jsonify({"error": "Employee not found"}), 404
            
            employee_info = {
                "name": result[0],
                "pic": result[1]
            }
            return employee_info
    except Exception as e:
        logger.error(f"An error occurred while querying com.employee table: {e}")
        return jsonify({"error": "An error occurred while querying employee details"}), 500
