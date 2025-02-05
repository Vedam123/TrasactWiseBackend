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

:: Step 8: Change directory to WebClient and echo the directory, then start Node.js server with pm2
cd /d "%appservice_path%\dist"
if errorlevel 1 (
    echo ERROR: Failed to change directory to AppServe: %appservice_path%
    exit /b 1
)
echo Changed directory to dist in the path: %appservice_path%
echo Python server

:: Declare SRVNAME and SNAME
set SRVNAME=FlaskServer
set SNAME=!company!_%SRVNAME%

:: Call the vbs script with the SNAME parameter
wscript.exe "%current_dir%993_PROD_Flask_Start.vbs" "!SNAME!"

if errorlevel 1 (
    echo Failed to Start Python - Flask Server.
    echo Press any key to exit...
    pause >nul
    exit /b 1
) else (
    echo Successfully started Python - Flask Server.
    echo Closing in 5 seconds...
    timeout /t 5 /nobreak >nul
    exit
)

echo The execution is completed

endlocal
