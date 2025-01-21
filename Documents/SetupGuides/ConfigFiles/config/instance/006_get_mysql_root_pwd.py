import os
import re

def find_root_password_in_err_file(err_file_path):
    """Read the .err file and extract the root password."""
    try:
        with open(err_file_path, 'r', encoding='utf-8') as file:
            content = file.read()
            # Regex to find the temporary password (e.g., 'A temporary password is generated for root@localhost: :bfXda>*=9jk')
            match = re.search(r"A temporary password is generated for root@localhost:\s*([^\s]+)", content)

            if match:
                return match.group(1)  # Extract password
    except Exception as e:
        print(f"Error reading file {err_file_path}: {e}")
    return None

def process_instance_directory(instance_dir):
    """Process each instance directory, check for .err file, and extract password."""
    root_password_file = os.path.join(instance_dir, 'root_password.ini')
    
    # Check if root_password.ini file already exists
    if os.path.exists(root_password_file):
        print(f"Skipping {instance_dir} as root_password.ini already exists. so no update is done to existing file ")
        return  # Skip processing this instance if the file already exists
    
    data_dir = os.path.join(instance_dir, 'data')
    if os.path.isdir(data_dir):
        print(f"Processing {data_dir}...")  # Log the data directory being processed
        found_password = False  # Track if a password was found
        # Check for .err file in the data folder
        for root, dirs, files in os.walk(data_dir):
            for file in files:
                if file.endswith('.err'):
                    err_file_path = os.path.join(root, file)
                    print(f"Found .err file: {err_file_path}")  # Log the .err file found
                    password = find_root_password_in_err_file(err_file_path)
                    if password:
                        print(f"Extracted password: {password}")
                        # Save the password in the format Password=<password> with no spaces around '='
                        with open(root_password_file, 'w', encoding='utf-8') as password_file:
                            password_file.write(f"password={password}\n")
                        print(f"Password written to {root_password_file}")
                        found_password = True
                        break  # Stop once password is found for this instance
        if not found_password:
            print(f"No password found for {instance_dir}. No .err file or password in .err file.")
    else:
        print(f"No 'data' folder found in {instance_dir}. Skipping.")

def main():
    # Get the current directory
    current_dir = os.getcwd()
    print(f"Current Directory: {current_dir}")

    # Get the parent directory
    parent_dir = os.path.abspath(os.path.join(current_dir, os.pardir))
    print(f"Parent Directory: {parent_dir}")
    
    # Get the Grand parent directory
    grand_parent_dir = os.path.abspath(os.path.join(parent_dir, os.pardir))
    print(f"Grand Parent Directory: {grand_parent_dir}")

    # Check if db_instances folder exists in the grand parent directory
    db_instances_dir = os.path.join(grand_parent_dir, 'db_instances')
    if os.path.isdir(db_instances_dir):
        print(f"Found db_instances directory: {db_instances_dir}")

        # Loop through all subdirectories in db_instances (e.g., instance0, instance1, ...)
        instance_folders = [folder for folder in os.listdir(db_instances_dir) if os.path.isdir(os.path.join(db_instances_dir, folder))]
        instance_folders.sort()  # Sort the instance folders (e.g., instance0, instance1...)

        if instance_folders:
            print(f"Found {len(instance_folders)} instances: {instance_folders}")
            # Process each instance
            for instance_folder in instance_folders:
                instance_dir = os.path.join(db_instances_dir, instance_folder)
                print(f"Processing {instance_dir}...")
                process_instance_directory(instance_dir)
        else:
            print("No instance folders found.")
    else:
        print(f"db_instances folder not found in {grand_parent_dir}")

if __name__ == "__main__":
    main()
