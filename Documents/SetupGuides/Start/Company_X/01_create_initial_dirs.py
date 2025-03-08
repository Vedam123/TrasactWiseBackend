import os
import configparser
import logging

CONFIG_FILE = "config.ini"  # Path to the config.ini file
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

def create_folders():
    """Read BASE_PATH from config.ini and create missing folders."""
    config = configparser.ConfigParser()
    config.optionxform = str  # Preserve case sensitivity
    config.read(CONFIG_FILE, encoding="utf-8")

    # Get BASE_PATH from config.ini
    base_path = config["Global"].get("BASE_PATH", "").strip()

    if not base_path:
        logging.error("BASE_PATH is missing in config.ini")
        return

    # Normalize path to avoid issues with slashes
    base_path = os.path.normpath(base_path)

    # Check if the entire BASE_PATH already exists
    if os.path.exists(base_path):
        logging.info(f"Folder already exists: {base_path}")
        return

    # Create missing directories
    try:
        os.makedirs(base_path)
        logging.info(f"Created folder: {base_path}")
    except Exception as e:
        logging.error(f"Error creating folder {base_path}: {e}")

if __name__ == "__main__":
    create_folders()
