@echo off
REM Get the current directory of the batch file
REM Before running this batch file , you need to ensure the services of source instance and target instances are stopped 
REM After successful execution of this batch file you need to manually start those services 
SET SCRIPT_DIR=%~dp0
SET PYTHON_SCRIPT=%SCRIPT_DIR%00_clone_instances_python.py

REM Check if the Python script exists in the current directory
IF EXIST "%PYTHON_SCRIPT%" (
    echo Python script found, running the script...
    REM Run the Python script
    python "%PYTHON_SCRIPT%"
) ELSE (
    echo Python script not found in the current directory.
)

pause
