@echo off
setlocal

:: Get the directory of the current script
set SCRIPT_DIR=%~dp0

echo Running Python script...
:: Run the Python script and capture the output (company_folder_dir)
for /f "delims=" %%i in ('python "%SCRIPT_DIR%\install_dev_system.py"') do set COMPANY_FOLDER_DIR=%%i

:: Pause to check what the Python script returned
echo.
echo Python script executed. Captured output:
echo %COMPANY_FOLDER_DIR%
echo.

:: Check if the Python script executed successfully
if %errorlevel% neq 0 (
    echo Error: The Python script encountered an issue.
    exit /b %errorlevel%
)


:: Check if the batch file exists in the returned directory and execute it
if exist "%COMPANY_FOLDER_DIR%\start_project_v2.bat" (
    echo Found start_project_v2.bat in:
    echo %COMPANY_FOLDER_DIR%
    
    :: Change directory to COMPANY_FOLDER_DIR before executing the batch file
    echo Changing directory to %COMPANY_FOLDER_DIR%
    cd /d "%COMPANY_FOLDER_DIR%"
    
    echo Running start_project_v2.bat...
    call "start_project_v2.bat"
) else (
    echo Error: start_project_v2.bat not found in %COMPANY_FOLDER_DIR%
    exit /b 1
)

:: Pause to see the final output
echo.
echo Process completed.
exit /b 0
