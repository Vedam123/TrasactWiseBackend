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

:: Trim leading/trailing spaces from company if any
for /f "delims=" %%a in ("!company!") do set "company=%%a"

:: Step 5: Declare process name and append company value
set "SRVNAME=FlaskServer"
set "SNAME=!company!_%SRVNAME%"

:: Step 6: Find the PID associated with app.exe
for /f "tokens=2" %%i in ('tasklist /FI "IMAGENAME eq app.exe" /NH') do set "PID=%%i"

:: Step 7: Check if the PID is found
if not defined PID (
    echo ERROR: No running app.exe process found.
    exit /b 1
)

:: Step 8: Kill the process using the PID
echo Killing the process with PID: !PID!
taskkill /PID !PID! /F

:: Step 9: Verify if the process was killed
if errorlevel 1 (
    echo Failed to kill the process.
) else (
    echo Process killed successfully.
)

:: End of script
endlocal
