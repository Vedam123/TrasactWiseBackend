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

:: Step 5: Check if the PM2 process is running
echo Checking PM2 process: %pm2_name%...

:: Run pm2 list and look for the process
npx pm2 list | findstr /I "%pm2_name%" >nul
if errorlevel 1 (
    echo The PM2 process "%pm2_name%" is NOT running.
    echo Here is the full PM2 list for your reference:
    npx pm2 list
    exit /b 1
)

:: Display the process details
echo Displaying process details for: %pm2_name%
npx pm2 list | findstr /I "%pm2_name%"

:: Step 6: Extract the PID (6th token) from the pm2 list output
for /f "tokens=12" %%i in ('npx pm2 list ^| findstr /I "%pm2_name%"') do set "pid=%%i"
echo Extracted PID: !pid!

:: Step 7: Check if PID is greater than 0
if !pid! gtr 0 (
    :: Step 8: Display the full netstat output for debugging
    echo Running netstat -ano to check connections for PID !pid!...
    netstat -ano | findstr /i "!pid!"

    :: Step 9: Find the port associated with the PID using netstat
    echo Finding the port for PID !pid!...
    for /f "tokens=2 delims=:" %%a in ('netstat -ano ^| findstr /i "!pid!"') do (
        set "port=%%a"
        echo Found port: !port!
    )
) else (
    echo The server is not running or the PID is invalid.
)

:: Wait for the user to acknowledge before closing
echo Waiting for 5 seconds...before closing the window
timeout /t 5 /nobreak >nul

endlocal
