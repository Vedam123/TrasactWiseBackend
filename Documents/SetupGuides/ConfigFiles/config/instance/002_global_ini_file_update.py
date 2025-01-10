import os
import configparser

# Custom configparser that preserves case sensitivity for keys
class CaseInsensitiveConfigParser(configparser.ConfigParser):
    def optionxform(self, optionstr):
        return optionstr

# Function to update global_variables.ini
def update_global_variables_file():
     # Step 1: Define paths for config files
    CURR_DIR = os.getcwd()
    CURR_DIR_NAME = os.path.basename(CURR_DIR)
    # Step 2: In the CURR_DIR there is a sub-directory called cnf, store its path in CNF_DIR and the directory name in CNF_DIR_NAME
    CNF_DIR = os.path.join(CURR_DIR, 'cnf')
    CNF_DIR_NAME = os.path.basename(CNF_DIR)

    # Step 3: Define the path for global_variables.ini
    GLOBAL_VARS_FILE = os.path.join(CNF_DIR, 'global_variables.ini')

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

    config = CaseInsensitiveConfigParser()
    config.read(CONFIG_INI_DIR)

    # Step 5: Extract the required values from config.ini
    company_folder = config.get('Global', 'Company_folder')
    source_file = config.get('Global', 'SOURCE_FILE')
    source_myini_file = config.get('Global', 'SOURCE_MYINI_FILE')
    mysql_bin = config.get('Global', 'MYSQL_BIN')
    base_path = config.get('Global', 'BASE_PATH')

    # Step 6: Create the content for the global_variables.ini file
    target_content = []

    # Create the [Global] section with required variables
    target_content.append("[Global]")
    target_content.append(f"COMPANY={company_folder}")
    target_content.append(f"SOURCE_FILE={source_file}")
    target_content.append(f"SOURCE_MYINI_FILE={source_myini_file}")
    target_content.append(f"MYSQL_BIN={mysql_bin}")
    target_content.append(f"BASE_PATH={base_path}")

    # Step 7: Write the content to the global_variables.ini file
    with open(GLOBAL_VARS_FILE, 'w') as configfile:
        configfile.write("\n".join(target_content))

    print(f"{GLOBAL_VARS_FILE} has been successfully updated.")

# Call the function to update the global variables file
update_global_variables_file()
