@echo off
:: Batch file to create a shortcut for 999_application_start.bat on Desktop with specific naming convention

:: Step 1: Identify the current directory and store it in CURR_DIR
set "CURR_DIR=%~dp0"

:: Step 2: Identify the parent directory of CURR_DIR and store it in PAR_DIR
for %%I in ("%CURR_DIR%..") do set "PAR_DIR=%%~fI"

:: Step 3: Identify the parent directory of PAR_DIR and store it in GP_DIR
for %%I in ("%PAR_DIR%..") do set "GP_DIR=%%~fI"

:: Step 4: Identify the parent directory of GP_DIR and store it in G_GP_DIR, also store the directory name as G_GP_DIR_NAME
for %%I in ("%GP_DIR%..") do set "G_GP_DIR=%%~fI"
for %%I in ("%G_GP_DIR%") do set "G_GP_DIR_NAME=%%~nxI"

:: Define paths
set "BAT_FILE_PATH=%~dp0\999_application_start.bat"
set "DESKTOP_PATH=%USERPROFILE%\Desktop"

:: Step 5: Create the shortcut name by appending batch file name to G_GP_DIR_NAME
set "SHORTCUT_NAME=%G_GP_DIR_NAME%_999_application_start.lnk"

:: Create a shortcut using WScript
echo Set oWS = WScript.CreateObject("WScript.Shell") > "%TEMP%\create_shortcut.vbs"
echo Set oLink = oWS.CreateShortcut("%DESKTOP_PATH%\%SHORTCUT_NAME%") >> "%TEMP%\create_shortcut.vbs"
echo oLink.TargetPath = "%BAT_FILE_PATH%" >> "%TEMP%\create_shortcut.vbs"
echo oLink.Save >> "%TEMP%\create_shortcut.vbs"

:: Run the VBS script to create the shortcut
cscript //nologo "%TEMP%\create_shortcut.vbs"

:: Clean up the temporary VBS script
del "%TEMP%\create_shortcut.vbs"

echo Shortcut created successfully on the Desktop.
pause
