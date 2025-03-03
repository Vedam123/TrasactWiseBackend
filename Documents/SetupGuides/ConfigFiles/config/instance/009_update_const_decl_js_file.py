import os
import re

# Define file paths
current_dir = os.path.dirname(os.path.realpath(__file__))
cnf_dir = os.path.join(current_dir, "cnf")
config_file = os.path.join(cnf_dir, "00_config.ini")

grandparent_dir = os.path.abspath(os.path.join(current_dir, os.pardir, os.pardir))
target_dir = os.path.join(grandparent_dir, "application", "WebClient", "src", "modules", "admin", "setups")
const_decl_file = os.path.join(target_dir, "ConstDecl.js")

if os.path.exists(cnf_dir):
    print('"cnf" folder exists in the current directory.')
    
    if os.path.exists(config_file):
        print(f"{config_file} file exists in the 'cnf' folder.")
        
        instance_folders = {}
        instance_names = {}
        company_value = None
        
        with open(config_file, "r") as file:
            current_section = None
            for line in file:
                line = line.strip()
                if line.startswith("[") and line.endswith("]"):
                    current_section = line[1:-1]
                elif current_section == "MySQL" and "=" in line:
                    key, value = line.split("=")
                    if key.strip() == "Company":
                        company_value = value.strip()
                elif current_section == "InstanceFolders" and "=" in line:
                    key, value = line.split("=")
                    instance_folders[key.strip()] = value.strip()
                elif current_section == "InstanceNames" and "=" in line:
                    key, value = line.split("=")
                    instance_names[key.strip()] = value.strip()

        print(f"Parsed Company: {company_value}")
        print(f"Parsed Instance Folders: {instance_folders}")
        print(f"Parsed Instance Names: {instance_names}")
        
        instances_block = 'export const ENV_INSTANCES = [\n'
        for i, (folder_key, folder_value) in enumerate(instance_folders.items(), start=1):
            instance_name_key = f"INSTANCE_NAME{folder_key[-1]}"
            disname = instance_names.get(instance_name_key, "Unknown")
            instances_block += f'  {{ instance: "{folder_value}", company: "{company_value}", disname: "{disname}", status: "Active", sequence: {i} }},\n'
        
        # Adding the hardcoded extra row
        instances_block += f'  {{ instance: "remotedb", company: "{company_value}", disname: "REMOTEDB", status: "Active", sequence: 100 }}\n'
        instances_block += '];'
        
        print(f"INSTANCES BLOCK:\n{instances_block}")
        
        if os.path.exists(const_decl_file):
            with open(const_decl_file, 'r') as file:
                content = file.read()
            
            updated_content = re.sub(r'export const ENV_INSTANCES = \[.*?\];', instances_block, content, flags=re.DOTALL)
            
            with open(const_decl_file, 'w') as file:
                file.write(updated_content)
            
            print("ENV_INSTANCES updated successfully.")
        else:
            print(f"ERROR: The file {const_decl_file} does not exist.")
    else:
        print(f"ERROR: The {config_file} file does not exist in the 'cnf' folder.")
else:
    print('ERROR: The "cnf" folder does not exist in the current directory.')