import os
import subprocess

# Set the current directory (use the directory of the script if needed)
current_dir = os.getcwd()

# Get a list of all batch files in the current directory
batch_files = [f for f in os.listdir(current_dir) if f.endswith('.bat')]

# List to store valid batch files
valid_batch_files = []

# Loop through each file and check the prefix
for filename in batch_files:
    # Extract the first 3 characters of the filename
    prefix = filename[:3]
    
    # Check if the first 3 characters are numeric and less than or equal to 100
    if prefix.isdigit():
        num_prefix = int(prefix)
        if 800 <= num_prefix < 900:
            valid_batch_files.append(filename)

# Log file path
log_file = os.path.join(current_dir, 'BATCH100_LOG.txt')

# Open the log file for appending results
with open(log_file, 'a') as log:
    log.write(f"Execution started at {os.path.basename(__file__)}\n")
    
    # Loop through the valid batch files and execute them
    for batch_file in valid_batch_files:
        # Log the file that will be executed
        log.write(f"\nStarting execution of: {batch_file}\n")
        print(f"Running {batch_file}...")
        
        # Construct the full path of the batch file
        batch_file_path = os.path.join(current_dir, batch_file)
        
        try:
            # Run the batch file using subprocess
            result = subprocess.run(batch_file_path, shell=True, stdout=subprocess.PIPE, stderr=subprocess.PIPE, text=True)

            # Check if execution was successful
            if result.returncode == 0:
                log.write(f"Successfully executed: {batch_file}\n")
                print(f"{batch_file} executed successfully.")
            else:
                log.write(f"Error executing {batch_file}. Error: {result.stderr}\n")
                print(f"Error executing {batch_file}. See log for details.")
        except Exception as e:
            log.write(f"Exception occurred while executing {batch_file}: {str(e)}\n")
            print(f"Exception occurred while executing {batch_file}. See log for details.")
        
        # Log file completion status
        log.write(f"Execution completed for: {batch_file}\n")
        print(f"{batch_file} execution completed.")
    
    log.write("\nExecution completed for all batch files.\n")
    print("All batch files executed.")
