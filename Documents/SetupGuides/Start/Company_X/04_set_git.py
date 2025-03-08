import os
import configparser
import logging
import subprocess

CONFIG_FILE = "config.ini"  # The path to config.ini in the same directory
LOG_FILE = "setup_log.txt"  # Log file name

# Configure logging
script_dir = os.path.dirname(os.path.abspath(__file__))  # Get the script's directory
log_file_path = os.path.join(script_dir, LOG_FILE)
logging.basicConfig(
    filename=log_file_path,
    level=logging.INFO,
    format="%(asctime)s - %(levelname)s - %(message)s",
    encoding="utf-8",
)

def run_git_command(directory, command):
    """Run a Git command in the specified directory and return output."""
    try:
        result = subprocess.run(command, cwd=directory, shell=True, text=True, capture_output=True)
        logging.info(f"Executed command '{command}' in {directory}. Output: {result.stdout.strip()}")
        return result.stdout.strip()
    except Exception as e:
        logging.error(f"Error executing {command} in {directory}: {e}")
        return None

def setup_git_environment():
    """Read config.ini and set up Git environment for AppService and WebClient."""
    logging.info("Starting Git environment setup.")
    config = configparser.ConfigParser()
    config.optionxform = str  # Preserve key casing
    config.read(CONFIG_FILE, encoding="utf-8")

    git_clone_type = config["gitcreds"].get("git_clone_type", "").strip()
    backend_rep = config["gitcreds"].get("backend_rep", "").strip()
    frontend_rep = config["gitcreds"].get("frontend_rep", "").strip()

    if git_clone_type != "Development":
        logging.info("Git environment setup is only for Development mode. Exiting.")
        return

    base_path = config["Global"].get("BASE_PATH", "").strip()
    company_folder = config["Global"].get("company_folder", "").strip()
    full_path = os.path.join(base_path, company_folder, "system", "application")

    appservice_path = os.path.join(full_path, "AppService")
    webclient_path = os.path.join(full_path, "WebClient")

    for repo_path, expected_remote in [(appservice_path, backend_rep), (webclient_path, frontend_rep)]:
        if not os.path.exists(repo_path):
            logging.warning(f"Directory not found: {repo_path}")
            continue

        logging.info(f"Setting up Git environment in: {repo_path}")

        remote_output = run_git_command(repo_path, "git remote -v")
        if expected_remote in remote_output:
            logging.info(f"Git remote is already set correctly for {repo_path}.")
        else:
            logging.info(f"Updating Git remote for {repo_path}...")
            run_git_command(repo_path, f"git remote set-url origin {expected_remote}")

        logging.info(run_git_command(repo_path, "git branch -vv"))
        logging.info(run_git_command(repo_path, "git fetch origin"))
        logging.info(run_git_command(repo_path, "git pull origin main"))

    logging.info("Git environment setup completed.")

if __name__ == "__main__":
    setup_git_environment()
