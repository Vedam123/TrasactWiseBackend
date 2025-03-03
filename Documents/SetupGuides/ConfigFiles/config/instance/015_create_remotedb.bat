@echo off
setlocal

:: Define the Python script name
set SCRIPT_NAME=015_create_remotedb.py

:: Check if Python is installed
where python >nul 2>nul
if %errorlevel% neq 0 (
    echo ERROR: Python is not installed or not in the system PATH.
    exit /b 1
)

:: Run the Python script
python %SCRIPT_NAME%

echo Script executed command prompt open (optional)

