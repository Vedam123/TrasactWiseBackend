import os
import subprocess

# Define the list of batch files to run (you can add more batch files here in the future)
batch_files = [
    "201_reset_root_password.bat",
    "202_update_new_user_to_instance_cnf.bat",
]

# Get the current directory where the batch files are located
curr_dir = os.path.dirname(os.path.abspath(__file__))
print(f"Current directory: {curr_dir}")

# Loop through each batch file in the list
for batch_file in batch_files:
    batch_file_path = os.path.join(curr_dir, batch_file)
    
    print(f"\nChecking if {batch_file} exists...")
    
    # Check if the batch file exists
    if os.path.exists(batch_file_path):
        print(f"Found {batch_file}. Running it...")
        
        # Run the batch file using subprocess
        result = subprocess.run([batch_file_path], shell=True)
        
        # Check if the batch file ran successfully
        if result.returncode == 0:
            print(f"Successfully completed {batch_file}.")
        else:
            print(f"Error occurred while running {batch_file}. Continuing to next file.")
    else:
        print(f"{batch_file} not found. Skipping.")

print("\nAll specified batch files have been processed.")
