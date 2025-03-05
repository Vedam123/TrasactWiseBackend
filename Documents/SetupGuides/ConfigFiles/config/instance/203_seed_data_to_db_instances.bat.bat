@echo off
cd /d "%~dp0"

:: Set variables
SET VENV_DIR=venv
SET PYTHON_FILE=202_seed_data_to_db_instances.py

:: Check if Python is installed
python --version >nul 2>&1
IF ERRORLEVEL 1 (
    echo Python is not installed. Please install Python and try again.
    pause
    exit /b
)

:: Check if virtual environment exists, create if not
IF NOT EXIST "%VENV_DIR%" (
    echo Creating virtual environment...
    python -m venv "%VENV_DIR%"
)

:: Activate virtual environment
call "%VENV_DIR%\Scripts\activate.bat"

:: Upgrade pip and install required packages in virtual environment
python -m ensurepip --default-pip
python -m pip install --upgrade pip
python -m pip install mysql-connector-python configparser

:: Check if the Python script exists
IF NOT EXIST "%PYTHON_FILE%" (
    echo Error: "%PYTHON_FILE%" not found in the current directory.
    deactivate
    pause
    exit /b
)

:: Run the Python script inside virtual environment
python "%PYTHON_FILE%"

:: Deactivate virtual environment
deactivate

pause
