import os
import shutil
import psutil
import configparser
import subprocess
import time
import sys
import re

def read_ini_file():
    config = configparser.ConfigParser()
    config.read('00_clone_instances_input.ini')
    
    source_instance = config.get('InstancesForCloning', 'SOURCE_INSTANCE')
    target_instance = config.get('InstancesForCloning', 'TARGET_INSTANCE')
    
    return source_instance, target_instance

def stop_service(service_name):
    """
    Stops a service using the sc command on Windows.
    """
    try:
        print(f"Attempting to stop service: {service_name}")
        subprocess.run(['sc', 'stop', service_name], check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        print(f"Service {service_name} stopped successfully.")
    except subprocess.CalledProcessError as e:
        print(f"Error stopping service {service_name}: {e}")

def is_service_running(service_name):
    """
    Checks if a service is running using the sc query command.
    """
    try:
        result = subprocess.run(['sc', 'qc', service_name], check=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
        output = result.stdout.decode('utf-8')
        if "STATE" in output and "RUNNING" in output:
            return True
        return False
    except subprocess.CalledProcessError:
        return False

def check_and_stop_services(source_instance, target_instance, grand_par_dir_name):
    # Generate service names for source and target instances
    source_service = f"{grand_par_dir_name}_{source_instance}"
    target_service = f"{grand_par_dir_name}_{target_instance}"
    
    print(f"Checking if services {source_service} and {target_service} are running...")

    # Stop the source service if it's running
    if is_service_running(source_service):
        print(f"Stopping service: {source_service}")
        stop_service(source_service)
    
    # Stop the target service if it's running
    if is_service_running(target_service):
        print(f"Stopping service: {target_service}")
        stop_service(target_service)

    # Wait for the services to fully stop
    max_wait_time = 60  # Increased wait time for services to stop
    elapsed_time = 0
    while elapsed_time < max_wait_time:
        source_running = is_service_running(source_service)
        target_running = is_service_running(target_service)
        
        if not source_running and not target_running:
            print("Both services stopped successfully.")
            return  # Services are stopped, continue execution
        
        print(f"Waiting for services to stop... Elapsed time: {elapsed_time} seconds.")
        time.sleep(2)  # Sleep for 2 seconds to avoid constant polling
        elapsed_time += 2

    # After max wait time, check again and exit if services are still running
    source_running = is_service_running(source_service)
    target_running = is_service_running(target_service)
    if source_running or target_running:
        print(f"Error: {source_service} or {target_service} are still running after waiting for {max_wait_time} seconds.")
        sys.exit(1)

def safely_remove_file(file_path):
    """
    Safely removes a file, retrying if it is locked.
    """
    try:
        os.remove(file_path)
        print(f"Deleted file: {file_path}")
    except PermissionError as e:
        print(f"PermissionError: File is in use: {file_path}. Skipping file.")
    except Exception as e:
        print(f"Failed to delete {file_path}: {str(e)}")

def find_directories(source_instance, target_instance):
    # Step 1: Find the current directory and store its path and name
    curr_dir = os.getcwd()
    curr_dir_name = os.path.basename(curr_dir)

    # Step 2: Find the parent directory and db_instances directory
    par_dir = os.path.dirname(curr_dir)
    par_dir_name = os.path.basename(par_dir)
    db_inst_dir = os.path.join(par_dir, 'db_instances')
    db_inst_dir_name = 'db_instances'

    # Step 3: Find the grandparent directory and its name
    grand_par_dir = os.path.dirname(par_dir)
    grand_par_dir_name = os.path.basename(grand_par_dir)

    # Step 4: Get the paths of SOURCE_INSTANCE and TARGET_INSTANCE
    source_instance_dir = os.path.join(db_inst_dir, source_instance)
    target_instance_dir = os.path.join(db_inst_dir, target_instance)

    return curr_dir, curr_dir_name, par_dir, par_dir_name, db_inst_dir, db_inst_dir_name, grand_par_dir, grand_par_dir_name, source_instance_dir, target_instance_dir

def get_port_value_from_ini(target_instance_dir):
    my_ini_file = os.path.join(target_instance_dir, 'my.ini')
    port_value = None
    
    # Read the my.ini file and extract the port value
    with open(my_ini_file, 'r') as f:
        for line in f:
            if line.strip().startswith('port='):
                port_value = line.split('=')[1].strip()
                break
    print("Extracted port value:", port_value)

    return port_value

def update_port_in_instance_cnf(target_instance_dir, port_value):
    instance_cnf_file = os.path.join(target_instance_dir, '.instance.cnf')
    
    if os.path.exists(instance_cnf_file):
        with open(instance_cnf_file, 'r') as f:
            content = f.read()

        # Look for the 'port' line in the file, and update its value if it exists.
        # This matches lines like 'port=5206' or 'port = 5206', allowing spaces around the equal sign.
        port_pattern = r'^\s*port\s*=\s*\d+'
        
        if re.search(port_pattern, content, re.MULTILINE):
            # Replace the existing port value with the new one
            content = re.sub(port_pattern, f'port = {port_value}', content, flags=re.MULTILINE)
        else:
            # If no port line exists, append a new one at the end
            content += f"\nport = {port_value}"

        # Write the updated content back to the .instance.cnf file
        with open(instance_cnf_file, 'w') as f:
            f.write(content)

        print(f"Port updated to {port_value} in {instance_cnf_file}.")
    else:
        print(f"File {instance_cnf_file} does not exist.")

def main():
    source_instance, target_instance = read_ini_file()
    
    # Unpack all 9 values returned by `find_directories`
    curr_dir, curr_dir_name, par_dir, par_dir_name, db_inst_dir, db_inst_dir_name, grand_par_dir, grand_par_dir_name, source_instance_dir, target_instance_dir = find_directories(source_instance, target_instance)
    
    # Check if services are running and stop them if necessary
    check_and_stop_services(source_instance, target_instance, grand_par_dir_name)
    
    # Capture the port value from my.ini file in the TARGET_INSTANCE directory
    cp_port = get_port_value_from_ini(target_instance_dir)

    # Delete all files and subdirectories in the TARGET_INSTANCE directory (except for my.ini)
    for root, dirs, files in os.walk(target_instance_dir, topdown=False):
        for name in files:
            if name != 'my.ini':
                safely_remove_file(os.path.join(root, name))
        for name in dirs:
            if name != 'my.ini':
                shutil.rmtree(os.path.join(root, name))

    # Copy files from SOURCE_INSTANCE to TARGET_INSTANCE director            
    for item in os.listdir(source_instance_dir):
        if item != 'my.ini':  # Exclude my.ini from being copied
            s = os.path.join(source_instance_dir, item)
            d = os.path.join(target_instance_dir, item)
            if os.path.isdir(s):
                shutil.copytree(s, d, dirs_exist_ok=True)
            else:
                shutil.copy2(s, d)
            

    # Update port in .instance.cnf file (if it exists)
    update_port_in_instance_cnf(target_instance_dir, cp_port)

    # Start both services again (code for starting services can go here)
    print(f"Starting services for {source_instance} and {target_instance}")

if __name__ == "__main__":
    main()
