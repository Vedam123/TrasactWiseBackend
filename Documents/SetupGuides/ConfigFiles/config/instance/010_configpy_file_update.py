import os
import configparser

# Step 1: Find the current directory and store its path in a variable CURR_DIR
CURR_DIR = os.getcwd()  # Current working directory
CURR_DIR_NAME = os.path.basename(CURR_DIR)  # Current directory name
print(f"Current Directory: {CURR_DIR}")
print(f"Current Directory Name: {CURR_DIR_NAME}")

# Step 2: Find the Parent directory of CURR_DIR and store its path in a variable PAR_DIR
PAR_DIR = os.path.dirname(CURR_DIR)  # Parent directory path
PAR_DIR_NAME = os.path.basename(PAR_DIR)  # Parent directory name
print(f"Parent Directory: {PAR_DIR}")
print(f"Parent Directory Name: {PAR_DIR_NAME}")

# Step 3: Find the Parent directory of PAR_DIR and store its path in a variable GRAND_PAR_DIR
GRAND_PAR_DIR = os.path.dirname(PAR_DIR)  # Grandparent directory path
GRAND_PAR_DIR_NAME = os.path.basename(GRAND_PAR_DIR)  # Grandparent directory name
print(f"Grandparent Directory: {GRAND_PAR_DIR}")
print(f"Grandparent Directory Name: {GRAND_PAR_DIR_NAME}")

# Step 4: Find the subdirectory 'application' in GRAND_PAR_DIR and store its path in APPL_DIR
APPL_DIR = os.path.join(GRAND_PAR_DIR, 'application')
APPL_DIR_NAME = os.path.basename(APPL_DIR)
print(f"Application Directory: {APPL_DIR}")
print(f"Application Directory Name: {APPL_DIR_NAME}")

# Step 5: Find the config.ini file in the GRAND_PAR_DIR and store its path in CONFIG_INI_DIR
CONFIG_INI_DIR = os.path.join(GRAND_PAR_DIR, 'config.ini')
CONFIG_INI_DIR_NAME = os.path.basename(CONFIG_INI_DIR)
print(f"Config.ini File Path: {CONFIG_INI_DIR}")
print(f"Config.ini File Name: {CONFIG_INI_DIR_NAME}")

# Step 6: Find the 'AppService' subdirectory in the APPL_DIR and store its path in APP_ROOT_DIR
APP_ROOT_DIR = os.path.join(APPL_DIR, 'AppService')
APP_ROOT_DIR_NAME = os.path.basename(APP_ROOT_DIR)
print(f"AppService Directory: {APP_ROOT_DIR}")
print(f"AppService Directory Name: {APP_ROOT_DIR_NAME}")

# Step 7: Locate the config.py file in the APP_ROOT_DIR
CONFIG_PY_PATH = os.path.join(APP_ROOT_DIR, 'config.py')
print(f"Config.py Path: {CONFIG_PY_PATH}")

# Read config.ini to get the values for replacement
config_ini = configparser.ConfigParser()

# Debugging: Check if the file exists
if os.path.exists(CONFIG_INI_DIR):
    print(f"config.ini file found at: {CONFIG_INI_DIR}")
else:
    print(f"Error: config.ini file not found at: {CONFIG_INI_DIR}")
    exit()

config_ini.read(CONFIG_INI_DIR)

# Debug: Check which sections are available in config.ini
print(f"Sections in config.ini: {config_ini.sections()}")

# Extract necessary values from config.ini
try:
    APP_BACKEND_ENV_TYPE = config_ini.get('AppService', 'APP_BACKEND_ENV_TYPE')
    #DB_INSTANCES_BASE_PATH = config_ini.get('database', "DB_INSTANCES_BASE_PATH")
    DB_INSTANCES_BASE_PATH = config_ini.get('database', 'DB_INSTANCES_BASE_PATH')
    # Directly wrap the DB_INSTANCES_BASE_PATH value in double quotes, no extra quotes added
    DB_INSTANCES_BASE_PATH = f'"{DB_INSTANCES_BASE_PATH}"'

    APP_SERVER_HOST = config_ini.get('AppService', 'APP_SERVER_HTTPS_HOST')   
    APP_SERVER_PROTOCOL = config_ini.get('AppService', 'APP_SERVER_PROTOCOL')
    APP_SERVER_PORT = config_ini.get('AppService', 'APP_SERVER_PORT')
   
    SSL_CRT_FILE = config_ini.get('CERTIFICATES', 'BACKEND_SSL_CRT_FILE')
    SSL_KEY_FILE = config_ini.get('CERTIFICATES', 'BACKEND_SSL_KEY_FILE')
    
    COMPANY_FOLDER = config_ini.get('Global', 'company_folder') 
    SYSTEM_FOLDER = config_ini.get('Global', 'system_folder') 
    CONFIG_FOLDER = config_ini.get('Global', 'config_folder')
    PROJECT_ROOT = config_ini.get('Global', 'project_root')
    APPLICATION_ROOT = config_ini.get('Global', 'app_root')
    
    PRODUCT_HOME = config_ini.get('Global', 'BASE_PATH')
    
    # Construct the full folder path
    #BACKEND_APP_ROOT_PATH = os.path.join(PRODUCT_HOME, COMPANY_FOLDER, SYSTEM_FOLDER, PROJECT_ROOT, APPLICATION_ROOT)
    
    # Construct the full folder path and ensure it has double backslashes
    BACKEND_APP_ROOT_PATH = os.path.join(PRODUCT_HOME, COMPANY_FOLDER, SYSTEM_FOLDER, PROJECT_ROOT, APPLICATION_ROOT)

    # Convert to a properly formatted Windows path
    BACKEND_APP_ROOT_PATH = BACKEND_APP_ROOT_PATH.replace("\\", "\\\\")
    
    # Step 9: Store the word 'Logs' in a variable
    LOGS_FOLDER = 'Logs'
    
    # Step 10: Construct the LOG_FILE_PATH by combining variables
    LOG_FILE_PATH = os.path.join(PRODUCT_HOME, COMPANY_FOLDER, SYSTEM_FOLDER, LOGS_FOLDER, APPLICATION_ROOT)

    # Step 11: Ensure the path uses forward slashes
    # Step 11: Ensure the path uses forward slashes and add a trailing slash
    LOG_FILE_PATH = LOG_FILE_PATH.replace("\\", "/") + "/"

    # Debug: Print the LOG_FILE_PATH
    print(f"LOG_FILE_PATH: {LOG_FILE_PATH}")

    # Debug: Print the extracted valuesyy
    print(f"APP_BACKEND_ENV_TYPE: {APP_BACKEND_ENV_TYPE}")
    print(f"DB_INSTANCES_BASE_PATH: {DB_INSTANCES_BASE_PATH}")
    print(f"APP_SERVER_HOST: {APP_SERVER_HOST}")
    print(f"APP_SERVER_PROTOCOL: {APP_SERVER_PROTOCOL}")
    print(f"APP_SERVER_PORT: {APP_SERVER_PORT}") 
    

