@echo off 
REM This batch script creates the necessary instance folders under the dynamic root directory.
REM It grants full permissions to all users and assumes that the batch file is placed in the correct location.

REM Enable delayed variable expansion
setlocal enabledelayedexpansion

REM Get the directory where the batch file is located
set BATCH_DIR=%~dp0
echo Batch Directory : %BATCH_DIR%

REM Set the root directory where instances will be created based on the batch file location
set GRANDPARENT_DIR=%BATCH_DIR%..\..
echo Grand Parent Directory : %GRANDPARENT_DIR%

set ROOT_DIR=%BATCH_DIR%..\..\db_instances
echo Root Directory : %ROOT_DIR%

REM Define the INI configuration file path based on the batch file location
set INI_FILE=%BATCH_DIR%cnf\00_config.ini
echo Ini file Directory : %INI_FILE%

REM Check if the instances directory exists. If not, create it.
if not exist "%ROOT_DIR%" (
    echo Directory %ROOT_DIR% does not exist. Creating %ROOT_DIR%...
    mkdir "%ROOT_DIR%"
    echo Created %ROOT_DIR%.
) else (
    echo Directory %ROOT_DIR% already exists.
)

REM Read the instances value from the INI file
for /f "tokens=1,2 delims==" %%A in ('findstr /i "instances" "%INI_FILE%"') do set "instances=%%B"

REM Remove any spaces or quotes from the input (robust cleaning)
set instances=%instances:"=%
set instances=%instances: =%

REM Debug: Print the values of instances
echo Debug: instances=%instances%

REM Validate that the instances value is a valid number
setlocal enabledelayedexpansion
set /a check=%instances% 2>nul
if !errorlevel! neq 0 (
    echo Invalid number of instances. Please check the INI file.
    exit /b
)

REM Loop through the instances and create the required subfolders
for /L %%i in (0,1,%instances%) do (
    REM Check if the instance folder already exists in the INI file
    findstr /i "INSTANCE%%i=" "%INI_FILE%" >nul
    echo Inside the for loop
    if %errorlevel%==0 (
        REM Define folder structure for each instance
        set INSTANCE_DIR=%ROOT_DIR%\instance%%i
        set DATA_DIR=!INSTANCE_DIR!\data
        set LOGS_DIR=!INSTANCE_DIR!\logs
        set UPLOADS_DIR=!INSTANCE_DIR!\uploads
        
        echo Instance directory %INSTANCE_DIR%

        REM Create the instance folder and subfolders
        echo Creating folder structure for instance %%i...

        REM Create the instance and its subfolders
        mkdir "!INSTANCE_DIR!" >nul 2>&1
        mkdir "!DATA_DIR!" >nul 2>&1
        mkdir "!LOGS_DIR!" >nul 2>&1
        mkdir "!UPLOADS_DIR!" >nul 2>&1

        REM Check if the folders are created successfully
        if exist "!INSTANCE_DIR!" (
            echo Instance folder created: !INSTANCE_DIR!
        ) else (
            echo Failed to create instance folder: !INSTANCE_DIR!
        )
        if exist "!DATA_DIR!" (
            echo Data folder created: !DATA_DIR!
        ) else (
            echo Failed to create data folder: !DATA_DIR!
        )
        if exist "!LOGS_DIR!" (
            echo Logs folder created: !LOGS_DIR!
        ) else (
            echo Failed to create logs folder: !LOGS_DIR!
        )
        if exist "!UPLOADS_DIR!" (
            echo Uploads folder created: !UPLOADS_DIR!
        ) else (
            echo Failed to create uploads folder: !UPLOADS_DIR!
        )

        REM Grant full access permissions to all users for the created folders and subfolders
        echo Granting full access to all users for the folder: !INSTANCE_DIR!
        icacls "!INSTANCE_DIR!" /grant Everyone:(F) >nul 2>&1
        echo Full permissions granted for: !INSTANCE_DIR!

        echo Granting full access to all users for the folder: !DATA_DIR!
        icacls "!DATA_DIR!" /grant Everyone:(F) >nul 2>&1
        echo Full permissions granted for: !DATA_DIR!

        echo Granting full access to all users for the folder: !LOGS_DIR!
        icacls "!LOGS_DIR!" /grant Everyone:(F) >nul 2>&1
        echo Full permissions granted for: !LOGS_DIR!

        echo Granting full access to all users for the folder: !UPLOADS_DIR!
        icacls "!UPLOADS_DIR!" /grant Everyone:(F) >nul 2>&1
        echo Full permissions granted for: !UPLOADS_DIR!
    ) else (
        echo Instance %%i already exists in the INI file. Skipping folder creation.
    )
)

echo.
echo All folders and permissions have been successfully created for %instances% instances.