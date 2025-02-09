@echo off
setlocal enabledelayedexpansion

:: Step 1: Get the path of the batch file
set "current_dir=%~dp0"
set "log_file=%current_dir%script_log.txt"

:: Create or clear the log file
echo ==== Script Execution Log (Started at %DATE% %TIME%) ==== > "%log_file%"

:: Function to log and display messages
call :log "Debug: The batch file is located at: %current_dir%"

:: Step 2: Define the path to the global_variables.ini file
set "ini_file=%current_dir%cnf\global_variables.ini"
call :log "Debug: Looking for global_variables.ini at: %ini_file%"

:: Step 3: Check if the ini file exists
if not exist "%ini_file%" (
    call :log "ERROR: The file global_variables.ini was not found at: %ini_file%"
    exit /b 1
)

:: Step 4: Read the COMPANY value from global_variables.ini
for /f "tokens=2 delims==" %%a in ('findstr "COMPANY=" "%ini_file%"') do set "company=%%a"

:: Check if the COMPANY value was found
if not defined company (
    call :log "ERROR: COMPANY value not found in global_variables.ini"
    exit /b 1
)

:: Trim leading/trailing spaces from company variable
for /f "delims=" %%a in ("!company!") do set "company=%%a"

:: Define the PM2 process name (same as in the startup script)
set "pm2_name=%company%_WebClient"
call :log "Stopping PM2 process: %pm2_name%..."

:: Step 5: Stop and delete the PM2 process
npx pm2 stop "%pm2_name%" >> "%log_file%" 2>&1
npx pm2 delete "%pm2_name%" >> "%log_file%" 2>&1

if errorlevel 1 (
    call :log "ERROR: Failed to stop and delete PM2 process: %pm2_name%."
    call :log "Press any key to exit..."
    pause >nul
    exit /b 1
) else (
    call :log "Successfully stopped and deleted PM2 process: %pm2_name%."
)

:: Optional: Remove PM2 startup script (comment out if you don’t want this)
call :log "Removing PM2 startup setup..."
npx pm2 unstartup >> "%log_file%" 2>&1

:: Call the PowerShell script in the same directory and pass the keyword as a parameter
call :log "Executing PowerShell script to kill stuck processes..."
powershell.exe -ExecutionPolicy Bypass -File "%current_dir%991_PROD_KILL_STUCK_PROCESSES.ps1" -keyword "%company%" >> "%log_file%" 2>&1

call :log "All PM2 processes stopped and startup settings removed."
call :log "Press any key to exit..."
pause >nul

endlocal
exit /b

:: Function to log messages
:log
echo %~1
echo %~1 >> "%log_file%"
exit /b
