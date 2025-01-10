@echo off
REM This batch file runs the Python script to update .instance.cnf files in the db_instances directory.

REM Change to the directory where the script is located (the current directory in this case)
cd /d "%~dp0"

REM Ensure Python is available in the PATH
python --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Python is not installed or not added to the PATH.
    exit /b 1
)

REM Run the Python script
python 014_update_every_instance_file.py

REM Check if the script ran successfully
if %errorlevel% neq 0 (
    echo The Python script encountered an error during execution.
) else (
    echo The Python script executed successfully.
)

REM Pause the command prompt to see any output
pause
