import mysql.connector
from modules.utilities.logger import logger  # Import the logger module
from modules.security.get_user_from_token import get_user_from_token

def get_database_connection(USER_ID, MODULE_NAME):
    try:
        # Log the database connection attempt
        logger.debug(f"{USER_ID} --> {MODULE_NAME}: Attempting to connect to the database...")

        # Connect to MySQL database
        mydb = mysql.connector.connect(
            host="localhost",
            user="vedamc0in1",
            password="welcome",
            database="adm",
            port=3312
        )

        # Log the successful database connection
        logger.info(f"{USER_ID} --> {MODULE_NAME}: Connected to the database successfully.")

        return mydb
    except Exception as e:
        # Log any connection errors
        logger.error(f"{USER_ID} --> {MODULE_NAME}: Failed to connect to the database: {str(e)}")
        return None
