@echo off
setlocal enabledelayedexpansion

:: Step 1: Find the current directory and store it in CURR_DIR
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

:: Step 4: Locate db_instances directory and store in DB_INSTANCES_DIR
set DB_INSTANCES_DIR=%GRAND_PAR_DIR%\db_instances
set DB_INSTANCES_DIR_NAME=db_instances
echo DB Instances Directory: %DB_INSTANCES_DIR%

:: Step 5: Count subdirectories in DB_INSTANCES_DIR that start with 'instance'
set INSTANCE_DIR_COUNT=0

:: Loop through each subdirectory in DB_INSTANCES_DIR starting with 'instance'
for /d %%a in ("%DB_INSTANCES_DIR%\instance*") do (
    set /a INSTANCE_DIR_COUNT+=1
)

echo Instance Directory Count: %INSTANCE_DIR_COUNT%

:: Step 6: Set root and new root password
set ROOT_USER=root
set NEW_ROOT_PASSWORD=tigress3

:: Step 7: Loop through each instance subdirectory and process files
for /d %%a in ("%DB_INSTANCES_DIR%\instance*") do (
    set INSTANCE_DIR=%%a
    echo Processing directory: !INSTANCE_DIR!

    :: Step 8: Set file paths for .instance.cnf and root_password.txt
    set INS_FILE_NAME=!INSTANCE_DIR!\.instance.cnf
    set ROOT_FILE_NAME=!INSTANCE_DIR!\root_password.ini

    :: Step 9: Check if the .instance.cnf and root_password.txt exist
    if exist "!INS_FILE_NAME!" if exist "!ROOT_FILE_NAME!" (
        echo Files found: !INS_FILE_NAME! and !ROOT_FILE_NAME!

        :: Read user
        for /f "tokens=2 delims==" %%b in ('findstr "user" "!INS_FILE_NAME!"') do set CL_USER=%%b

        :: Read password
        for /f "tokens=2 delims==" %%b in ('findstr "password" "!INS_FILE_NAME!"') do set CL_PASSWORD=%%b

        :: Read host (searching specifically for 'host')
        for /f "tokens=2 delims==" %%b in ('findstr "host=" "!INS_FILE_NAME!"') do set CL_HOST=%%b

        :: Read port
        for /f "tokens=2 delims==" %%b in ('findstr "port" "!INS_FILE_NAME!"') do set CL_PORT=%%b

        echo User: !CL_USER!
        echo Password: !CL_PASSWORD!
        echo Host: !CL_HOST!
        echo Port: !CL_PORT!

        :: Read root password
        for /f "tokens=2 delims==" %%b in ('findstr "password" "!ROOT_FILE_NAME!"') do set ROOT_PWD=%%b

        :: Step 2: Display the extracted password
        echo Captured Root Password: !ROOT_PWD!

        :: Step 12: Connect to MySQL using the captured details and reset the root password
        echo Resetting root password for !CL_HOST!:!CL_PORT!...

        :: Use mysqld to connect and change the root password
        mysql -h !CL_HOST! -P !CL_PORT! -u !ROOT_USER! -p!ROOT_PWD! -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '!NEW_ROOT_PASSWORD!';"

        :: Step 3: Check if the MySQL command was successful
        if !ERRORLEVEL! EQU 0 (
            echo MySQL password change successful.

            :: Step 4: Update the root_password.ini with the new password
            set ROOT_FILE_NAME=!INSTANCE_DIR!\root_password.ini

            :: Ensure the file is empty before updating
            > "!ROOT_FILE_NAME!" echo.

            :: Update the password in the ini file without spaces around '='
            echo password=!NEW_ROOT_PASSWORD! >> "!ROOT_FILE_NAME!"

            echo root_password.ini updated with new password: !NEW_ROOT_PASSWORD!
        ) else (
            echo Error: MySQL password change failed. ERRORLEVEL: !ERRORLEVEL!
        )

        echo Root password reset process completed for !INSTANCE_DIR!.
    ) else (
        echo Missing files for !INSTANCE_DIR!, skipping...
    )
)

endlocal
pause
