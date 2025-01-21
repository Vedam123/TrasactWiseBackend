import os
import re

# Define file paths
current_dir = os.path.dirname(os.path.realpath(__file__))
cnf_dir = os.path.join(current_dir, "cnf")
config_file = os.path.join(cnf_dir, "00_config.ini")

# Target directory and file
grandparent_dir = os.path.abspath(os.path.join(current_dir, os.pardir, os.pardir))
target_dir = os.path.join(grandparent_dir, "application", "WebClient", "src", "modules", "admin", "setups")
const_decl_file = os.path.join(target_dir, "ConstDecl.js")

# Check if "cnf" folder exists
if os.path.exists(cnf_dir):
    print('"cnf" folder exists in the current directory.')

    # Check if CONFIG_FILE exists
    if os.path.exists(config_file):
        print(f"{config_file} file exists in the 'cnf' folder.")

        # Parse INSTANCE Folders and INSTANCE Names
        instance_folders = {}
        instance_names = {}
        
        with open(config_file, "r") as file:
            current_section = None
            for line in file:
                line = line.strip()
                if line.startswith("[") and line.endswith("]"):
                    current_section = line[1:-1]
                elif current_section == "InstanceFolders" and "=" in line:
                    key, value = line.split("=")
                    instance_folders[key.strip()] = value.strip()
                elif current_section == "InstanceNames" and "=" in line:
                    key, value = line.split("=")
                    instance_names[key.strip()] = value.strip()

        # Now we have instance_folders and instance_names dictionaries
        print(f"Parsed Instance Folders: {instance_folders}")
        print(f"Parsed Instance Names: {instance_names}")

        # Construct the INSTANCES_BLOCK with 'disname' from InstanceNames
        instances_block = 'export const ENV_INSTANCES = [\n'
        for i, (folder_key, folder_value) in enumerate(instance_folders.items(), start=1):
            # Get the corresponding display name (disname) from InstanceNames
            instance_name_key = f"INSTANCE_NAME{folder_key[-1]}"  # Assuming the key format is INSTANCE0, INSTANCE1, etc.
            disname = instance_names.get(instance_name_key, "Unknown")
            
            instances_block += f'  {{ instance: "{folder_value}", company: "Company_4", disname: "{disname}", status: "Active", sequence: {i} }},\n'
        
        instances_block = instances_block.rstrip(',\n') + "\n];"
        
        print(f"INSTANCES BLOCK:\n{instances_block}")

        # Read the content of the ConstDecl.js file
        if os.path.exists(const_decl_file):
            with open(const_decl_file, 'r') as file:
                content = file.read()

            # Replace the ENV_INSTANCES block in the ConstDecl.js file
            updated_content = re.sub(r'export const ENV_INSTANCES = \[.*?\];', instances_block, content, flags=re.DOTALL)

            # Write the updated content back to the ConstDecl.js file
            with open(const_decl_file, 'w') as file:
                file.write(updated_content)

            print("ENV_INSTANCES updated successfully.")
        else:
            print(f"ERROR: The file {const_decl_file} does not exist.")
    else:
        print(f"ERROR: The {config_file} file does not exist in the 'cnf' folder.")
else:
    print('ERROR: The "cnf" folder does not exist in the current directory.')
