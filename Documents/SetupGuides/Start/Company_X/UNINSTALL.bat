@echo off
setlocal enabledelayedexpansion

:: Step 1: Find the current directory
set "CURR_DIR=%CD%"
for %%a in ("%CURR_DIR%") do set "CURR_DIR_NAME=%%~nxa"
echo Current Directory Path: %CURR_DIR%
echo Current Directory Name: %CURR_DIR_NAME%

:: Step 2: Find the Parent directory
for /D %%a in ("%CURR_DIR%\..") do set "PAR_DIR=%%~fa"
for %%a in ("%PAR_DIR%") do set "PAR_DIR_NAME=%%~nxa"
echo Parent Directory Path: %PAR_DIR%
echo Parent Directory Name: %PAR_DIR_NAME%

:: Step 3: Find the Grandparent directory
for /D %%a in ("%PAR_DIR%\..") do set "GPAR_DIR=%%~fa"
for %%a in ("%GPAR_DIR%") do set "GPAR_DIR_NAME=%%~nxa"
echo Grandparent Directory Path: %GPAR_DIR%
echo Grandparent Directory Name: %GPAR_DIR_NAME%

:: Step 4: Create the required directory structure
set "TARGET_DIR=%GPAR_DIR%\Companies\%CURR_DIR_NAME%\system\config\instance"
if not exist "%TARGET_DIR%" (
    mkdir "%TARGET_DIR%"
    echo Directory created: %TARGET_DIR%
) else (
    echo Directory already exists: %TARGET_DIR%
)

:: Step 5: Switch to the new directory
cd /d "%TARGET_DIR%"
if "%CD%"=="%TARGET_DIR%" (
    call REMOVEFILES.bat
    echo Successfully switched to: %CD%
) else (
    echo Failed to switch to the directory.
    exit /b 1
)

:: Task 3 - Switch to CURR_DIR_PATH
echo Switching to directory: %CURR_DIR%
cd /d "%CURR_DIR%"
if not "%CD%" == "%CURR_DIR%" (
    echo Failed to switch to the directory %CURR_DIR%.
    exit /b 1
)
echo Successfully switched to: %CURR_DIR%

:: Step 6: Delete the DELETE_DIR
set "DELETE_DIR=%GPAR_DIR%\Companies\%CURR_DIR_NAME%"
echo Deleting Directory: %DELETE_DIR%

if exist "%DELETE_DIR%" (
    rmdir /s /q "%DELETE_DIR%"
    if exist "%DELETE_DIR%" (
        echo ERROR: Failed to delete the directory.
        exit /b 1
    ) else (
        echo Directory %DELETE_DIR% and its contents have been successfully deleted.
    )
) else (
    echo Directory %DELETE_DIR% does not exist.
)

pause
