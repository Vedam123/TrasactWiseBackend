@echo off
setlocal enabledelayedexpansion

REM Step 1: Identify the current directory and store it in CURR_DIR also identify GP_DIR
echo Identifying the current directory...
set CURR_DIR=%cd%

set LOG_FILE=%CURR_DIR%\setup_log.txt
echo Logging started at %date% %time% > "%LOG_FILE%"

echo Current directory is: %CURR_DIR%  >> "%LOG_FILE%"

:: Extract the name of the current directory
for %%i in ("%CURR_DIR%") do set "CURR_DIR_NAME=%%~nxi"

:: Go up three levels to get the grandparent directory
for %%i in ("%CURR_DIR%") do set "grandparent=%%~dpi"
set "grandparent=%grandparent:~0,-1%"  :: Remove the trailing backslash

:: Go up one more level to reach the grandparent
for %%i in ("%grandparent%") do set "grandparent=%%~dpi"
set "GP_DIR=%grandparent:~0,-1%"  :: Remove the trailing backslash

:: Extract the name of the grandparent directory
for %%i in ("%GP_DIR%") do set "GP_DIR_NAME=%%~nxi"

:: Output the result
echo Current Directory Name: %CURR_DIR_NAME%  >> "%LOG_FILE%"
echo Grandparent Directory: %GP_DIR%
echo Grandparent Directory Name: %GP_DIR_NAME%  >> "%LOG_FILE%"

:: Read the value of the 'ports' from the config.ini file
for /f "tokens=2 delims==" %%a in ('findstr "=" "%CURR_DIR%\%INI_FILE%"') do (
    set ports=%%a
)

echo All ports %ports%  >> "%LOG_FILE%"


:: Store the complete path of config.ini in a variable
set "INI_FILE_PATH=%CURR_DIR%\config.ini"

:: Store the file name (with extension) in a separate variable
for %%i in ("%INI_FILE_PATH%") do set "INI_FILE=%%~nxi"

:: Display the full path and filename of config.ini
echo Full Path of config.ini: %INI_FILE_PATH%  >> "%LOG_FILE%"
echo File Name of config.ini: %INI_FILE%  >> "%LOG_FILE%"

REM Step 3:  Check if the file exists
if not exist "%CURR_DIR%\%INI_FILE%" (
    echo Error: %INI_FILE% not found. Exiting.  >> "%LOG_FILE%"
    exit /b 1
)

REM Step 4: Read values from the user-provided .ini file
echo Reading values from %INI_FILE%...
for /f "tokens=1,2 delims==" %%a in ('findstr "=" "%CURR_DIR%\%INI_FILE%"') do (
    set %%a=%%b
    echo Set %%a to %%b  >> "%LOG_FILE%"
)


REM Step 5: Validation - Check if the company folder already exists in MASTER_COMPANY
if exist "%GP_DIR%\%MASTER_COMPANY%\%company_folder%" (
    echo Error: The folder %company_folder% already exists in %MASTER_COMPANY% directory.  >> "%LOG_FILE%"
    echo Exiting script to prevent overwriting.  >> "%LOG_FILE%"
    exit /b 1
)

REM Step 6: Check if the %MASTER_COMPANY% folder exists
echo Checking if %MASTER_COMPANY% folder exists...
if not exist "%GP_DIR%\%MASTER_COMPANY%" (
    echo Folder %MASTER_COMPANY% does not exist. Creating it...    >> "%LOG_FILE%"
    mkdir "%GP_DIR%\%MASTER_COMPANY%"
) else (
    echo Folder %MASTER_COMPANY% already exists.   >> "%LOG_FILE%"
)

REM Step 7: Create company_folder in the %MASTER_COMPANY% folder
echo Creating the company folder: %company_folder%...   >> "%LOG_FILE%"
if not exist "%GP_DIR%\%MASTER_COMPANY%\%company_folder%" (
    mkdir "%GP_DIR%\%MASTER_COMPANY%\%company_folder%"
) else (
    echo Company folder "%company_folder%" already exists.  >> "%LOG_FILE%"
)

