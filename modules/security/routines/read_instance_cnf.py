import os
import configparser
from config import DB_INSTANCES_BASE_PATH
from modules.utilities.logger import logger  # Import logger module

def read_instance_cnf(company, instance, appuser, appuserid):
    """
    Reads the .instance.cnf file for the specified company and instance.

    Args:
        company (str): The company name.
        instance (str): The instance name.
        appuser (str): The application user requesting the operation.
        appuserid (str): The application user ID requesting the operation.

    Returns:
        tuple: A tuple containing (user, host, port, password) read from the .instance.cnf file.
    
    Raises:
        FileNotFoundError: If the instance folder or the .instance.cnf file is not found.
        Exception: For other general errors.
    """
    try:
        # Construct the paths for the instance configuration
        db_instance_path = os.path.join(DB_INSTANCES_BASE_PATH, company, "system", "db_instances")
        instance_folder = os.path.join(db_instance_path, instance)
        logger.debug(f"{appuser} --> {__name__}: Looking for instance folder at {instance_folder}")

        if not os.path.isdir(instance_folder):
            logger.error(f"{appuser} --> {__name__}: Instance folder for '{instance}' not found at {instance_folder}")
            raise FileNotFoundError(f"Instance folder for '{instance}' not found.")
        
        config_file_path = os.path.join(instance_folder, ".instance.cnf")
        logger.debug(f"{appuser} --> {__name__}: Looking for .instance.cnf file at {config_file_path}")

        if not os.path.exists(config_file_path):
            logger.error(f"{appuser} --> {__name__}: .instance.cnf file not found for '{instance}' at {config_file_path}")
            raise FileNotFoundError(f".instance.cnf file not found for '{instance}'.")

        # Read the configuration file
        config = configparser.ConfigParser()
        config.read(config_file_path)
        logger.debug(f"{appuser} --> {__name__}: Successfully read the .instance.cnf file for '{instance}'")

        # Extract the configuration values
        user = config.get('client', 'user').strip()
        host = config.get('client', 'host').strip()
        port = config.getint('client', 'port')
        password = config.get('client', 'password').strip()

        logger.debug(f"{appuser} --> {__name__}: Retrieved db user={user}, host={host}, port={port}, password=****")
        
        return user, host, port, password

    except FileNotFoundError as e:
        logger.error(f"{appuser} --> {__name__}: File not found error: {str(e)}")
        raise FileNotFoundError(str(e))
    except Exception as e:
        logger.error(f"{appuser} --> {__name__}: Error reading instance configuration: {str(e)}")
        raise Exception(f"Error reading instance configuration: {str(e)}")
