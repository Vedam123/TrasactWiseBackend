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
if not defined company (
    echo ERROR: COMPANY value not found in global_variables.ini
    exit /b 1
)

:: Step 5: Read the BASE_PATH value from global_variables.ini
for /f "tokens=2 delims==" %%b in ('findstr "BASE_PATH=" "%ini_file%"') do set "base_path=%%b"
if not defined base_path (
    echo ERROR: BASE_PATH value not found in global_variables.ini
    exit /b 1
)

:: Trim leading/trailing spaces
for /f "delims=" %%a in ("!company!") do set "company=%%a"
for /f "delims=" %%b in ("!base_path!") do set "base_path=%%b"

:: Step 6: Construct dynamic paths
set "company_path=%base_path%\%company%"
set "application_path=%company_path%\system\application"
set "webclient_path=%application_path%\WebClient"
set "appservice_path=%application_path%\AppService"
set "data_path=%company_path%\system\data"
set "config_path=%company_path%\system\config"
set "cnf_path=%config_path%\cnf"

:: Step 7: Echo paths
echo Application Path: %company%\system\application
echo WebClient Path: %company%\system\application\WebClient
echo AppService Path: %company%\system\application\AppService
echo Data Path: %company%\system\data
echo Config Path: %company%\system\config
echo CNF Path: %company%\system\config\cnf

echo Debug: Final AppService Path: %appservice_path%
echo Debug: Final WebClient Path: %webclient_path%

:: Step 8: Activate Python Virtual Environment
set "venv_path=%appservice_path%\erpenv\Scripts\activate.bat"
if not exist "%venv_path%" (
    echo ERROR: Virtual environment activation script not found at %venv_path%
    exit /b 1
)

call "%venv_path%"
if errorlevel 1 (
    echo ERROR: Failed to activate the Python virtual environment.
    exit /b 1
)


echo Python virtual environment activated successfully.

echo The current directory is: %CD%

cd /d "%appservice_path%"



:: Step 10: Ensure 'dist' Directory Exists
set "dist_path=%appservice_path%\dist"
if not exist "%dist_path%" (
    echo ERROR: 'dist' directory was not created.
    exit /b 1
)

echo 'dist' directory is already present at: %dist_path%

:: Step 11: Start the Python Flask Server
cd /d "%dist_path%"
if errorlevel 1 (
    echo ERROR: Failed to change directory to dist.
    exit /b 1
)

set SRVNAME=FlaskServer
set SNAME=!company!_%SRVNAME%

wscript.exe "%current_dir%992_PROD_Flask_Start.vbs" "!SNAME!"
if errorlevel 1 (
    echo ERROR: Failed to start Python - Flask Server.
    pause >nul
    exit /b 1
)

echo Successfully started Python - Flask Server.
timeout /t 5 /nobreak >nul
exit

endlocal