except configparser.NoOptionError as e:
    print(f"Error: Missing option {e.option} in section {e.section}")
    exit()

# Step 8: Update config.py with the values from config.ini
with open(CONFIG_PY_PATH, 'r') as file:
    config_py_lines = file.readlines()

# Function to replace the key in the config.py lines
def update_config_py(lines, key, new_value):
    for i, line in enumerate(lines):
        if line.strip().startswith(key):
            lines[i] = f"{key} = '{new_value}'\n"
    return lines
    
# Construct the SSL paths by using BACKEND_APP_ROOT_PATH
def construct_ssl_path(ssl_file_path, backend_app_root_path):
    # If the ssl_file_path starts with './', remove it and join it with BACKEND_APP_ROOT_PATH
    if ssl_file_path.startswith('./'):
        ssl_file_path = ssl_file_path[2:]  # Remove './'
    
    # Join the base path with the SSL file path
    return os.path.join(backend_app_root_path, ssl_file_path)

# Update SSL_CRT_FILE and SSL_KEY_FILE paths
SSL_CRT_FILE = construct_ssl_path(config_ini.get('CERTIFICATES', 'BACKEND_SSL_CRT_FILE'), BACKEND_APP_ROOT_PATH)
SSL_KEY_FILE = construct_ssl_path(config_ini.get('CERTIFICATES', 'BACKEND_SSL_KEY_FILE'), BACKEND_APP_ROOT_PATH)

# Debug: Print the new SSL paths
print(f"SSL_CRT_FILE Path: {SSL_CRT_FILE}")
print(f"SSL_KEY_FILE Path: {SSL_KEY_FILE}")

# Update config.py file with new values
config_py_lines = update_config_py(config_py_lines, 'BACKEND_ENVIRONMENT', APP_BACKEND_ENV_TYPE)
config_py_lines = update_config_py(config_py_lines, 'APP_SERVER_HOST', APP_SERVER_HOST)
config_py_lines = update_config_py(config_py_lines, 'APP_SERVER_PROTOCOL', APP_SERVER_PROTOCOL)
config_py_lines = update_config_py(config_py_lines, 'SSL_CRT_FILE', SSL_CRT_FILE)
config_py_lines = update_config_py(config_py_lines, 'SSL_KEY_FILE', SSL_KEY_FILE)

config_py_lines = update_config_py(config_py_lines, 'COMPANY_FOLDER', COMPANY_FOLDER)
config_py_lines = update_config_py(config_py_lines, 'SYSTEM_FOLDER', SYSTEM_FOLDER)
config_py_lines = update_config_py(config_py_lines, 'CONFIG_FOLDER', CONFIG_FOLDER)
config_py_lines = update_config_py(config_py_lines, 'PROJECT_ROOT', PROJECT_ROOT)
config_py_lines = update_config_py(config_py_lines, 'APPLICATION_ROOT', APPLICATION_ROOT)
config_py_lines = update_config_py(config_py_lines, 'PRODUCT_HOME', PRODUCT_HOME)

# Update config.py with the new variable
config_py_lines = update_config_py(config_py_lines, 'BACKEND_APP_ROOT_PATH', BACKEND_APP_ROOT_PATH)

config_py_lines = update_config_py(config_py_lines, 'LOG_FILE_PATH', LOG_FILE_PATH)

print(f"config.py file updated successfully with FULL_PROJECT_PATH in {APP_ROOT_DIR}")


def update_config_py1(lines, key, new_value):
    for i, line in enumerate(lines):
        if line.strip().startswith(key):
            lines[i] = f"{key} = {new_value}\n"
    return lines
config_py_lines = update_config_py1(config_py_lines, 'DB_INSTANCES_BASE_PATH', DB_INSTANCES_BASE_PATH)
config_py_lines = update_config_py1(config_py_lines, 'APP_SERVER_PORT', APP_SERVER_PORT)

# Write the updated lines back to config.py
with open(CONFIG_PY_PATH, 'w') as file:
    file.writelines(config_py_lines)

print(f"config.py file updated successfully in {APP_ROOT_DIR}")
