import os
import shutil
import configparser
import logging
import string

CONFIG_FILE = "config.ini"  # The path to config.ini in the same directory VEDAM
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
    """Custom ConfigParser to avoid typecasting to lowercase and adding spaces around the '=' sign."""
    def optionxform(self, optionstr):
        return optionstr

    def write(self, fp):
        for section in self.sections():
            fp.write(f"[{section}]\n")
            for option, value in self.items(section):
                fp.write(f"{option}={value}\n")
            fp.write("\n")

def is_mysql_installed():
    """Check if MySQL is installed by looking for the mysql executable."""
    mysql_exe = shutil.which("mysql")
    if mysql_exe:
        logging.info("MySQL is installed.")
    else:
        logging.warning("MySQL is not installed.")
    return mysql_exe

def find_my_ini():
    """Search for my.ini in all available drives, ensuring system folders are skipped."""
    drives = [f"{d}:\\" for d in string.ascii_uppercase if os.path.exists(f"{d}:\\")]

    # Absolute paths of folders to completely skip
    EXCLUDED_FOLDERS = {"$Recycle.Bin", "System Volume Information", "Config.Msi", "Recovery"}

    for drive in drives:
        for dirpath, _, filenames in os.walk(drive):
            # Normalize the path and split it into folder names
            parts = set(os.path.normpath(dirpath).split(os.sep))

            # Skip the entire directory if any of its parts match excluded folders
            if parts & EXCLUDED_FOLDERS:
                logging.info(f"Skipping directory: {dirpath}")  # Debugging info
                continue  # Skip this directory and all its subdirectories

            if "my.ini" in filenames:
                path = os.path.join(dirpath, "my.ini")

                # Ensure this is a valid file and not a deleted one
                if os.path.exists(path):
                    logging.info(f"my.ini file found at: {path}")
                    print(f"my.ini file found at: {path}")
                    return path  # Return the first valid match found

    logging.warning("my.ini file not found in any drive.")
    return None

def find_mysql_bin():
    """Find the MySQL bin directory based on the mysql executable path."""
    mysql_exe = is_mysql_installed()
    if mysql_exe:
        bin_path = os.path.dirname(mysql_exe)
        logging.info(f"MySQL bin directory found at: {bin_path}")
        return bin_path
    logging.warning("MySQL bin directory not found.")
    return None

def get_mysql_data_directory(my_ini_path):
    """Extract the MySQL data directory path manually from my.ini."""
    if not my_ini_path or not os.path.exists(my_ini_path):
        logging.error("Invalid my.ini path provided.")
        return None
    try:
        with open(my_ini_path, "r", encoding="utf-8") as file:
            for line in file:
                line = line.strip()
                if line.lower().startswith("datadir"):
                    parts = line.split("=", 1)
                    if len(parts) > 1:
                        data_dir = parts[1].strip().strip('"')  # Strip extra quotes
                        if os.path.exists(data_dir):
                            logging.info(f"MySQL data directory found at: {data_dir}")
                            return data_dir
                        else:
                            logging.error(f"Data directory does not exist: {data_dir}")
                            return None
    except Exception as e:
        logging.error(f"Error reading my.ini: {e}")
    return None

def find_parent_my_ini(data_dir):
    """Check if my.ini exists in the parent directory of the MySQL data directory."""
    if not data_dir or not os.path.exists(data_dir):
        logging.error("Invalid MySQL data directory provided.")
        return None
    
    parent_dir = os.path.dirname(data_dir)
    my_ini_path = os.path.normpath(os.path.join(parent_dir, "my.ini"))
    
    if os.path.exists(my_ini_path):
        logging.info(f"Parent directory's my.ini file found at: {my_ini_path}")
        return my_ini_path
    else:
        logging.warning(f"Parent directory's my.ini file not found at: {my_ini_path}")
        return None

def update_config_file(config_file, source_file, mysql_bin, source_myini_file):
    """Update the config.ini file with new values."""
    config = CustomConfigParser()
    if os.path.exists(config_file):
        config.read(config_file)
    if 'Global' not in config:
        config['Global'] = {}
    config.set('Global', 'SOURCE_FILE', source_file or "")
    config.set('Global', 'MYSQL_BIN', mysql_bin or "")
    config.set('Global', 'SOURCE_MYINI_FILE', source_myini_file or "")
    with open(config_file, "w", encoding="utf-8") as configfile:
        config.write(configfile)
    logging.info(f"Updated {config_file} successfully!")

if __name__ == "__main__":
    if is_mysql_installed():
        SOURCE_FILE = find_my_ini()
        MYSQL_BIN = find_mysql_bin()
        MYSQL_DATA_DIR = get_mysql_data_directory(SOURCE_FILE)
        SOURCE_MYINI_FILE = find_parent_my_ini(MYSQL_DATA_DIR)

        # Debugging output
        print(f"SOURCE_FILE = {SOURCE_FILE}")
        print(f"MYSQL_BIN = {MYSQL_BIN}")
        print(f"MYSQL_DATA_DIR = {MYSQL_DATA_DIR}")
        print(f"SOURCE_MYINI_FILE = {SOURCE_MYINI_FILE}")

        update_config_file(CONFIG_FILE, SOURCE_FILE, MYSQL_BIN, SOURCE_MYINI_FILE)
    else:
        logging.error("MySQL is not installed.")