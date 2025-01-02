import os
import subprocess
import glob

# Set the path to the folder containing the Python script (similar to %~dp0 in Batch)
BATCH_DIR = os.path.dirname(os.path.abspath(__file__))
SQL_FILES_DIR = os.path.join(BATCH_DIR, "scripts", "create")
INSTANCES_DIR = os.path.join(BATCH_DIR, "..", "..", "db_instances")

# Ensure INSTANCES_DIR is an absolute path
INSTANCES_DIR = os.path.abspath(INSTANCES_DIR)

# Print directories for debugging purposes
print(f"Batch Directory: {BATCH_DIR}")
print(f"SQL Files Directory: {SQL_FILES_DIR}")
print(f"Instances Directory: {INSTANCES_DIR}")

# Check if instances directory exists
if not os.path.exists(INSTANCES_DIR):
    print(f"Error: The instances directory does not exist!")
    exit(1)

# Temporary file for storing sorted SQL files
TEMP_FILE = os.path.join(BATCH_DIR, "sorted_sql_files.txt")

# Remove existing TEMP_FILE if it exists
if os.path.exists(TEMP_FILE):
    print("Deleting existing temporary file...")
    os.remove(TEMP_FILE)

# Identify all .sql files and extract sequence numbers
print("Identifying SQL files and extracting sequence numbers...")
with open(TEMP_FILE, "w") as temp_file:
    for sql_file in glob.glob(os.path.join(SQL_FILES_DIR, "*.sql")):
        filename = os.path.basename(sql_file)
        seq_number = filename[:4]  # Extract the first 4 characters as sequence number
        
        if seq_number.isdigit():
            print(f"Found file: {sql_file}, Sequence number: {seq_number}")
            temp_file.write(f"{seq_number} \"{sql_file}\"\n")

# Sort the temporary file by the sequence number
print("Sorting the SQL files by their sequence numbers...")
with open(TEMP_FILE, "r") as file:
    lines = file.readlines()

# Sort lines by the sequence number (first 4 characters)
sorted_lines = sorted(lines, key=lambda x: x.split()[0])

# Write sorted lines back to TEMP_FILE
with open(TEMP_FILE, "w") as file:
    file.writelines(sorted_lines)

# Ask user if they want to process all instances
process_all = input("Do you want to process all instances? (Yes --YES / Any letter): ")

