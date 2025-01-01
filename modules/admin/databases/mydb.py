import mysql.connector
from modules.utilities.logger import logger

def get_database_connection(db_user, db_request_file_name, host, port, password,appuser):
    try:
        # Log the database connection attempt
        logger.debug(f"{appuser} --> {__name__}: Attempting to connect to the database... by the user {appuser} for the file  {db_request_file_name}")
        print("DB RECEUVERS ",db_user, db_request_file_name, host, port, password)
        # Connect to MySQL database using dynamic parameters
        mydb = mysql.connector.connect(
            host=host,
            user=db_user,  # Replace with actual user
            password=password,
            database="adm",
            port=port
        )

        # Log the successful database connection
        logger.debug(f"{appuser} --> {__name__}: Database is connected by the user {appuser} for the file  {db_request_file_name}")
        return mydb
    except Exception as e:
        # Log any connection errors
        logger.error(f"{db_user} --> {db_request_file_name}: Failed to connect to the database: {str(e)}")
        return None
