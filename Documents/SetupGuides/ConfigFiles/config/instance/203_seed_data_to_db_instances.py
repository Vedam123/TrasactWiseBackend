import os
import configparser
import mysql.connector
from mysql.connector import Error

# 1. Identify current, parent, grandparent directory
CURR_DIR = os.getcwd()
PARENT_DIR = os.path.dirname(CURR_DIR)
GRAND_PAR_DIR = os.path.dirname(PARENT_DIR)
CONFIG_FILE_PATH = os.path.join(GRAND_PAR_DIR, 'config.ini')
SCHEMA_DIR = os.path.join(GRAND_PAR_DIR, 'config', 'schema')
SEED_DUMP_FILE = os.path.join(SCHEMA_DIR, 'seed_data_dump.sql')
LOG_FILE = os.path.join(GRAND_PAR_DIR, 'import_log.txt')

# 2. Read config.ini file
config = configparser.ConfigParser()
config.read(CONFIG_FILE_PATH)
SEED_DATA = config.get('database', 'SEED_DATA', fallback='No')
DB_INST_DIR = os.path.join(GRAND_PAR_DIR, 'db_instances')

# Logging function
def log_message(message):
    with open(LOG_FILE, 'a') as log:
        log.write(message + "\n")
    print(message)

# 3. Proceed only if SEED_DATA is 'Yes'
if SEED_DATA.lower() == 'yes':
    if not os.path.exists(SEED_DUMP_FILE):
        log_message(f"Error: Seed data dump file '{SEED_DUMP_FILE}' not found. Exiting.")
        exit(1)

    if not os.path.isdir(DB_INST_DIR):
        log_message("db_instances directory not found. Exiting.")
        exit(1)
    
    for instance_folder in os.listdir(DB_INST_DIR):
        if instance_folder.startswith('instance'):
            instance_path = os.path.join(DB_INST_DIR, instance_folder)
            inst_config_file = os.path.join(instance_path, '.instance.cnf')
            root_pwd_file = os.path.join(instance_path, 'root_password.ini')

            if os.path.isfile(inst_config_file) and os.path.isfile(root_pwd_file):
                config.read(inst_config_file)
                DB_USER = config.get('client', 'user')
                DB_HOST = config.get('client', 'host')
                DB_PORT = config.get('client', 'port')
                
                with open(root_pwd_file, 'r') as f:
                    ROOT_PWD = next((line.split('=')[1].strip() for line in f if line.startswith('password=')), None)
                
                if not ROOT_PWD:
                    log_message(f"Missing root password for {instance_folder}. Skipping...")
                    continue
                
                connection = None
                try:
                    # Attempt import using root user
                    connection = mysql.connector.connect(
                        host=DB_HOST, user='root', password=ROOT_PWD, port=DB_PORT
                    )
                    cursor = connection.cursor()
                    #import_command = f"mysql -u root -p{ROOT_PWD} -h {DB_HOST} -P {DB_PORT} {DB_USER} < {SEED_DUMP_FILE}"
                    import_command = f'mysql -u root -p{ROOT_PWD} -h {DB_HOST} -P {DB_PORT} < "{SEED_DUMP_FILE}"'

                    print(f"Executing: {import_command}")
                    os.system(import_command)
                    log_message(f"Successfully imported seed data for {DB_USER} on port {DB_PORT} using root user.")
                except Error:
                    try:
                        # Attempt import using instance user
                        connection = mysql.connector.connect(
                            host=DB_HOST, user=DB_USER, password=config.get('client', 'password'), port=DB_PORT
                        )
                        #import_command = f"mysql -u {DB_USER} -p{config.get('client', 'password')} -h {DB_HOST} -P {DB_PORT} {DB_USER} < {SEED_DUMP_FILE}"
                        import_command = f'mysql -u {DB_USER} -p{config.get("client", "password")} -h {DB_HOST} -P {DB_PORT} < "{SEED_DUMP_FILE}"'

                        print(f"Executing: {import_command}")
                        os.system(import_command)
                        log_message(f"Successfully imported seed data for {DB_USER} on port {DB_PORT} using instance user.")
                    except Error as e:
                        log_message(f"Failed to import seed data for {DB_USER} on port {DB_PORT}. Error: {e}")
                finally:
                    if connection and connection.is_connected():
                        connection.close()
            else:
                log_message(f"Required files missing for {instance_folder}. Skipping...")
else:
    log_message("SEED_DATA is set to 'No'. Skipping import process.")
