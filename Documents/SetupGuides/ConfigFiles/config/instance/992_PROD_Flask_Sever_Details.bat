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

:: Step 7: Display process details for 10 seconds
echo Checking for process: !SNAME!
tasklist /FI "IMAGENAME eq app.exe"

:: Step 8: Find port and PID associated with app.exe
echo Checking the port and PID associated with app.exe...
for /f "tokens=1,2,3,4,*" %%a in ('netstat -ano ^| findstr "LISTENING" ^| findstr "app.exe"') do (
    echo PID: %%a
    echo Local Address VEDAM: %%b
    echo Foreign Address: %%c
    echo State: %%d
    echo PID Associated with app.exe: %%e
)

echo Checking the port and PID associated with app.exe...
for /f "tokens=1,2,3,4,*" %%a in ('netstat -ano ^| findstr "LISTENING" ^| findstr "!PID!"') do (
    echo PID: %%a
    echo Local Address: %%b
    echo Foreign Address: %%c
    echo State: %%d
    echo PID Associated with app.exe: %%e
)

echo Displaying the process for 10 seconds...
timeout /t 10 /nobreak >nul

:: End of script
echo 10 seconds have passed. Exiting...
endlocal
