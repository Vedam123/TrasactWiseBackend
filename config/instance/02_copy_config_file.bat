@echo off
REM This batch script copies the my.ini file to each instance directory.
REM It reads the number of instances from the config file and copies the file to each instanceX directory.

REM Get the directory where the batch file is located
set BATCH_DIR=%~dp0

REM Define the cnf directory (which is in the same directory as the batch file)
set CNF_DIR=%BATCH_DIR%cnf

REM Define the global_variables.ini file path
set GLOBAL_VARS_FILE=%CNF_DIR%\global_variables.ini

REM Read the SOURCE_FILE value from the global_variables.ini file
for /f "tokens=1,2 delims==" %%A in ('findstr /i "SOURCE_FILE" "%GLOBAL_VARS_FILE%"') do set "SOURCE_FILE=%%B"

REM Debug: Print the value of SOURCE_FILE before checking existence
echo Debug: SOURCE_FILE="%SOURCE_FILE%"

REM Remove any leading and trailing spaces
for /f "tokens=* delims=" %%a in ("%SOURCE_FILE%") do set "SOURCE_FILE=%%a"

REM Debug: Trimmed SOURCE_FILE
echo Debug: Trimmed SOURCE_FILE="%SOURCE_FILE%"

REM Check if the source file exists
if not exist "%SOURCE_FILE%" (
    echo There is no variable like "%SOURCE_FILE%" in the file %GLOBAL_VARS_FILE%
    exit /b
)

REM Set the root directory where instances are located (relative to the batch file directory)
set ROOT_DIR=%BATCH_DIR%..\..\db_instances
echo Root directory %ROOT_DIR%
echo Batch directory %BATCH_DIR%

REM Set the config file for instances
set CONFIG_FILE=%BATCH_DIR%cnf\00_config.ini
echo Config file directory %CONFIG_FILE%

REM Read the instances value from the INI file
for /f "tokens=1,2 delims==" %%A in ('findstr /i "instances" "%CONFIG_FILE%"') do set "instances=%%B"

REM Remove any spaces or quotes from the input
set instances=%instances:"=% 
set instances=%instances: =%

REM Debug: Print the value of instances and SOURCE_FILE
echo Debug: instances=%instances%
echo Debug: SOURCE_FILE=%SOURCE_FILE%

REM Validate that the instances value is a valid number
setlocal enabledelayedexpansion
set /a check=%instances% 2>nul
if !errorlevel! neq 0 (
    echo Invalid number of instances. Please check the INI file.
    exit /b
)

echo You entered a valid number: %instances%

REM Loop through the instances and copy the my.ini file to each instance
for /L %%i in (0,1,%instances%) do (
    REM Define the target directory for each instance
    set INSTANCE_DIR=%ROOT_DIR%\instance%%i

    REM Use delayed expansion to properly evaluate INSTANCE_DIR during the loop
    if exist "!INSTANCE_DIR!" (
        echo Copying my.ini to: !INSTANCE_DIR!
        copy "%SOURCE_FILE%" "!INSTANCE_DIR!\my.ini" >nul
        if !errorlevel! equ 0 (
            echo my.ini successfully copied to !INSTANCE_DIR!
        ) else (
            echo Failed to copy my.ini to !INSTANCE_DIR!
        )
    ) else (
        echo Instance folder !INSTANCE_DIR! does not exist. Skipping.
    )
)

echo.
echo All files have been processed.
pause