REM Step 8: Create system_folder in the company_folder
echo Creating the system folder: %system_folder%...  >> "%LOG_FILE%"
if not exist "%GP_DIR%\%MASTER_COMPANY%\%company_folder%\%system_folder%" (
    mkdir "%GP_DIR%\%MASTER_COMPANY%\%company_folder%\%system_folder%"
) else (
    echo System folder "%system_folder%" already exists.   >> "%LOG_FILE%"
)

REM Step 8: Copy the INI_FILE to the company_folder/system directory if it exists
if exist "%CURR_DIR%\%INI_FILE%" (
    echo Copying INI file to the company folder...  >> "%LOG_FILE%"
    copy "%CURR_DIR%\%INI_FILE%" "%GP_DIR%\%MASTER_COMPANY%\%company_folder%\%system_folder%"
    echo INI file copied successfully. >> "%LOG_FILE%"
) else (
    echo Error: %INI_FILE% not found. Skipping copy. >> "%LOG_FILE%"
)

REM Step 9: Create project_root in the system_folder
echo Creating the project root folder: %project_root%...   >> "%LOG_FILE%"
if not exist "%GP_DIR%\%MASTER_COMPANY%\%company_folder%\%system_folder%\%project_root%" (
    mkdir "%GP_DIR%\%MASTER_COMPANY%\%company_folder%\%system_folder%\%project_root%"
) else (
    echo Project root folder "%project_root%" already exists.  >> "%LOG_FILE%"
)

REM Step 10: Create app_root and web_root inside project_root
echo Creating app root folder: %app_root%...   >> "%LOG_FILE%"
if not exist "%GP_DIR%\%MASTER_COMPANY%\%company_folder%\%system_folder%\%project_root%\%app_root%" (
    mkdir "%GP_DIR%\%MASTER_COMPANY%\%company_folder%\%system_folder%\%project_root%\%app_root%"
) else (
    echo App root folder "%app_root%" already exists.  >> "%LOG_FILE%"
)

echo Creating web root folder: %web_root%...   >> "%LOG_FILE%"
if not exist "%GP_DIR%\%MASTER_COMPANY%\%company_folder%\%system_folder%\%project_root%\%web_root%" (
    mkdir "%GP_DIR%\%MASTER_COMPANY%\%company_folder%\%system_folder%\%project_root%\%web_root%"
) else (
    echo Web root folder "%web_root%" already exists.   >> "%LOG_FILE%"
)

REM Step 11: Clone Git repositories using credentials from start.ini------------------------------------------------------
echo Cloning Git repositories using credentials...  >> "%LOG_FILE%"

set git_url_frontend=https://github.com/Vedam123/TransactWiseFrontend
set git_url_backend=https://github.com/Vedam123/TrasactWiseBackend

REM Step 12:  Using git user and password to clone repos
echo Cloning the frontend repository into "%GP_DIR%\%MASTER_COMPANY%\%company_folder%\%system_folder%\%project_root%\%web_root%"...   >> "%LOG_FILE%"
if exist "%GP_DIR%\%MASTER_COMPANY%\%company_folder%\%system_folder%\%project_root%\%web_root%\*" (
    git clone https://vedamk%40gmail.com:Granada%40%2312345@github.com/Vedam123/TransactWiseFrontend "%GP_DIR%\%MASTER_COMPANY%\%company_folder%\%system_folder%\%project_root%\%web_root%"
) else (
    echo There is no directory to clone web application from git. Skipping clone.   >> "%LOG_FILE%"
)

echo Cloning the backend repository into "%GP_DIR%\%MASTER_COMPANY%\%company_folder%\%system_folder%\%project_root%\%app_root%"...   >> "%LOG_FILE%"
if exist "%GP_DIR%\%MASTER_COMPANY%\%company_folder%\%system_folder%\%project_root%\%app_root%\*" (
    git clone https://vedamk%40gmail.com:Granada%40%2312345@github.com/Vedam123/TrasactWiseBackend "%GP_DIR%\%MASTER_COMPANY%\%company_folder%\%system_folder%\%project_root%\%app_root%"
) else (
    echo There is no directory to clone Backend application from git. Skipping clone.  >> "%LOG_FILE%"
)

