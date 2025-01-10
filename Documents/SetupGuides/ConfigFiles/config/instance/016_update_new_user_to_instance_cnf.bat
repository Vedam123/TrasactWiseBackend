@echo off
setlocal enabledelayedexpansion

:: Step 1: Find the current directory and store its path in CURR_DIR
set CURR_DIR=%cd%
for %%a in ("%CURR_DIR%") do set CURR_DIR_NAME=%%~nxa
echo Current Directory: %CURR_DIR%
echo Current Directory Name: %CURR_DIR_NAME%

:: Step 2: Find Parent directory of CURR_DIR and store in PAR_DIR
set PAR_DIR=%CURR_DIR%\..
for %%a in ("%PAR_DIR%") do set PAR_DIR_NAME=%%~nxa
echo Parent Directory: %PAR_DIR%
echo Parent Directory Name: %PAR_DIR_NAME%

:: Step 3: Find Grandparent directory of PAR_DIR and store in GRAND_PAR_DIR
set GRAND_PAR_DIR=%PAR_DIR%\..
for %%a in ("%GRAND_PAR_DIR%") do set GRAND_PAR_DIR_NAME=%%~nxa
echo Grandparent Directory: %GRAND_PAR_DIR%
echo Grandparent Directory Name: %GRAND_PAR_DIR_NAME%

:: Step 4: Locate application directory and store in APP_ROOT_DIR
set APP_ROOT_DIR=%GRAND_PAR_DIR%\application
set APP_ROOT_DIR_NAME=application
echo Application Root Directory: %APP_ROOT_DIR%

:: Step 5: Locate AppService directory inside APP_ROOT_DIR and store in BACK_END_APP_DIR
set BACK_END_APP_DIR=%APP_ROOT_DIR%\AppService
set BACK_END_APP_DIR_NAME=AppService
echo Backend Application Directory: %BACK_END_APP_DIR%

:: Step 6: Locate erpenv directory inside BACK_END_APP_DIR and store in VIRENV
set VIRENV=%BACK_END_APP_DIR%\erpenv
set VIRENV_NAME=erpenv
echo Virtual Environment Directory: %VIRENV%

:: Step 7: Assign VENV_DIR to VIRENV directory path
set VENV_DIR=%VIRENV%
echo VENV_DIR: %VENV_DIR%

:: Set the Python script file name
SET PYTHON_FILE=016_update_new_user_to_instance_cnf.py

:: Check if the Python file exists in the current directory
IF EXIST "%PYTHON_FILE%" (
    echo File "%PYTHON_FILE%" found. Activating virtual environment and executing Python script...

    :: Activate the virtual environment
    call "%VENV_DIR%\Scripts\activate.bat"

    :: Run the Python script
    python "%PYTHON_FILE%"

    :: Deactivate the virtual environment after execution
    deactivate
) ELSE (
    echo Error: "%PYTHON_FILE%" not found in the current directory.
)

pause
