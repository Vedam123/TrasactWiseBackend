import os
import configparser
import logging
import subprocess

CONFIG_FILE = "config.ini"  # The path to config.ini in the same directory
LOG_FILE = "setup_log.txt"  # Log file name
OUTPUT_FILE = "results.txt"  # Output file name

# Configure logging
script_dir = os.path.dirname(os.path.abspath(__file__))  # Get the script's directory
log_file_path = os.path.join(script_dir, LOG_FILE)
logging.basicConfig(
    filename=log_file_path,
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
    encoding="utf-8",
)

def read_config():
    """Read config.ini and return a configparser object."""
    logging.info("Reading config.ini")
    config = configparser.ConfigParser()
    config.optionxform = str  # Preserve case sensitivity
    config.read(CONFIG_FILE, encoding="utf-8")
    return config

def construct_urls(config):
    """Construct UI and API URLs from config.ini."""
    logging.info("Constructing UI and API URLs")
    web_protocol = config["WebClient"]["WEB_CLIENT_PROTOCOL"].strip()
    web_host = config["AppService"]["APP_SERVER_HOST"].strip()
    web_port = config["WebClient"]["WEB_CLIENT_PORT"].strip()

    api_protocol = config["AppService"]["APP_SERVER_PROTOCOL"].strip()
    api_host = config["AppService"]["APP_SERVER_HOST"].strip()
    api_port = config["AppService"]["APP_SERVER_PORT"].strip()

    return {
        "UI_URL1": f"{web_protocol}://{web_host}:{web_port}",
        "UI_URL2": f"{web_protocol}://localhost:{web_port}",
        "API_URL1": f"{api_protocol}://{api_host}:{api_port}",
        "API_URL2": f"{api_protocol}://localhost:{api_port}"
    }

def get_database_details(config):
    """Get database instance details from the db_instances folder."""
    logging.info("Retrieving database instance details")
    base_path = os.path.normpath(config["Global"]["BASE_PATH"].strip())
    company_folder = config["Global"]["company_folder"].strip()

    db_instances_path = os.path.join(base_path, company_folder, "system", "db_instances")
    if not os.path.exists(db_instances_path):
        logging.warning("Database instances folder not found!")
        return ["Database instances folder not found!"]

    instances = int(config["database"]["instances"].strip())
    instance_names = config["database"]["INSTANCE_NAMES"].strip().split(",")

    database_details = []
    seen_instances = set()  # Track displayed instances to avoid duplication

    for folder_name in os.listdir(db_instances_path):
        folder_path = os.path.join(db_instances_path, folder_name)
        instance_file = os.path.join(folder_path, ".instance.cnf")
        root_password_file = os.path.join(folder_path, "root_password.ini")

        if os.path.isdir(folder_path) and os.path.exists(instance_file):
            if folder_name.lower() == "remotedb" and "remotedb_REMOTEDB" in seen_instances:
                continue  # Skip duplicate remote database entry
            
            with open(instance_file, "r", encoding="utf-8") as f:
                content = f.read().strip()
                suffix = instance_names.pop(0) if instance_names else folder_name
                db_key = f"Database [{folder_name}_{suffix}]"
                if db_key not in seen_instances:
                    database_details.append(f"{db_key}:\n{content}\n")
                    seen_instances.add(db_key)

            if os.path.exists(root_password_file):
                with open(root_password_file, "r", encoding="utf-8") as f:
                    password_content = f.read().strip()
                    root_key = f"Root Password [{folder_name}_{suffix}]"
                    if root_key not in seen_instances:
                        database_details.append(f"{root_key}:\n{password_content}\n")
                        seen_instances.add(root_key)

    logging.info("Database details retrieved successfully")
    return database_details

def write_results(urls, db_details):
    """Write the URLs and database details to results.txt."""
    logging.info(f"Writing results to {OUTPUT_FILE}")
    with open(OUTPUT_FILE, "w", encoding="utf-8") as f:
        f.write(f"UI_URL1={urls['UI_URL1']}\n")
        f.write(f"UI_URL2={urls['UI_URL2']}\n")
        f.write(f"API_URL1={urls['API_URL1']}\n")
        f.write(f"API_URL2={urls['API_URL2']}\n")
        f.write("\nDATABASE_DETAILS:\n")
        f.write("\n".join(db_details))
    logging.info("Results written successfully")

def main():
    logging.info("Starting configuration setup")
    config = read_config()
    urls = construct_urls(config)
    db_details = get_database_details(config)
    write_results(urls, db_details)
    logging.info(f"Process completed. Results stored in {OUTPUT_FILE}")

if __name__ == "__main__":
    main()
