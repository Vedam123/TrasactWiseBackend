import os
import configparser

CONFIG_FILE = "config.ini"  # Path to the config.ini file

def create_folders():
    """Read BASE_PATH from config.ini and create missing folders."""
    config = configparser.ConfigParser()
    config.optionxform = str  # Preserve case sensitivity
    config.read(CONFIG_FILE, encoding="utf-8")

    # Get BASE_PATH from config.ini
    base_path = config["Global"].get("BASE_PATH", "").strip()

    if not base_path:
        print("BASE_PATH is missing in config.ini")
        return

    # Normalize path to avoid issues with slashes
    base_path = os.path.normpath(base_path)

    # Check if the entire BASE_PATH already exists
    if os.path.exists(base_path):
        print(f"Folder already exists: {base_path}")
        return

    # Create missing directories
    try:
        os.makedirs(base_path)
        print(f"Created folder: {base_path}")
    except Exception as e:
        print(f"Error creating folder {base_path}: {e}")

if __name__ == "__main__":
    create_folders()
