@echo off
:: Check if the script is running as Administrator
NET SESSION >nul 2>&1
if %errorlevel% NEQ 0 (
    echo This script requires Administrator privileges. Restarting as Administrator...
    :: Request administrator privileges
    powershell -Command "Start-Process '%~f0' -Verb runAs"
    exit /b
)

REM This batch script creates a MySQL service for each instance.
REM It reads the company name, gcname, and the number of instances from the 00_config.ini file.

REM Enable delayed variable expansion
setlocal enabledelayedexpansion

REM Get the directory where the batch file is located
set BATCH_DIR=%~dp0
echo Batch Directory : %BATCH_DIR%

set ROOT_DIR=%BATCH_DIR%..\..\db_instances
echo Root Directory : %ROOT_DIR%

REM Check if the instances directory exists. If not, create it.
if not exist "%ROOT_DIR%" (
    echo Directory %ROOT_DIR% does not exist. Creating %ROOT_DIR%...
    mkdir "%ROOT_DIR%"
    echo Created %ROOT_DIR%.
) else (
    echo Directory %ROOT_DIR% already exists.
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

REM Loop through the instances and create the service for each instance
for /L %%i in (0,1,%instances%) do (
    set "INSTANCE_DIR=%ROOT_DIR%\instance%%i"

    REM Check if it's instance0, use gcname for the service name, else use company for other instances
    if %%i==0 (
        set SERVICE_NAME=%gcname%_instance%%i
    ) else (
        set SERVICE_NAME=%company%_instance%%i
    )

    REM Define the path to the my.ini file for each instance
    set MY_CNF=!INSTANCE_DIR!\my.ini

    REM Debug: Print the path of MY_CNF to ensure it's correct
    echo Debug: MY_CNF = !MY_CNF!

REM Check if the instance directory exists
    if exist "!INSTANCE_DIR!" (
        
        REM Check if the service already exists
        sc qc "!SERVICE_NAME!" >nul 2>&1
        if !errorlevel! equ 0 (
            echo Service !SERVICE_NAME! already exists. Skipping creation...
        ) else (
            REM Create the MySQL service for the instance
            echo Creating service !SERVICE_NAME!... 
            "%MYSQL_BIN%\mysqld.exe" --install !SERVICE_NAME! --defaults-file="!MY_CNF!" > "!INSTANCE_DIR!\services_log.txt" 2>&1

            REM Check the log file for errors
            findstr /i "error denied" "!INSTANCE_DIR!\services_log.txt" >nul
            if !errorlevel! equ 0 (
                echo Failed to create service !SERVICE_NAME! for instance %%i.
                type "!INSTANCE_DIR!\services_log.txt"
            ) else (
                echo Service !SERVICE_NAME! created successfully for instance %%i.
            )
        )
    ) else (
        echo Instance folder !INSTANCE_DIR! does not exist. Skipping.
    )
)

echo.
echo All operations have been processed.