import psutil
import os

# Function to stop the Flask process
def stop_flask_server():
    # Get the current process ID (PID)
    pid = os.getpid()
    
    # Check and terminate the process
    for proc in psutil.process_iter(attrs=['pid', 'name']):
        if proc.info['pid'] == pid:
            proc.terminate()

# Call the function to stop
stop_flask_server()