REM Step 13: Ensure cloning is successful by checking the directories--------------------------------------
if exist "%GP_DIR%\%MASTER_COMPANY%\%company_folder%\%system_folder%\%project_root%\%web_root%\src" (
    echo Web root cloned successfully with the 'src' folder.   >> "%LOG_FILE%"
) else (
    echo Error: Web root or 'src' folder is missing.  >> "%LOG_FILE%"
    exit /b 1
)

if exist "%GP_DIR%\%MASTER_COMPANY%\%company_folder%\%system_folder%\%project_root%\%app_root%\modules" (
    echo App root cloned successfully.  >> "%LOG_FILE%"
) else (
    echo Error App root or 'modules' folder is missing.  >> "%LOG_FILE%"
    exit /b 1
)

REM ################################################################## block1 removed #####################################
REM Step 14: Copy config and configfiles directories
echo Copying config and configfiles directories to system folder...   >> "%LOG_FILE%"
xcopy /e /i /y "%GP_DIR%\%MASTER_COMPANY%\%company_folder%\%system_folder%\%project_root%\%app_root%\Documents\SetupGuides\ConfigFiles\config\*" "%GP_DIR%\%MASTER_COMPANY%\%company_folder%\%system_folder%\config"
xcopy "%GP_DIR%\%MASTER_COMPANY%\%company_folder%\%system_folder%\%project_root%\%app_root%\Documents\SetupGuides\*.*" "%GP_DIR%\%MASTER_COMPANY%\%company_folder%\%system_folder%\Documents\SetupGuides\" /i /y /h /r
echo Config and configfiles directories copied successfully.    >> "%LOG_FILE%"

REM ####################################REMOVED SHORT CUTU CREATION Block2 ###################################################

echo ------------------------------------now updating the config and global files -----------------------------------------   >> "%LOG_FILE%"

REM #################################### Block3 created ##################################################

echo ------------------------------------update of config and global file is completed -----------------------------------------

REM Step 21: Change directory to web_root and run npm install react-scripts if package.json exists
echo Changing directory to %GP_DIR%\%MASTER_COMPANY%\%company_folder%\%system_folder%\%project_root%\%web_root%   >> "%LOG_FILE%"
cd "%GP_DIR%\%MASTER_COMPANY%\%company_folder%\%system_folder%\%project_root%\%web_root%"

REM Step 22: Check if package.json exists in the web_root folder
if exist "package.json" (
    echo package.json file found. Installing react-scripts...   >> "%LOG_FILE%"
	 start /wait cmd /c "npm install react-scripts && exit"
) else (
    echo package.json file not found. Skipping npm install.  >> "%LOG_FILE%"
)

echo the npm install for react scripts successful and the child command window is closed   >> "%LOG_FILE%"

REM Step 23: Set up the Python virtual environment in app_root
echo Setting up the Python virtual environment in app_root directory...    >> "%LOG_FILE%"
cd "%GP_DIR%\%MASTER_COMPANY%\%company_folder%\%system_folder%\%project_root%\%app_root%"
python -m venv erpenv
echo Python virtual environment 'erpenv' created.    >> "%LOG_FILE%"

REM Step 24: Activate the virtual environment
echo Activating the virtual environment...    >> "%LOG_FILE%"
call erpenv\Scripts\activate.bat

REM Step 25: Install dependencies in the virtual environment
echo Installing dependencies in the virtual environment...   >> "%LOG_FILE%"
python.exe -m pip install --upgrade pip
pip install -r requirements.txt
pip install flask
pip install requests
pip install numpy
echo Dependencies installed successfully.   >> "%LOG_FILE%"

REM Step 26: Move to current directory where it started
cd "%GP_DIR%"
echo Switch to current directory %GP_DIR% where it started   >> "%LOG_FILE%"
echo Setup completed successfully.    >> "%LOG_FILE%"

REM Step 27: Deactivate the Python virtual environment
echo Deactivating the Python virtual environment...   >> "%LOG_FILE%"
deactivate
echo Python virtual environment deactivated. you can now close this cmd window   >> "%LOG_FILE%"

pause
