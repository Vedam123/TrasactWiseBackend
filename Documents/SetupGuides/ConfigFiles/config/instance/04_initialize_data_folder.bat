@echo off
REM This batch script initializes the MySQL data directory for multiple instances.
REM It reads the number of instances from the config file and initializes the data directory for each instance.

REM Enable delayed variable expansion
setlocal enabledelayedexpansion

REM Get the directory where the batch file is located
set BATCH_DIR=%~dp0
echo Batch Directory : %BATCH_DIR%

REM Define the cnf directory (which is in the same directory as the batch file)
set CNF_DIR=%BATCH_DIR%cnf
echo CNF DIRECTORY  : %CNF_DIR%

REM Define the global_variables.ini file path
set GLOBAL_VARS_FILE=%CNF_DIR%\global_variables.ini
echo Global ini files  : %GLOBAL_VARS_FILE%

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

REM Set the root directory where instances will be created based on the batch file location
set GRANDPARENT_DIR=%BATCH_DIR%..\..\
echo Grand Parent Directory : %GRANDPARENT_DIR%

REM Define the INI configuration file path based on the batch file location
set INI_FILE=%BATCH_DIR%cnf\00_config.ini
echo Ini file  Directory : %INI_FILE%


set CONFIG_FILE=%BATCH_DIR%cnf\00_config.ini
echo config file  Directory : %CONFIG_FILE%

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

REM Read the instances value from the INI file
for /f "tokens=1,2 delims==" %%A in ('findstr /i "instances" "%CONFIG_FILE%"') do set "instances=%%B"

REM Remove any spaces or quotes from the input
set instances=%instances:"=% 
set instances=%instances: =%

REM Debug: Print the value of instances
echo Debug: instances=%instances%

REM Validate that the instances value is a valid number
setlocal enabledelayedexpansion
set /a check=%instances% 2>nul
if !errorlevel! neq 0 (
    echo Invalid number of instances. Please check the INI file.
    exit /b
)

echo You entered a valid number: %instances%

REM Loop through the instances and initialize the data directory for each instance
for /L %%i in (0,1,%instances%) do (
    REM Define the paths for my.ini and the data directory
    set "INSTANCE_DIR=%ROOT_DIR%\instance%%i"
    set "DATA_DIR=!INSTANCE_DIR!\data"
    set "MY_CNF=!INSTANCE_DIR!\my.ini"

    REM Check if the instance directory exists
    if exist "!INSTANCE_DIR!" (
        echo Initializing data directory for instance %%i...

        REM Check if the data directory exists, if not, create it
        if not exist "!DATA_DIR!" (
            mkdir "!DATA_DIR!"
            echo Created data directory: !DATA_DIR!
        )

        REM Print the command before executing it
        echo Running command: "%MYSQL_BIN%\mysqld.exe" --initialize --datadir="!DATA_DIR!"

        REM Run MySQL initialization with proper quoting and capture output
        "%MYSQL_BIN%\mysqld.exe" --initialize --datadir="!DATA_DIR!" > "!INSTANCE_DIR!\initialize_log.txt" 2>&1

        REM Check the log file for errors
        findstr /i "error" "!INSTANCE_DIR!\initialize_log.txt" >nul
        if !errorlevel! equ 0 (
            echo Initialization failed. Check the log for details: !INSTANCE_DIR!\initialize_log.txt
        ) else (
            echo Data directory initialized successfully for instance %%i.
        )
    ) else (
        echo Instance folder !INSTANCE_DIR! does not exist. Skipping.
    )
)

echo.
echo All operations have been processed.
pause
