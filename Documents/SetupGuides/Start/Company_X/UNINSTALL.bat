@echo off
setlocal enabledelayedexpansion

:: Task 1 - Find the paths of the directories
rem Get current directory and its name
set "CURR_DIR_PATH=%CD%"
for %%I in (%CURR_DIR_PATH%) do set "CURR_DIR_NAME=%%~nxI"

rem Get parent directory of current directory
for %%I in (%CURR_DIR_PATH%) do set "PAR_DIR_PATH=%%~dpI"
for %%I in (%PAR_DIR_PATH%) do set "PAR_DIR_NAME=%%~nxI"

rem Get grandparent directory of parent directory
for %%I in (%PAR_DIR_PATH%) do set "GPAR_DIR_PATH=%%~dpI"
for %%I in (%GPAR_DIR_PATH%) do set "GPAR_DIR_NAME=%%~nxI"

:: Task 1 - Run the UNINSTALL.bat
set "REMOVEFILES_PATH=%GPAR_DIR_PATH%\Companies\%CURR_DIR_NAME%\system\config\instance\REMOVEFILES.bat"
echo Running REMOVEFILES.bat from: %REMOVEFILES_PATH%

if exist "%REMOVEFILES_PATH%" (
    call "%REMOVEFILES_PATH%"
    echo REMOVEFILES.bat executed successfully.
) else (
    echo REMOVEFILES.bat not found at %REMOVEFILES_PATH%.
    exit /b 1
)

:: Task 2 - Switch to CURR_DIR_PATH
echo Switching to directory: %CURR_DIR_PATH%
cd /d "%CURR_DIR_PATH%"
if not "%CD%" == "%CURR_DIR_PATH%" (
    echo Failed to switch to the directory %CURR_DIR_PATH%.
    exit /b 1
)
echo Successfully switched to: %CURR_DIR_PATH%

:: Task 3 - Delete the directory CURR_DIR_NAME
echo Deleting directory: %GPAR_DIR_PATH%\Companies\%CURR_DIR_NAME%
rmdir /s /q "%GPAR_DIR_PATH%\Companies\%CURR_DIR_NAME%"
if exist "%GPAR_DIR_PATH%\Companies\%CURR_DIR_NAME%" (
    echo Failed to delete the directory.
    exit /b 1
)
echo Directory %CURR_DIR_NAME% and its contents have been successfully deleted.

pause
