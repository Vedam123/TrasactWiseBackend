import os
import shutil
import configparser
import logging
import socket

CONFIG_FILE = "config.ini"  # The path to config.ini in the same directory
LOG_FILE = "setup_log.txt"  # Log file name

# Configure logging
script_dir = os.path.dirname(os.path.abspath(__file__))  # Get the script's directory
log_file_path = os.path.join(script_dir, LOG_FILE)
logging.basicConfig(
    filename=log_file_path,
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
    encoding="utf-8",
)

class CustomConfigParser(configparser.ConfigParser):
    def optionxform(self, optionstr):
        return optionstr

def is_mysql_installed():
    mysql_exe = shutil.which("mysql")
    if mysql_exe:
        logging.info("MySQL is installed.")
    else:
        logging.warning("MySQL is not installed.")
    return mysql_exe

def find_free_port():
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
        s.bind(("0.0.0.0", 0))  # Correct way to bind
        port = s.getsockname()[1]
        logging.info(f"Found free port: {port}")
        return port

def get_system_ip():
    try:
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
        s.connect(("8.8.8.8", 80))
        ip_address = s.getsockname()[0]
        s.close()
        logging.info(f"System IP address: {ip_address}")
        return ip_address
    except Exception as e:
        logging.error(f"Error retrieving system IP: {e}")
        return "127.0.0.1"

def update_config():
    config = configparser.ConfigParser()
    config.optionxform = str
    config.read(CONFIG_FILE, encoding="utf-8")
    instances_count = int(config["database"].get("instances", 1))
    db_ports = [str(find_free_port()) for _ in range(instances_count + 1)]
    db_ports_str = ",".join(db_ports)
    api_port = str(find_free_port())
    web_port = str(find_free_port())
    smtp_port = str(find_free_port())
    system_ip = get_system_ip()
    config["database"]["ports"] = db_ports_str
    config["database"]["DB_SERVER_HOST_IP"] = system_ip
    config["AppService"]["APP_SERVER_HOST"] = system_ip
    config["AppService"]["APP_SERVER_PORT"] = api_port
    config["WebClient"]["WEB_CLIENT_PORT"] = web_port
    config["SMTP"]["SMTP_HOST"] = system_ip
    config["SMTP"]["SMTP_PORT"] = smtp_port
    with open(CONFIG_FILE, "w", encoding="utf-8") as configfile:
        config.write(configfile, space_around_delimiters=False)
    logging.info("Updated config.ini successfully!")

if __name__ == "__main__":
    if is_mysql_installed():
        update_config()
    else:
        logging.error("MySQL is not installed.")
