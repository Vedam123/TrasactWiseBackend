@echo off
REM Check if Python is installed and accessible
python --version >nul 2>&1
IF %ERRORLEVEL% NEQ 0 (
    echo Python is not installed or not added to the PATH.
    pause
    exit /b
)

REM Get the current directory of the batch file
SET CURR_DIR=%~dp0

REM Check if the Python script exists in the current directory
IF NOT EXIST "%CURR_DIR%013_instance_file_to_instances.py" (
    echo Python script not found in the current directory.
    pause
    exit /b
)

REM Run the Python script
echo Running the Python script...
python "%CURR_DIR%013_instance_file_to_instances.py"

