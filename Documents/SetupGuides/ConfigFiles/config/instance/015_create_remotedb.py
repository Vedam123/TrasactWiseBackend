import os
import shutil
import configparser

# Custom configparser that preserves case sensitivity for keys
class CaseInsensitiveConfigParser(configparser.ConfigParser):
    def optionxform(self, optionstr):
        return optionstr

# Function to create remotedb folder and copy files
def create_remotedb_folder():
    # Define paths
    CURR_DIR = os.getcwd()
    GRAND_PAR_DIR = os.path.dirname(os.path.dirname(CURR_DIR))
    DB_INSTANCES_DIR = os.path.join(GRAND_PAR_DIR, 'db_instances')
    REMOTEDB_DIR = os.path.join(DB_INSTANCES_DIR, 'remotedb')
    INSTANCE0_DIR = os.path.join(DB_INSTANCES_DIR, 'instance0')

    # Create remotedb directory if it doesn't exist
    os.makedirs(REMOTEDB_DIR, exist_ok=True)

    # Copy files from instance0 to remotedb
    for file_name in [".instance.cnf", "root_password.ini"]:
        src_file = os.path.join(INSTANCE0_DIR, file_name)
        dest_file = os.path.join(REMOTEDB_DIR, file_name)

        if os.path.exists(src_file):
            shutil.copy(src_file, dest_file)
            print(f"Copied {file_name} to {REMOTEDB_DIR}")
        else:
            print(f"WARNING: {file_name} not found in instance0.")

# Run the function
create_remotedb_folder()