if process_all.strip().lower() in ["yes", "y"]:
    # Process each instance folder in the instances directory
    print(f"Start processing the instances from the directory: {INSTANCES_DIR}")

    for instance_dir in glob.glob(os.path.join(INSTANCES_DIR, "instance*")):
        print(f"START Processing the instance ----------------- {instance_dir} -------------------")

        # Define the path to the instance configuration file
        config_file = os.path.join(instance_dir, ".instance.cnf")
        print(f"Config file for instance {instance_dir}: {config_file}")

        # Initialize variables for each instance
        MYSQL_USER = None
        MYSQL_PASS = None
        MYSQL_HOST = None
        MYSQL_PORT = None

        # Check if the config file exists before reading it
        if not os.path.exists(config_file):
            print(f"Config file {config_file} does not exist, skipping instance {instance_dir}...")
            continue

        # Read the .instance.cnf file and extract the configuration values
        print(f"Reading database configuration from {config_file}...")
        with open(config_file, "r") as f:
            for line in f:
                if "=" in line:
                    key, value = line.split("=", 1)
                    key = key.strip()
                    value = value.strip()
                    if key == "user":
                        MYSQL_USER = value
                    elif key == "password":
                        MYSQL_PASS = value
                    elif key == "host":
                        MYSQL_HOST = value
                    elif key == "port":
                        MYSQL_PORT = value

        # Ensure all MySQL variables are set
        if not all([MYSQL_USER, MYSQL_PASS, MYSQL_HOST, MYSQL_PORT]):
            print(f"Error: Missing MySQL configuration for instance {instance_dir}.")
            continue

        # Test MySQL connection (Ping) without --defaults-file
        print(f"Testing MySQL connection for instance {instance_dir}...")
        mysql_ping = subprocess.run(
            ["mysqladmin", "-u", MYSQL_USER, "-p" + MYSQL_PASS, "-h", MYSQL_HOST, "-P", str(MYSQL_PORT), "ping"],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )
        
        if mysql_ping.returncode != 0:
            print(f"Error: Cannot connect to MySQL for instance {instance_dir}.")
            print(f"stderr: {mysql_ping.stderr.decode()}")  # Print detailed error message from stderr
            continue

        # Execute SQL files in sorted order
        print(f"Running SQL files for instance {instance_dir}...")
        with open(TEMP_FILE, "r") as temp_file:
            for line in temp_file:
                seq_number, file_path = line.split(" ", 1)
                file_path = file_path.strip()[1:-1]  # Remove surrounding quotes

                print(f"Sequence Number: {seq_number}")
                print(f"File Path: {file_path}")

                if not os.path.exists(file_path):
                    print(f"Error: File {file_path} does not exist.")
                    continue

                # Execute SQL file without using --defaults-file
                mysql_command = [
                    "mysql", "-u", MYSQL_USER, "-p" + MYSQL_PASS, "-h", MYSQL_HOST, "-P", str(MYSQL_PORT), "-e", f"source {file_path}"
                ]
                result = subprocess.run(mysql_command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

                if result.returncode != 0:
                    with open("error.log", "a") as error_log:
                        error_log.write(f"Error encountered FOR instance {instance_dir} while executing {file_path}\n")
                    print(f"Error encountered FOR instance {instance_dir} while executing {file_path}")
                    continue

                print(f"Executed SQL file: {file_path}")

        print(f"Disconnected from MySQL for instance {instance_dir}.")

else:
    # If user does not want to process all instances, ask for specific instance
    instance_name = input("Enter the instance name to process (e.g., instance0, instance1): ")
    config_file = os.path.join(INSTANCES_DIR, instance_name, ".instance.cnf")

    if os.path.exists(os.path.join(INSTANCES_DIR, instance_name)):
        print(f"START Processing the instance ----------------- {instance_name} -------------------")
        print(f"Config file for instance {instance_name}: {config_file}")

        # Initialize variables for the specified instance
        MYSQL_USER = None
        MYSQL_PASS = None
        MYSQL_HOST = None
        MYSQL_PORT = None

        # Check if the config file exists before reading it
        if not os.path.exists(config_file):
            print(f"Config file {config_file} does not exist, skipping instance {instance_name}...")
            exit(1)

        # Read the .instance.cnf file and extract the configuration values
        print(f"Reading database configuration from {config_file}...")
        with open(config_file, "r") as f:
            for line in f:
                if "=" in line:
                    key, value = line.split("=", 1)
                    key = key.strip()
                    value = value.strip()
                    if key == "user":
                        MYSQL_USER = value
                    elif key == "password":
                        MYSQL_PASS = value
                    elif key == "host":
                        MYSQL_HOST = value
                    elif key == "port":
                        MYSQL_PORT = value

        # Ensure all MySQL variables are set
        if not all([MYSQL_USER, MYSQL_PASS, MYSQL_HOST, MYSQL_PORT]):
            print(f"Error: Missing MySQL configuration for instance {instance_name}.")
            exit(1)

        # Test MySQL connection (Ping) without --defaults-file
        print(f"Testing MySQL connection for instance {instance_name}...")
        mysql_ping = subprocess.run(
            ["mysqladmin", "-u", MYSQL_USER, "-p" + MYSQL_PASS, "-h", MYSQL_HOST, "-P", str(MYSQL_PORT), "ping"],
            stdout=subprocess.PIPE,
            stderr=subprocess.PIPE
        )

        if mysql_ping.returncode != 0:
            print(f"Error: Cannot connect to MySQL for instance {instance_name}.")
            exit(1)

        # Execute SQL files in sorted order
        print(f"Running SQL files for instance {instance_name}...")
        with open(TEMP_FILE, "r") as temp_file:
            for line in temp_file:
                seq_number, file_path = line.split(" ", 1)
                file_path = file_path.strip()[1:-1]  # Remove surrounding quotes

                print(f"Sequence Number: {seq_number}")
                print(f"File Path: {file_path}")

                if not os.path.exists(file_path):
                    print(f"Error: File {file_path} does not exist.")
                    continue

                # Execute SQL file without using --defaults-file
                mysql_command = [
                    "mysql", "-u", MYSQL_USER, "-p" + MYSQL_PASS, "-h", MYSQL_HOST, "-P", str(MYSQL_PORT), "-e", f"source {file_path}"
                ]
                result = subprocess.run(mysql_command, stdout=subprocess.PIPE, stderr=subprocess.PIPE)

                if result.returncode != 0:
                    with open("error.log", "a") as error_log:
                        error_log.write(f"Error encountered while executing {file_path}\n")
                    print(f"Error encountered while executing {file_path}")
                    continue

                print(f"Executed SQL file: {file_path}")
    else:
        print(f"The specified instance directory does not exist: {os.path.join(INSTANCES_DIR, instance_name)}")

print("Process completed successfully.")
