import os
from flask import current_app
from config import PROJECT_MAIN_MODULES_DIRECTORY_NAME
from modules.utilities.logger import logger  # Import the logger module

MODULE_NAME = __name__

def find_file_folder(file_path):
    try:
        root_directory = current_app.root_path
        modules_path = os.path.join(root_directory, PROJECT_MAIN_MODULES_DIRECTORY_NAME)

        # Normalize paths for comparison
        normalized_file_path = os.path.normpath(file_path)
        normalized_modules_path = os.path.normpath(modules_path)

        if normalized_file_path.startswith(normalized_modules_path):
            relative_path = os.path.relpath(normalized_file_path, normalized_modules_path)
            module_folder = relative_path.split(os.path.sep)[0]
            logger.info(f"{MODULE_NAME}: The module name is --> {module_folder}")
            return module_folder

        # If the file is not located within the modules_path
        return None

    except Exception as e:
        logger.error(f"{MODULE_NAME}: Error: {str(e)}")
        return None
