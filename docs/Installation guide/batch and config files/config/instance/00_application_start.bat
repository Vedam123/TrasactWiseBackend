@echo off
setlocal enabledelayedexpansion

:: Step 1: Get the path of the batch file
set "current_dir=%~dp0"
echo Debug: The batch file is located at: %current_dir%

:: Step 2: Define the path to the global_variables.ini file
set "ini_file=%current_dir%cnf\global_variables.ini"
echo Debug: Looking for global_variables.ini at: %ini_file%

:: Step 3: Check if the ini file exists
if not exist "%ini_file%" (
    echo ERROR: The file global_variables.ini was not found at: %ini_file%
    exit /b 1
)

:: Step 4: Read the COMPANY value from global_variables.ini
for /f "tokens=2 delims==" %%a in ('findstr "COMPANY=" "%ini_file%"') do set "company=%%a"
:: Check if the COMPANY value was found
if not defined company (
    echo ERROR: COMPANY value not found in global_variables.ini
    exit /b 1
)

:: Step 5: Read the BASE_PATH value from global_variables.ini
for /f "tokens=2 delims==" %%b in ('findstr "BASE_PATH=" "%ini_file%"') do set "base_path=%%b"
:: Check if the BASE_PATH value was found
if not defined base_path (
    echo ERROR: BASE_PATH value not found in global_variables.ini
    exit /b 1
)

:: Trim leading/trailing spaces from company and base_path variables if any
for /f "delims=" %%a in ("!company!") do set "company=%%a"
for /f "delims=" %%b in ("!base_path!") do set "base_path=%%b"

:: Step 6: Construct dynamic paths using the BASE_PATH and COMPANY values
set "company_path=%base_path%\%company%"
set "application_path=%company_path%\system\application"
set "webclient_path=%application_path%\WebClient"
set "appservice_path=%application_path%\AppService"
set "data_path=%company_path%\system\data"
set "config_path=%company_path%\system\config"
set "cnf_path=%config_path%\cnf"

:: Step 7: Echo the dynamically constructed paths (Hides the base part of the path)
echo Application Path: %company%\system\application
echo WebClient Path: %company%\system\application\WebClient
echo AppService Path: %company%\system\application\AppService
echo Data Path: %company%\system\data
echo Config Path: %company%\system\config
echo CNF Path: %company%\system\config\cnf

:: Debug: Check the final appservice_path and webclient_path
echo Debug: Final AppService Path: %appservice_path%
echo Debug: Final WebClient Path: %webclient_path%

:: Step 8: Change directory to WebClient and echo the directory, then start Visual Studio Code
cd /d "%webclient_path%"
if errorlevel 1 (
    echo ERROR: Failed to change directory to WebClient: %webclient_path%
    exit /b 1
)
echo Changed directory to WebClient: %webclient_path%
start "" code . >nul 2>&1

:: Step 9: Change directory to AppService and echo the directory, then start Visual Studio Code
cd /d "%appservice_path%"
if errorlevel 1 (
    echo ERROR: Failed to change directory to AppService: %appservice_path%
    exit /b 1
)
echo Changed directory to AppService: %appservice_path%

:: Step 10: Now switch to the virtual environment directory and activate the Python virtual environment
cd /d "%appservice_path%\erpenv\Scripts"
if errorlevel 1 (
    echo ERROR: Failed to change directory to virtual environment: %appservice_path%\erpenv\Scripts
    exit /b 1
)
echo Changed directory to virtual environment Scripts: %appservice_path%\erpenv\Scripts

:: Activate the virtual environment
call activate.bat
if errorlevel 1 (
    echo ERROR: Failed to activate the virtual environment.
    exit /b 1
)
echo Virtual environment activated.

:: Step 11: Change directory back to AppService and start Visual Studio Code if not started yet
cd /d "%appservice_path%"
if errorlevel 1 (
    echo ERROR: Failed to change directory back to AppService: %appservice_path%
    exit /b 1
)
echo Changed directory back to AppService: %appservice_path%

start "" code . >nul 2>&1



endlocal