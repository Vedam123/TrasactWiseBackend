import os
import shutil
import configparser

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

# 4. Identify grandparent's parent directory (great-grandparent)
GREAT_GRAND_PAR_DIR = os.path.dirname(GRAND_PAR_DIR)
GREAT_GRAND_PAR_DIR_NAME = os.path.basename(GREAT_GRAND_PAR_DIR)
print(f"Great-grandparent directory: {GREAT_GRAND_PAR_DIR}")
print(f"Great-grandparent directory name: {GREAT_GRAND_PAR_DIR_NAME}")

# 5. Check if db_instances directory exists
DB_INST_DIR = os.path.join(GRAND_PAR_DIR, 'db_instances')
DB_INST_DIR_NAME = 'db_instances'

if os.path.isdir(DB_INST_DIR):
    print(f"DB instances directory: {DB_INST_DIR}")
    print(f"DB instances directory name: {DB_INST_DIR_NAME}")
else:
    print("db_instances directory not found.")
    exit(1)

# 6. Check if cnf subdirectory exists
CNF_DIR = os.path.join(CURR_DIR, 'cnf')
CNF_DIR_NAME = 'cnf'

if os.path.isdir(CNF_DIR):
    print(f"CNF directory: {CNF_DIR}")
    print(f"CNF directory name: {CNF_DIR_NAME}")
else:
    print("cnf directory not found.")
    exit(1)

# 7. Read globals_variable.ini
globals_file = os.path.join(CNF_DIR, 'global_variables.ini')
config = configparser.ConfigParser()

# Read the file and check for any issues
config.read(globals_file)

# Debugging: Print available sections and check if 'Global' section is present
print(f"Sections found in globals_variables.ini: {config.sections()}")

# Check if 'Global' section exists and handle error gracefully
if 'Global' in config:
    SOURCE_MYINI_FILE = config['Global'].get('SOURCE_MYINI_FILE')
    BASE_PATH = config['Global'].get('BASE_PATH')
    print(f"Source file (my.ini): {SOURCE_MYINI_FILE}")
    print(f"Base path: {BASE_PATH}")
else:
    print("Error: 'Global' section is missing in globals_variables.ini")
    exit(1)

# 8. Count the number of subdirectories in DB_INST_DIR
INST_DIR_COUNT = len([name for name in os.listdir(DB_INST_DIR) if os.path.isdir(os.path.join(DB_INST_DIR, name))])
print(f"Number of instance directories: {INST_DIR_COUNT}")

config_file = os.path.join(CNF_DIR, '00_config.ini')
config.read(config_file)

# 9. Define ports list for each instance
# Define the ports for each instance (the length should match the INST_DIR_COUNT)
ports = [config['MySQL'].get(f'port{i}') for i in range(INST_DIR_COUNT)]
print(f"Ports for each instance: {ports}")

# 10. Single loop to handle both copy and update
for i in range(INST_DIR_COUNT):
    instance_dir = os.path.join(DB_INST_DIR, f'instance{i}')
    my_ini_file = os.path.join(instance_dir, 'my.ini')
    
    if os.path.isdir(instance_dir):
        # If the my.ini file does not exist, copy it and then update it
        if not os.path.isfile(my_ini_file):  # Only copy if my.ini does not exist
            shutil.copy(SOURCE_MYINI_FILE, instance_dir)
            print(f"Copied my.ini to {instance_dir}")

            # After copying, update the my.ini file
            with open(my_ini_file, 'r') as file:
                lines = file.readlines()

            # Store the subdirectory's name
            CURR_INST_DIR_NAME = os.path.basename(instance_dir)
            CURR_INST_DATA_DIR = os.path.join(instance_dir, 'data')

            # Update port, mysqlx_port, datadir, secure-file-priv, general_log_file, log-error
            new_lines = []
            for line in lines:
                # Update port (only update 'port' line)
                if line.strip().startswith('port='):
                    new_lines.append(f"port={ports[i]}\n")
                # Update mysqlx_port (ensure it gets a separate treatment)
                elif line.strip().startswith('mysqlx_port='):
                    new_lines.append(f"mysqlx_port={int(ports[i])}0\n")  # Append '0' to the port value for mysqlx_port
                # Update datadir
                elif line.strip().startswith('datadir='):
                    new_lines.append(f"datadir={BASE_PATH}/{GREAT_GRAND_PAR_DIR_NAME}/{GRAND_PAR_DIR_NAME}/{DB_INST_DIR_NAME}/{CURR_INST_DIR_NAME}/data\n")
                # Update secure-file-priv
                elif line.strip().startswith('secure-file-priv='):
                    new_lines.append(f"secure-file-priv={BASE_PATH}/{GREAT_GRAND_PAR_DIR_NAME}/{GRAND_PAR_DIR_NAME}/{DB_INST_DIR_NAME}/{CURR_INST_DIR_NAME}/Uploads\n")
                # Update general_log_file
                elif line.strip().startswith('general_log_file='):
                    new_lines.append(f"general_log_file={CURR_INST_DIR_NAME}.log\n")
                # Update log-error
                elif line.strip().startswith('log-error='):
                    new_lines.append(f"log-error={CURR_INST_DIR_NAME}.err\n")
                else:
                    new_lines.append(line)

            # Write the updated contents back to my.ini
            with open(my_ini_file, 'w') as file:
                file.writelines(new_lines)

            # Create directories if necessary
            os.makedirs(os.path.join(instance_dir, 'Uploads'), exist_ok=True)
            os.makedirs(CURR_INST_DATA_DIR, exist_ok=True)
            print(f"Updated my.ini in {instance_dir}")
        
        else:
            print(f"my.ini already exists in {instance_dir}, skipping copy and update.")
