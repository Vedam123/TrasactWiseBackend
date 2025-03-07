import os
import configparser
import subprocess

CONFIG_FILE = "config.ini"  # Path to config.ini file

def run_git_command(directory, command):
    """Run a Git command in the specified directory and return output."""
    try:
        result = subprocess.run(command, cwd=directory, shell=True, text=True, capture_output=True)
        return result.stdout.strip()
    except Exception as e:
        print(f"Error executing {command} in {directory}: {e}")
        return None

def setup_git_environment():
    """Read config.ini and set up Git environment for AppService and WebClient."""
    config = configparser.ConfigParser()
    config.optionxform = str  # Preserve key casing
    config.read(CONFIG_FILE, encoding="utf-8")

    # Read git credentials and repository details
    git_clone_type = config["gitcreds"].get("git_clone_type", "").strip()
    backend_rep = config["gitcreds"].get("backend_rep", "").strip()
    frontend_rep = config["gitcreds"].get("frontend_rep", "").strip()

    # Proceed only if git_clone_type is Development
    if git_clone_type != "Development":
        print("Git environment setup is only for Development.")
        return

    # Construct base path
    base_path = config["Global"].get("BASE_PATH", "").strip()
    company_folder = config["Global"].get("company_folder", "").strip()
    full_path = os.path.join(base_path, company_folder, "system", "application")

    # Paths to AppService and WebClient
    appservice_path = os.path.join(full_path, "AppService")
    webclient_path = os.path.join(full_path, "WebClient")

    # Verify and update Git remotes for both repositories
    for repo_path, expected_remote in [(appservice_path, backend_rep), (webclient_path, frontend_rep)]:
        if not os.path.exists(repo_path):
            print(f"Directory not found: {repo_path}")
            continue

        print(f"\nSetting up Git environment in: {repo_path}")

        # Check current Git remote
        remote_output = run_git_command(repo_path, "git remote -v")
        if expected_remote in remote_output:
            print(f"Git remote is already set correctly for {repo_path}.")
        else:
            print(f"Updating Git remote for {repo_path}...")
            run_git_command(repo_path, f"git remote set-url origin {expected_remote}")

        # Run required Git commands
        print(run_git_command(repo_path, "git branch -vv"))
        print(run_git_command(repo_path, "git fetch origin"))
        print(run_git_command(repo_path, "git pull origin main"))

if __name__ == "__main__":
    setup_git_environment()
