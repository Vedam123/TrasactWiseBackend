@echo off
:: Check if the script is running as Administrator
NET SESSION >nul 2>&1
if %errorlevel% NEQ 0 (
    echo This script requires Administrator privileges. Restarting as Administrator...
    :: Request administrator privileges
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

REM This batch script starts a MySQL service for each instance.
REM It reads the company name, gcname, and the number of instances from the 00_config.ini file.

REM Enable delayed variable expansion
setlocal enabledelayedexpansion

REM Get the directory where the batch file is located
set BATCH_DIR=%~dp0
echo Batch Directory : %BATCH_DIR%

REM Traverse up the directory to find the SAS Opera root directory
set ROOT_DIR=%BATCH_DIR%..\..\db_instances
echo Root Directory : %ROOT_DIR%

REM Check if ROOT_DIR exists, if not exit with a comment
if not exist "%ROOT_DIR%" (
    echo Root directory "%ROOT_DIR%" does not exist. Exiting the script.
    exit /b
)

REM Define the cnf directory (which is in the same directory as the batch file)
set CNF_DIR=%BATCH_DIR%cnf

REM Define the global_variables.ini file path
set GLOBAL_VARS_FILE=%CNF_DIR%\global_variables.ini

REM Read the MYSQL_BIN value from the global_variables.ini file
for /f "tokens=1,2 delims==" %%A in ('findstr /i "MYSQL_BIN" "%GLOBAL_VARS_FILE%"') do set "MYSQL_BIN=%%B"

REM Debug: Print the value of MYSQL_BIN before checking existence
echo Debug: MYSQL_BIN="%MYSQL_BIN%"

REM Remove any leading and trailing spaces
for /f "tokens=* delims=" %%a in ("%MYSQL_BIN%") do set "MYSQL_BIN=%%a"

REM Debug: Trimmed MYSQL_BIN
echo Debug: Trimmed MYSQL_BIN="%MYSQL_BIN%"

REM Check if the source file exists
if not exist "%MYSQL_BIN%" (
    echo There is no variable like "%MYSQL_BIN%" in the file %GLOBAL_VARS_FILE%
    exit /b
)

REM Set the config file for instances
set CONFIG_FILE=%BATCH_DIR%cnf\00_config.ini
echo Config file directory %CONFIG_FILE%

REM Read the company name, gcname, and instances from the INI file
for /f "tokens=1,2 delims==" %%A in ('findstr /i "gcname" "%CONFIG_FILE%"') do set "gcname=%%B"
for /f "tokens=1,2 delims==" %%A in ('findstr /i "name=" "%CONFIG_FILE%"') do set "company=%%B"
for /f "tokens=1,2 delims==" %%A in ('findstr /i "instances" "%CONFIG_FILE%"') do set "instances=%%B"

REM Remove any spaces or quotes from the input
set gcname=%gcname:"=% 
set gcname=%gcname: =%
set company=%company:"=% 
set company=%company: =%
set instances=%instances:"=% 
set instances=%instances: =%

REM Debug: Print the values of gcname, company, and instances
echo Debug: gcname=%gcname%
echo Debug: company=%company%
echo Debug: instances=%instances%

REM Validate that the instances value is a valid number
setlocal enabledelayedexpansion
set /a check=%instances% 2>nul
if !errorlevel! neq 0 (
    echo Invalid number of instances. Please check the INI file.
    exit /b
)

echo You entered a valid gcname: %gcname%
echo You entered a valid company name: %company%
echo You entered a valid number of instances: %instances%

REM Loop through the instances and start the service for each instance
for /L %%i in (0,1,%instances%) do (
    REM Define the service name for each instance
    if %%i==0 (
        REM Use gcname for instance0
        set SERVICE_NAME=%gcname%_instance%%i
    ) else (
        REM Use company for other instances
        set SERVICE_NAME=%company%_instance%%i
    )

    REM Check if the service exists and is running
    sc query !SERVICE_NAME! | findstr /i "RUNNING" >nul
    if !errorlevel! equ 0 (
        REM The service is already running
        echo Service !SERVICE_NAME! is already running. Skipping start.
    ) else (
        REM The service is not running, start it
        echo Starting service !SERVICE_NAME!...
        sc start !SERVICE_NAME!

        REM Check if the service started successfully
        if !errorlevel! equ 0 (
            echo Service !SERVICE_NAME! started successfully.
        ) else (
            echo Failed to start service !SERVICE_NAME!.
        )
    )
)

echo.
echo All operations have been processed.
