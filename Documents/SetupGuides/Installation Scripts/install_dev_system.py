import os
import configparser
import shutil
import string
import tkinter as tk
from tkinter import ttk, messagebox

# Config File Path (Inside Start Directory)
START_DIR = os.path.join(os.getcwd(), "Start")
CONFIG_FILE = os.path.join(START_DIR, "config.ini")

class CustomConfigParser(configparser.ConfigParser):
    def optionxform(self, optionstr):
        return optionstr  # Preserve case

    def write(self, fp):
        for section in self.sections():
            fp.write(f"[{section}]\n")
            for option, value in self.items(section):
                fp.write(f"{option}={value}\n")
            fp.write("\n")

# Get available drives
def get_available_drives():
    return [f"{d}:" for d in string.ascii_uppercase if os.path.exists(f"{d}:\\")]

# Read config.ini and get company_folder name
def get_company_folder():
    config = CustomConfigParser()
    if os.path.exists(CONFIG_FILE):
        config.read(CONFIG_FILE)
        return config.get("Global", "company_folder", fallback="Company_X")
    return "Company_1"

# Update config.ini
def update_config(selected_drive):
    config = CustomConfigParser()
    if os.path.exists(CONFIG_FILE):
        config.read(CONFIG_FILE)
        
        base_path = f"{selected_drive}\\SAS Opera\\Companies"
        db_path = f"{selected_drive}:/SAS Opera/Companies"
        
        config.set("Global", "BASE_PATH", base_path)
        config.set("Global", "DB_INSTANCES_BASE_PATH", db_path)
        
        with open(CONFIG_FILE, "w", encoding="utf-8") as configfile:
            config.write(configfile)
    
    return base_path, db_path

# Ensure necessary directories exist
def ensure_directories(selected_drive, company_folder):
    base_dir = os.path.join(selected_drive + "\\", "SAS Opera")
    start_dir = os.path.join(base_dir, "Start")
    companies_dir = os.path.join(base_dir, "Companies")
    company_folder_dir = os.path.join(start_dir, company_folder)
    
    os.makedirs(base_dir, exist_ok=True)
    os.makedirs(start_dir, exist_ok=True)
    os.makedirs(companies_dir, exist_ok=True)
    os.makedirs(company_folder_dir, exist_ok=True)
    
    return company_folder_dir
    
def copy_start_contents(company_folder_dir):
    for item in os.listdir(START_DIR):
        src_path = os.path.join(START_DIR, item)
        dest_path = os.path.join(company_folder_dir, item)
        if os.path.isdir(src_path):
            shutil.copytree(src_path, dest_path, dirs_exist_ok=True)
        else:
            shutil.copy2(src_path, dest_path)
            
# GUI Function
def start_gui():
    def on_next():
        selected_drive = drive_var.get()
        if not selected_drive:
            messagebox.showerror("Error", "Please select a drive!")
            return
        
        company_folder = get_company_folder()
        base_path, db_path = update_config(selected_drive)  # Ensure the config is updated
        company_folder_dir = ensure_directories(selected_drive, company_folder)
        copy_start_contents(company_folder_dir)

        # Output the directory path so the batch file can use it
        print(company_folder_dir)

        root.quit()

    root = tk.Tk()
    root.title("Installation Setup")
    root.geometry("300x150")
    
    tk.Label(root, text="Select Drive:").pack(pady=5)
    drive_var = tk.StringVar()
    drive_dropdown = ttk.Combobox(root, textvariable=drive_var, values=get_available_drives())
    drive_dropdown.pack(pady=5)
    drive_dropdown.current(0)
    
    ttk.Button(root, text="Next", command=on_next).pack(pady=10)
    root.mainloop()

if __name__ == "__main__":
    start_gui()
