import os
import configparser

# Custom write method to ensure no spaces around equal signs
class NoSpaceConfigParser(configparser.ConfigParser):
    def write(self, fp):
        """Override the default write function to remove spaces around equal signs."""
        for section in self.sections():
            fp.write(f"[{section}]\n")
            for (key, value) in self.items(section):
                fp.write(f"{key}={value}\n")  # No space around the equal sign

def update_instance_config():
    # 1. Identify current directory and store its path and name
    CURR_DIR = os.getcwd()
    CURR_DIR_NAME = os.path.basename(CURR_DIR)
    print(f"Current directory: {CURR_DIR}")
    print(f"Current directory name: {CURR_DIR_NAME}")

    # 2. Identify parent directory of current directory
    PARENT_DIR = os.path.dirname(CURR_DIR)
    PARENT_DIR_NAME = os.path.basename(PARENT_DIR)
    print(f"Parent directory: {PARENT_DIR}")
    print(f"Parent directory name: {PARENT_DIR_NAME}")

    # 3. Identify parent's parent directory (grandparent)
    GRAND_PAR_DIR = os.path.dirname(PARENT_DIR)
    GRAND_PAR_DIR_NAME = os.path.basename(GRAND_PAR_DIR)
    print(f"Grandparent directory: {GRAND_PAR_DIR}")
    print(f"Grandparent directory name: {GRAND_PAR_DIR_NAME}")

    # 4. Check if db_instances directory exists
    DB_INST_DIR = os.path.join(GRAND_PAR_DIR, 'db_instances')
    if not os.path.isdir(DB_INST_DIR):
        print("db_instances directory not found.")
        exit(1)
    print(f"DB instances directory: {DB_INST_DIR}")

    # 5. Check if cnf subdirectory exists
    CNF_DIR = os.path.join(CURR_DIR, 'cnf')
    if not os.path.isdir(CNF_DIR):
        print("cnf directory not found.")
        exit(1)
    print(f"CNF directory: {CNF_DIR}")

    # 6. Read the config_00_file
    config_00_file = os.path.join(CNF_DIR, '00_config.ini')
    if not os.path.isfile(config_00_file):
        print(f"Error: {config_00_file} does not exist.")
        exit(1)

    # Parse the 00_config file
    config = configparser.ConfigParser()
    config.read(config_00_file)

    DB_SERVER_HOST = config.get('MySQL', 'DB_SERVER_HOST')
    DB_SERVER_HOST_IP = config.get('MySQL', 'DB_SERVER_HOST_IP')

    # 7. Loop through each subfolder in the db_instances directory
    for instance_folder in os.listdir(DB_INST_DIR):
        if instance_folder.startswith('instance'):
            instance_folder_path = os.path.join(DB_INST_DIR, instance_folder)

            # 8. Check if the .instance.cnf file exists
            INSTANCE_FILE = os.path.join(instance_folder_path, '.instance.cnf')
            if os.path.isfile(INSTANCE_FILE):
                print(f"Updating {INSTANCE_FILE} for {instance_folder}...")

                # Read the INSTANCE_FILE with the custom config parser
                instance_config = NoSpaceConfigParser()
                instance_config.read(INSTANCE_FILE)

                # Update the host in the instance file
                instance_config.set('client', 'host', DB_SERVER_HOST)

                # Update the user in the instance file based on instance folder name
                instance_name = instance_folder
                instance_user = instance_name[-4:] + 'usr'
                instance_config.set('client', 'user', instance_user)

                # Update the hostip in the instance file
                instance_config.set('client', 'hostip', DB_SERVER_HOST_IP)

                # Update the port in the instance file (based on instance0, instance1, etc.)
                instance_index = instance_name[-1]  # Assuming instanceX where X is the index
                port_key = f"port{instance_index}"
                port_value = config.get('MySQL', port_key)
                instance_config.set('client', 'port', port_value)

                # Write the updated content back to the .instance.cnf file without spaces around '='
                with open(INSTANCE_FILE, 'w') as configfile:
                    instance_config.write(configfile)

                print(f"{INSTANCE_FILE} updated successfully.")
            else:
                print(f"{INSTANCE_FILE} not found for {instance_folder}, skipping...")

if __name__ == "__main__":
    update_instance_config()
