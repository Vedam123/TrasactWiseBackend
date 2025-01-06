@echo off
setlocal

REM Store the current directory in a variable
set CURRENT_DIR=%cd%

REM Display the current directory
echo Current directory is: %CURRENT_DIR%

REM Check if Python is installed by checking if the "python" command is available
python --version >nul 2>&1

REM If Python is installed, the exit code will be 0, otherwise, it will be non-zero
if %ERRORLEVEL% NEQ 0 (
    echo Error: Python is not installed on this system.
    echo Please install Python from https://www.python.org/
    pause
    exit /b 1
)

REM Check if the script file exists in the expected path
set SCRIPT_PATH=%~dp011_find_root_pwd_of_my_sql.py

echo Checking if the script exists at: %SCRIPT_PATH%

REM If the file doesn't exist, show an error message and exit
if not exist "%SCRIPT_PATH%" (
    echo Error: Script not found at %SCRIPT_PATH%.
    pause
    exit /b 1
)

REM If Python is installed and the script is present, run the script
echo Python is installed. Running find_root_pwd_of_my_sql.py script...

python "%SCRIPT_PATH%"

REM Check if the script executed successfully
if %ERRORLEVEL% NEQ 0 (
    echo Error: find_root_pwd_of_my_sql.py encountered an issue during execution.
    pause
    exit /b 1
)

echo Script completed successfully.
pause
