import os
import configparser

# Custom configparser that preserves case sensitivity for keys
class CaseInsensitiveConfigParser(configparser.ConfigParser):
    def optionxform(self, optionstr):
        return optionstr

# Function to generate the target file content
def update_config_file():
    # Step 1: Define paths for config files
    CURR_DIR = os.getcwd()
    CURR_DIR_NAME = os.path.basename(CURR_DIR)
    # Step 2: In the CURR_DIR there is a sub-directory called cnf, store its path in CNF_DIR and the directory name in CNF_DIR_NAME
    CNF_DIR = os.path.join(CURR_DIR, 'cnf')
    CNF_DIR_NAME = os.path.basename(CNF_DIR)

    # Step 3: In the CNF_DIR, there is a file called 00_config.ini, store its path in CNF_FILE_DIR and the name in CNF_FILE_NAME
    CNF_FILE_DIR = os.path.join(CNF_DIR, '00_config.ini')
    CNF_FILE_NAME = '00_config.ini'
    # Step 4: Find the Parent directory of CURR_DIR and store its path in PAR_DIR, and its name in PAR_DIR_NAME
    PAR_DIR = os.path.dirname(CURR_DIR)
    PAR_DIR_NAME = os.path.basename(PAR_DIR)

    # Step 5: Find the Parent directory of PAR_DIR and store its path in GRAND_PAR_DIR, and its name in GRAND_PAR_DIR_NAME
    GRAND_PAR_DIR = os.path.dirname(PAR_DIR)
    GRAND_PAR_DIR_NAME = os.path.basename(GRAND_PAR_DIR)

    # Step 6: In the GRAND_PAR_DIR, there is a sub-directory called application, store its path in APPL_DIR, and its name in APPL_DIR_NAME
    APPL_DIR = os.path.join(GRAND_PAR_DIR, 'application')
    APPL_DIR_NAME = os.path.basename(APPL_DIR)

    # Step 7: In the GRAND_PAR_DIR, there is a file config.ini, store its path in CONFIG_INI_DIR, and its name in CONFIG_INI_DIR_NAME
    CONFIG_INI_DIR = os.path.join(GRAND_PAR_DIR, 'config.ini')
    CONFIG_INI_DIR_NAME = 'config.ini'
   

    # Step 2: Read values from the config.ini file
    config = CaseInsensitiveConfigParser()
    config.read(CONFIG_INI_DIR)

    # Step 3: Extract necessary values from config.ini
    company_folder = config.get('Global', 'Company_folder')
    instances = int(config.get('database', 'instances'))
    ports = config.get('database', 'ports').split(',')

    # Ensure the number of ports matches the number of instances + 1
    if len(ports) != instances + 1:
        print(f"Error: The number of ports ({len(ports)}) does not match the number of instances ({instances}) + 1.")
        return

    # Step 4: Create content for the target file
    target_content = []

    # Create [MySQL] section with Company, gcname, name, and instances
    target_content.append("[MySQL]")
    target_content.append(f"Company={company_folder}")
    target_content.append(f"gcname=G{company_folder}")
    target_content.append(f"name={company_folder}")
    target_content.append(f"instances={instances}")
    target_content.append("base_port=3306")  # Static value for base_port

    # Add a line space after the MySQL section
    target_content.append("")

    # Add port lines based on instances and ports from the config.ini
    for idx in range(instances + 1):  # Ensure there are enough ports (instances + 1)
        target_content.append(f"port{idx}={ports[idx]}")

    # Add InstanceFolders section
    target_content.append("")
    target_content.append("[InstanceFolders]")
    for idx in range(instances+1):
        target_content.append(f"INSTANCE{idx}=instance{idx}")

    # Step 5: Write the content to the target 00_config.ini file
    with open(CNF_FILE_DIR, 'w') as configfile:
        configfile.write("\n".join(target_content))

    print(f"{CNF_FILE_DIR} has been successfully updated.")

# Call the function to update the config file
update_config_file()
