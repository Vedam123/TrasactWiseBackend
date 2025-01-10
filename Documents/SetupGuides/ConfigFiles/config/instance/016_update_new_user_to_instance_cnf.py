import os
import configparser
import mysql.connector
from mysql.connector import Error

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

# 6. Loop through each instance folder in DB_INST_DIR
for instance_folder in os.listdir(DB_INST_DIR):
    if instance_folder.startswith('instance'):
        instance_path = os.path.join(DB_INST_DIR, instance_folder)

        # 7. Check if the required files exist in the instance folder
        INST_CONFIG_FILE_NAME = os.path.join(instance_path, '.instance.cnf')
        ROOT_PWD_FILE_NAME = os.path.join(instance_path, 'root_password.ini')  # Updated to root_password.ini

        if os.path.isfile(INST_CONFIG_FILE_NAME) and os.path.isfile(ROOT_PWD_FILE_NAME):
            print(f"Processing {instance_folder}...")

            # 8. Read the instance configuration file (.instance.cnf)
            config = configparser.ConfigParser()
            config.read(INST_CONFIG_FILE_NAME)

            # Extract details from the configuration file
            N_USER = config.get('client', 'user')
            N_HOST = config.get('client', 'host')
            N_PORT = config.get('client', 'port')

            # 9. Read the root password from the root_password.ini file (without section)
            with open(ROOT_PWD_FILE_NAME, 'r') as f:
                R_PWD = f.readline().strip()  # Read the password line and remove any leading/trailing spaces

            print("Root password from the .ini file ", R_PWD)
            
            # Set root user and user password
            R_USER = 'root'
            N_ROOT_PWD = 'trdwelcome'  # New root password
            USER_PWD = f"inst{instance_folder[-1]}welcome"  # Generate the user password (inst0welcome for instance0)

            connection = None
            cursor = None
            try:
                print("HOST NAME TO BE CONNECTED ", N_HOST)
                print("PORT NAME TO BE CONNECTED ", N_PORT)
                print("ROOT USER NAME TO BE CONNECTED ", R_USER)
                print("ROOT PWD TO BE CONNECTED ", R_PWD)

                # Connect to MySQL server with root user and old password
                connection = mysql.connector.connect(
                    host=N_HOST,
                    user=R_USER,
                    password=R_PWD,
                    port=N_PORT
                )

                if connection.is_connected():
                    cursor = connection.cursor()

                    # Create SQL queries
                    alter_root_user_query = f"ALTER USER 'root'@'{N_HOST}' IDENTIFIED BY '{N_ROOT_PWD}';"
                    create_user_query = f"CREATE USER '{N_USER}'@'{N_HOST}' IDENTIFIED BY '{USER_PWD}';"
                    grant_privileges_query = f"GRANT ALL PRIVILEGES ON *.* TO '{N_USER}'@'{N_HOST}' WITH GRANT OPTION;"

                    # Execute the queries
                    cursor.execute(alter_root_user_query)
                    connection.commit()
                    print(f"Root password updated successfully.")

                    # 10. Reconnect to MySQL with the new root password
                    connection.close()  # Close the previous connection

                    # Reconnect with the updated root password
                    connection = mysql.connector.connect(
                        host=N_HOST,
                        user=R_USER,
                        password=N_ROOT_PWD,
                        port=N_PORT
                    )

                    if connection.is_connected():
                        cursor = connection.cursor()

                        # Execute the queries again to create the new user and grant privileges
                        cursor.execute(create_user_query)
                        cursor.execute(grant_privileges_query)
                        connection.commit()

                        print(f"User '{N_USER}' created and privileges granted successfully.")

            except mysql.connector.Error as e:
                # Check if the error is for expired password
                if e.errno == 1862:  # Error code for expired password
                    print("Password expired, attempting to reset it.")
                    try:
                        # Reconnect to MySQL server using the expired password to change it
                        connection = mysql.connector.connect(
                            host=N_HOST,
                            user=R_USER,
                            password=R_PWD,
                            port=N_PORT
                        )
                        cursor = connection.cursor()

                        # Attempt to alter the root password to a new password
                        alter_query = f"ALTER USER 'root'@'localhost' IDENTIFIED BY '{N_ROOT_PWD}';"
                        cursor.execute(alter_query)
                        connection.commit()
                        print(f"Root password updated successfully.")

                        # Now proceed with the rest of the operations (creating the new user, etc.)
                        cursor.execute(create_user_query)
                        cursor.execute(grant_privileges_query)
                        connection.commit()

                        print(f"User '{N_USER}' created and privileges granted successfully.")

                    except mysql.connector.Error as alter_error:
                        print(f"Failed to update root password: {alter_error}")
                else:
                    print(f"Error: {e}")
            finally:
                if connection and connection.is_connected():
                    cursor.close()
                    connection.close()

           # 11. Update the .instance.cnf file with the new password
            config.set('client', 'password', USER_PWD)

            # Manually write the configuration back to the file without spaces around the equal sign
            with open(INST_CONFIG_FILE_NAME, 'w') as configfile:
                for section in config.sections():
                    configfile.write(f"[{section}]\n")
                    for option in config.options(section):
                        # Write the option and value without space around '='
                        configfile.write(f"{option}={config.get(section, option)}\n")

            print(f"Updated password for user '{N_USER}' in {INST_CONFIG_FILE_NAME}.")


        else:
            print(f"Required files not found for {instance_folder}. Skipping...")
