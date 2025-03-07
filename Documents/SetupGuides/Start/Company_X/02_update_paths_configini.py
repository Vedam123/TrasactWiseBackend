import os
import shutil
import configparser

CONFIG_FILE = "config.ini"  # The path to config.ini in the same directory

class CustomConfigParser(configparser.ConfigParser):
    """Custom ConfigParser to avoid typecasting to lowercase and adding spaces around the '=' sign."""
    def optionxform(self, optionstr):
        # Do not change the case of the option names
        return optionstr

    def write(self, fp):
        """Override write method to avoid extra spaces around '=' sign."""
        for section in self.sections():
            fp.write(f"[{section}]\n")
            for option, value in self.items(section):
                # Ensure no spaces around '='
                fp.write(f"{option}={value}\n")
            fp.write("\n")

def is_mysql_installed():
    """Check if MySQL is installed by looking for the mysql executable."""
    mysql_exe = shutil.which("mysql")
    return mysql_exe

def find_my_ini(root="C:\\"):
    """Search for my.ini file from the given root directory."""
    for dirpath, _, filenames in os.walk(root):
        if "my.ini" in filenames:
            return os.path.join(dirpath, "my.ini")
    return None

def find_mysql_bin():
    """Find the MySQL bin directory based on the mysql executable path."""
    mysql_exe = is_mysql_installed()
    if mysql_exe:
        return os.path.dirname(mysql_exe)  # Get the directory containing mysql.exe
    return None

def get_mysql_data_directory(my_ini_path):
    """Extract the MySQL data directory path manually from my.ini."""
    if not my_ini_path or not os.path.exists(my_ini_path):
        return None

    try:
        with open(my_ini_path, "r", encoding="utf-8") as file:
            for line in file:
                line = line.strip()
                if line.lower().startswith("datadir"):
                    _, value = line.split("=", 1)
                    return value.strip()
    except Exception as e:
        print(f"Error reading my.ini: {e}")

    return None

def find_parent_my_ini(data_dir):
    """Check if my.ini exists in the parent directory of the MySQL data directory."""
    if not data_dir:
        return None

    parent_dir = os.path.dirname(data_dir)  # Get parent directory
    my_ini_path = os.path.normpath(os.path.join(parent_dir, "my.ini"))  # Ensure correct slashes

    return my_ini_path if os.path.exists(my_ini_path) else None

def update_config_file(config_file, source_file, mysql_bin, source_myini_file):
    """Update the config.ini file with new values."""
    config = CustomConfigParser()
    
    # Read existing config.ini if available
    if os.path.exists(config_file):
        config.read(config_file)

    # Ensure [Global] section exists
    if 'Global' not in config:
        config['Global'] = {}

    # Update values without altering the casing or adding extra spaces
    config.set('Global', 'SOURCE_FILE', source_file or "")
    config.set('Global', 'MYSQL_BIN', mysql_bin or "")
    config.set('Global', 'SOURCE_MYINI_FILE', source_myini_file or "")

    # Write back to config.ini using the custom write method
    with open(config_file, "w", encoding="utf-8") as configfile:
        config.write(configfile)

    print(f"Updated {config_file} successfully!")

if __name__ == "__main__":
    if is_mysql_installed():
        print("MySQL is installed.")

        # Find and print my.ini file location
        SOURCE_FILE = find_my_ini("C:\\") if os.name == "nt" else find_my_ini("/")
        if SOURCE_FILE:
            print(f"my.ini file found at: {SOURCE_FILE}")
        else:
            print("my.ini file not found.")

        # Find and print MySQL bin directory location
        MYSQL_BIN = find_mysql_bin()
        if MYSQL_BIN:
            print(f"MySQL bin directory found at: {MYSQL_BIN}")
        else:
            print("MySQL bin directory not found.")

        # Find and print MySQL data directory location
        MYSQL_DATA_DIR = get_mysql_data_directory(SOURCE_FILE)
        if MYSQL_DATA_DIR:
            print(f"MySQL data directory found at: {MYSQL_DATA_DIR}")

            # Find and print parent directory's my.ini file location
            SOURCE_MYINI_FILE = find_parent_my_ini(MYSQL_DATA_DIR)
            if SOURCE_MYINI_FILE:
                print(f"Parent directory's my.ini file found at: {SOURCE_MYINI_FILE}")
            else:
                print("Parent directory's my.ini file not found.")
        else:
            print("MySQL data directory not found in my.ini.")
            SOURCE_MYINI_FILE = None  # Ensure we pass None if not found

        # Update the config.ini file with the fetched values
        update_config_file(CONFIG_FILE, SOURCE_FILE, MYSQL_BIN, SOURCE_MYINI_FILE)

    else:
        print("MySQL is not installed.")
