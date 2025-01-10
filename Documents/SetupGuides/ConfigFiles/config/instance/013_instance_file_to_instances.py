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

# 7. Read instance cnf file
instances_file = os.path.join(CNF_DIR, '.instance.cnf')

# Check if the .instance.cnf file exists
if not os.path.isfile(instances_file):
    print(f"Error: {instances_file} does not exist.")
    exit(1)

# 8. Find all instance folders in the DB_INST_DIR
instance_folders = [folder for folder in os.listdir(DB_INST_DIR) if folder.startswith('instance') and os.path.isdir(os.path.join(DB_INST_DIR, folder))]

if not instance_folders:
    print("No instance folders found in the db_instances directory.")
    exit(1)

# 9. Copy the .instance.cnf file into each instance folder
for instance_folder in instance_folders:
    instance_folder_path = os.path.join(DB_INST_DIR, instance_folder)
    dest_file = os.path.join(instance_folder_path, '.instance.cnf')

    try:
        shutil.copy(instances_file, dest_file)
        print(f"Copied {instances_file} to {dest_file}")
    except Exception as e:
        print(f"Error copying file to {instance_folder_path}: {e}")

print("File copy process completed.")
