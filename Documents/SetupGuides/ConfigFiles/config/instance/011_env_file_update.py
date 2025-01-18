import os
import configparser

def update_env_file():
    # 1. Find the current directory and store its path in CURR_DIR, and the directory name in CURR_DIR_NAME
    CURR_DIR = os.getcwd()
    CURR_DIR_NAME = os.path.basename(CURR_DIR)

    # 2. In the CURR_DIR, there is a subdirectory called cnf
    CNF_DIR = os.path.join(CURR_DIR, 'cnf')
    CNF_DIR_NAME = os.path.basename(CNF_DIR)

    # 3. Find the parent directory of CURR_DIR and store its path in PAR_DIR, and the directory name in PAR_DIR_NAME
    PAR_DIR = os.path.dirname(CURR_DIR)
    PAR_DIR_NAME = os.path.basename(PAR_DIR)

    # 4. Find the parent directory of PAR_DIR and store its path in GRAND_PAR_DIR, and the directory name in GRAND_PAR_DIR_NAME
    GRAND_PAR_DIR = os.path.dirname(PAR_DIR)
    GRAND_PAR_DIR_NAME = os.path.basename(GRAND_PAR_DIR)

    # 5. In the GRAND_PAR_DIR, there is a subdirectory called application
    APPL_DIR = os.path.join(GRAND_PAR_DIR, 'application')
    APPL_DIR_NAME = 'application'

    # 6. In the GRAND_PAR_DIR, there is a file config.ini
    CONFIG_INI_DIR = os.path.join(GRAND_PAR_DIR, 'config.ini')
    CONFIG_INI_DIR_NAME = 'config.ini'

    # 7. In the APPL_DIR, there is a subdirectory called WebClient
    APP_ROOT_DIR = os.path.join(APPL_DIR, 'WebClient')
    APP_ROOT_DIR_NAME = 'WebClient'

    # 8. In the APP_ROOT_DIR, there is a file called .env
    ENV_FILE_DIR = os.path.join(APP_ROOT_DIR, '.env')
    ENV_FILE_NAME = '.env'

    # Read the config.ini file to extract the required values
    config = configparser.ConfigParser()
    config.read(CONFIG_INI_DIR)

    # Extract the required values from the config.ini file
    web_client_app_name = config.get('WebClient', 'WEB_CLIENT_APPLICATION_NAME')
    web_client_app_level = config.get('WebClient', 'WEB_CLIENT_APPLICATION_LEVEL')
    web_client_host = config.get('WebClient', 'WEB_CLIENT_HOST')
    web_client_port = config.get('WebClient', 'WEB_CLIENT_PORT')
    web_client_protocol = config.get('WebClient', 'WEB_CLIENT_PROTOCOL')

    smtp_host = config.get('SMTP', 'SMTP_HOST')
    smtp_port = config.get('SMTP', 'SMTP_PORT')
    smtp_email = config.get('SMTP', 'SMTP_EMAIL')

    app_server_host = config.get('AppService', 'APP_SERVER_HOST')
    app_server_port = config.get('AppService', 'APP_SERVER_PORT')
    app_server_protocol = config.get('AppService', 'APP_SERVER_PROTOCOL')
    
    cetificate_file = config.get('CERTIFICATES', 'SSL_CRT_FILE')
    cetificate_key = config.get('CERTIFICATES', 'SSL_KEY_FILE')

    # Read the .env file to update the values
    with open(ENV_FILE_DIR, 'r') as env_file:
        env_lines = env_file.readlines()

    # Update the values in the .env file
    updated_env_lines = []
    for line in env_lines:
        if "REACT_APP_APPLICATION_NAME" in line:
            updated_env_lines.append(f"REACT_APP_APPLICATION_NAME={web_client_app_name}\n")
        elif "REACT_APP_APPLICATION_LEVEL" in line:
            updated_env_lines.append(f"REACT_APP_APPLICATION_LEVEL={web_client_app_level}\n")
        elif "REACT_APP_WEB_CLIENT_HOST" in line:
            updated_env_lines.append(f"REACT_APP_WEB_CLIENT_HOST={web_client_host}\n")
        elif "REACT_APP_WEB_CLIENT_PORT" in line:
            updated_env_lines.append(f"REACT_APP_WEB_CLIENT_PORT={web_client_port}\n")
        elif "REACT_APP_WEB_CLIENT_PROTOCOL" in line:
            updated_env_lines.append(f"REACT_APP_WEB_CLIENT_PROTOCOL={web_client_protocol}\n")
        elif "REACT_APP_SMTP_HOST" in line:
            updated_env_lines.append(f"REACT_APP_SMTP_HOST={smtp_host}\n")
        elif "REACT_APP_SMTP_PORT" in line:
            updated_env_lines.append(f"REACT_APP_SMTP_PORT={smtp_port}\n")
        elif "REACT_APP_SMTP_EMAIL" in line:
            updated_env_lines.append(f"REACT_APP_SMTP_EMAIL={smtp_email}\n")
        elif "REACT_APP_BACKEND_SERVER_HOST" in line:
            updated_env_lines.append(f"REACT_APP_BACKEND_SERVER_HOST={app_server_host}\n")
        elif "REACT_APP_BACKEND_SERVER_PORT" in line:
            updated_env_lines.append(f"REACT_APP_BACKEND_SERVER_PORT={app_server_port}\n")
        elif "REACT_APP_BACKEND_SERVER_PROTOCOL" in line:
            updated_env_lines.append(f"REACT_APP_BACKEND_SERVER_PROTOCOL={app_server_protocol}\n")
        elif "PROTOCOL" in line:
            updated_env_lines.append(f"PROTOCOL={web_client_protocol}\n")
        elif "HOST" in line:
            updated_env_lines.append(f"HOST={web_client_host}\n")
        elif "PORT" in line:
            updated_env_lines.append(f"PORT={web_client_port}\n")
        elif "SSL_CRT_FILE" in line:
            updated_env_lines.append(f"SSL_CRT_FILE='{cetificate_file}'\n")
        elif "SSL_KEY_FILE" in line:
            updated_env_lines.append(f"SSL_KEY_FILE='{cetificate_key}'\n")
        else:
            updated_env_lines.append(line)

    # Save the updated .env file
    with open(ENV_FILE_DIR, 'w') as env_file:
        env_file.writelines(updated_env_lines)

    print(f"{ENV_FILE_NAME} has been successfully updated.")

if __name__ == "__main__":
    update_env_file()
