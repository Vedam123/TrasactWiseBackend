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

:: Trim leading/trailing spaces from company variable
for /f "delims=" %%a in ("!company!") do set "company=%%a"

:: Define the PM2 process name (same as in the startup script)
set "pm2_name=%company%_WebClient"

:: Step 5: Stop and delete the PM2 process
echo Stopping PM2 process: %pm2_name%...
npx pm2 stop "%pm2_name%"
npx pm2 delete "%pm2_name%"

if errorlevel 1 (
    echo ERROR: Failed to stop and delete PM2 process: %pm2_name%.
    echo Press any key to exit...
    pause >nul
    exit /b 1
) else (
    echo Successfully stopped and deleted PM2 process: %pm2_name%.
)

:: Optional: Remove PM2 startup script (comment out if you don’t want this)
echo Removing PM2 startup setup...
npx pm2 unstartup

echo All PM2 processes stopped and startup settings removed.
echo Press any key to exit...
pause >nul

endlocal
