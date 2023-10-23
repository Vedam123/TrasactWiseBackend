# logger.py

import os
import logging
from datetime import datetime
from config import BACKEND_ENVIRONMENT, LOG_FILE_PATH, ENABLE_DETAILED_LOGS

# Perform log file existence check and creation during application initialization
log_directory = LOG_FILE_PATH
os.makedirs(log_directory, exist_ok=True)
current_date = datetime.now().strftime("%Y-%m-%d")
log_file = os.path.join(log_directory, f"app_{current_date}.log")
if not os.path.isfile(log_file):
    open(log_file, 'w').close()

# Create and configure the logger
logger = logging.getLogger(__name__)

environment = BACKEND_ENVIRONMENT

if environment == "Development" and ENABLE_DETAILED_LOGS:
    log_level = logging.DEBUG
elif environment == "Test" and ENABLE_DETAILED_LOGS:
    log_level = logging.INFO
else:
    log_level = logging.CRITICAL
print(log_level,"LOG LEVEL")
logger.setLevel(log_level)
formatter = logging.Formatter('%(asctime)s - %(levelname)s - %(message)s', datefmt='%Y-%m-%d %H:%M:%S')
fh = logging.FileHandler(log_file, mode='a')  # Use 'a' for append mode
fh.setLevel(log_level)
fh.setFormatter(formatter)
logger.addHandler(fh)
