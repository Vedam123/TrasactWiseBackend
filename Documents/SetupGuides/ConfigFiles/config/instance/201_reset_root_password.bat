@echo off
setlocal enabledelayedexpansion

:: Create log directory if it doesn't exist
if not exist "reset_root_pwd" mkdir reset_root_pwd

:: Define log file
set LOG_FILE=reset_root_pwd\reset_root_pwd_log.txt

set CURR_DIR=%cd%
for %%a in ("%CURR_DIR%") do set CURR_DIR_NAME=%%~nxa
echo Current Directory: %CURR_DIR% >> %LOG_FILE%
echo Current Directory Name: %CURR_DIR_NAME% >> %LOG_FILE%

:: Step 2: Find Parent directory of CURR_DIR and store in PAR_DIR
set PAR_DIR=%CURR_DIR%\..
for %%a in ("%PAR_DIR%") do set PAR_DIR_NAME=%%~nxa
echo Parent Directory: %PAR_DIR% >> %LOG_FILE%
echo Parent Directory Name: %PAR_DIR_NAME% >> %LOG_FILE%

:: Step 3: Find Grandparent directory of PAR_DIR and store in GRAND_PAR_DIR
set GRAND_PAR_DIR=%PAR_DIR%\..
for %%a in ("%GRAND_PAR_DIR%") do set GRAND_PAR_DIR_NAME=%%~nxa
echo Grandparent Directory: %GRAND_PAR_DIR% >> %LOG_FILE%
echo Grandparent Directory Name: %GRAND_PAR_DIR_NAME% >> %LOG_FILE%

:: Step 4: Locate db_instances directory and store in DB_INSTANCES_DIR
set DB_INSTANCES_DIR=%GRAND_PAR_DIR%\db_instances
set DB_INSTANCES_DIR_NAME=db_instances
echo DB Instances Directory: %DB_INSTANCES_DIR% >> %LOG_FILE%

:: Step 5: Count subdirectories in DB_INSTANCES_DIR that start with 'instance'
set INSTANCE_DIR_COUNT=0

:: Loop through each subdirectory in DB_INSTANCES_DIR starting with 'instance'
for /d %%a in ("%DB_INSTANCES_DIR%\instance*") do (
    set /a INSTANCE_DIR_COUNT+=1
)

echo Instance Directory Count: %INSTANCE_DIR_COUNT% >> %LOG_FILE%

:: Step 6: Set root and new root password
set ROOT_USER=root
set NEW_ROOT_PASSWORD=tigressAV
:: Step 7: Loop through each instance subdirectory and process files
for /d %%a in ("%DB_INSTANCES_DIR%\instance*") do (
    set INSTANCE_DIR=%%a
    echo Processing directory: !INSTANCE_DIR! >> %LOG_FILE%

    :: Step 8: Set file paths for .instance.cnf and root_password.txt
    set INS_FILE_NAME=!INSTANCE_DIR!\.instance.cnf
    set ROOT_FILE_NAME=!INSTANCE_DIR!\root_password.ini

    :: Step 9: Check if the .instance.cnf and root_password.txt exist
    if exist "!INS_FILE_NAME!" if exist "!ROOT_FILE_NAME!" (
        echo Files found: !INS_FILE_NAME! and !ROOT_FILE_NAME! >> %LOG_FILE%

        :: Read user
        for /f "tokens=2 delims==" %%b in ('findstr "user" "!INS_FILE_NAME!"') do set CL_USER=%%b

        :: Read password
        for /f "tokens=2 delims==" %%b in ('findstr "password" "!INS_FILE_NAME!"') do set CL_PASSWORD=%%b

        :: Read host (searching specifically for 'host')
        for /f "tokens=2 delims==" %%b in ('findstr "host=" "!INS_FILE_NAME!"') do set CL_HOST=%%b

        :: Read port
        for /f "tokens=2 delims==" %%b in ('findstr "port" "!INS_FILE_NAME!"') do set CL_PORT=%%b

        echo User: !CL_USER! >> %LOG_FILE%
        echo Password: !CL_PASSWORD! >> %LOG_FILE%
        echo Host: !CL_HOST! >> %LOG_FILE%
        echo Port: !CL_PORT! >> %LOG_FILE%

        :: Read root password
        REM for /f "tokens=2 delims==" %%b in ('findstr "password" "!ROOT_FILE_NAME!"') do set ROOT_PWD=%%b
		:: Read root password
		for /f "tokens=1* delims==" %%b in ('findstr "password" "!ROOT_FILE_NAME!"') do set ROOT_PWD=%%c

		:: Step 2: Display the extracted password
		echo Captured Root Password: !ROOT_PWD! >> %LOG_FILE%
		
		set "ROOT_PWD=!ROOT_PWD: =!"

		:: Remove leading spaces
		for /f "tokens=* delims=" %%a in ("!ROOT_PWD!") do set "ROOT_PWD=%%a"

		:: Remove trailing spaces
		for /l %%a in (1,1,255) do (
			set "ROOT_PWD=!ROOT_PWD!"
			if "!ROOT_PWD:~-1!"==" " set "ROOT_PWD=!ROOT_PWD:~0,-1!"
		)

		:: Step 2: Display the extracted password
		echo Updated quoted Root Password: "!ROOT_PWD!" >> %LOG_FILE%
		

        :: Step 12: Connect to MySQL using the captured details and reset the root password
        echo Resetting root password for !CL_HOST!:!CL_PORT!... >> %LOG_FILE%

		:: Use mysqld to connect and change the root password 
		mysql -h !CL_HOST! -P !CL_PORT! -u !ROOT_USER! -p"!ROOT_PWD!" --connect-expired-password -e "ALTER USER '!ROOT_USER!'@'!CL_HOST!' IDENTIFIED BY '!NEW_ROOT_PASSWORD!';" >> %LOG_FILE% 2>&1

        :: Step 3: Check if the MySQL command was successful
       if !ERRORLEVEL! EQU 0 (
			echo MySQL password change successful. >> %LOG_FILE%

			:: Step 4: Update the root_password.ini with the new password
			set ROOT_FILE_NAME=!INSTANCE_DIR!\root_password.ini

			:: Ensure the file is empty before updating (without adding extra line)
			> "!ROOT_FILE_NAME!" (
				echo password=!NEW_ROOT_PASSWORD!
			)

			echo root_password.ini updated with new password: !NEW_ROOT_PASSWORD! >> %LOG_FILE%
		) else (
			echo Error: MySQL password change failed. ERRORLEVEL: !ERRORLEVEL! >> %LOG_FILE%
		)

        echo Root password reset process completed for !INSTANCE_DIR!.. >> %LOG_FILE%
    ) else (
        echo Missing files for !INSTANCE_DIR!, skipping... >> %LOG_FILE%
    )
)

endlocal