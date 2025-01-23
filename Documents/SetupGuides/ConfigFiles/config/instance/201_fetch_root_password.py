import os
import sys

def fetch_password(FOLDER_DIR_NAME):
    """
    Function to read the password from the root_password.ini file located in the FOLDER_DIR_NAME subdirectory.
    
    :param FOLDER_DIR_NAME: The subdirectory name within which the root_password.ini file is located.
    :return: The password value extracted from the root_password.ini file.
    """
    # Step 1: Identify the current directory and resolve the paths
    CURR_DIR = os.getcwd()
    PARENT_DIR = os.path.dirname(CURR_DIR)
    GRAND_PAR_DIR = os.path.dirname(PARENT_DIR)
    GREAT_GRAND_PAR_DIR = os.path.dirname(GRAND_PAR_DIR)
    
    # Define the db_instances directory path
    DB_INST_DIR = os.path.join(GRAND_PAR_DIR, 'db_instances')
    
    # Step 2: Construct the path for the root_password.ini
    folder_path = os.path.join(DB_INST_DIR, FOLDER_DIR_NAME)  # Subdirectory within db_instances
    file_path = os.path.join(folder_path, 'root_password.ini')
    
    # Step 3: Validate if the root_password.ini file exists
    if not os.path.isfile(file_path):
        print(f"Error: {file_path} does not exist.")
        return None
    
    print(f"Reading from: {file_path}")  # Debugging print

    # Step 4: Read the file and extract the password value
    with open(file_path, 'r') as file:
        lines = file.readlines()
        
        # Step 5: Search for the 'password=' line and extract the password value
        for line in lines:
            print(f"Line: {line.strip()}")  # Debugging print
            if 'password' in line.lower():  # Check for case-insensitive 'password'
                # Split only on the first '='
                parts = line.split('=', 1)  
                
                if len(parts) > 1:
                    password = parts[1].strip()  # Strip leading/trailing spaces from the password part
                    print(f"Password found: {password}")  # Debugging print
                    return password
                
    # Step 6: Handle case where no password line is found
    print("Error: No password found in root_password.ini.")
    return None

# Example usage
if __name__ == "__main__":
    # Check if the script was called with the correct argument (the folder name)
    if len(sys.argv) < 2:
        print("Error: Missing folder directory name argument.")
        sys.exit(1)
    
    folder_dir_name = sys.argv[1]  # Get the folder directory name passed from the batch script
    password = fetch_password(folder_dir_name)  # Corrected function name
    
    if password:
        print(password)  # Only print the password for the batch script to capture
    else:
        print("Failed to extract the password.")
