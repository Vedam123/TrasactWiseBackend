@echo off
:: Batch file to create a shortcut for 999_application_start.bat on Desktop with specific naming convention

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

:: Step 3: Find Grandparent directory of PAR_DIR and store in GRAND_PAR_DIR
set G_GRAND_PAR_DIR=%GRAND_PAR_DIR%\..
for %%a in ("%G_GRAND_PAR_DIR%") do set G_GRAND_PAR_DIR_NAME=%%~nxa
echo Grandparent Directory: %G_GRAND_PAR_DIR%
echo Great Grandparent Directory Name: %G_GRAND_PAR_DIR_NAME%


:: Define paths
set "BAT_FILE_PATH=%~dp0\999_application_start.bat"
set "DESKTOP_PATH=%USERPROFILE%\Desktop"

:: Step 5: Create the shortcut name by appending batch file name to G_GRAND_PAR_DIR_NAME
set "SHORTCUT_NAME=%G_GRAND_PAR_DIR_NAME%_App.lnk"

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
