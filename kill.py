import psutil

# Loop through all running processes
for proc in psutil.process_iter(['pid', 'name']):
    try:
        # If the process is a Python process
        if 'python' in proc.info['name'].lower():
            print(f"Killing process {proc.info['name']} with PID {proc.info['pid']}")
            proc.terminate()  # Terminates the process
    except (psutil.NoSuchProcess, psutil.AccessDenied):
        pass  # Some processes might have already terminated or access might be denied
