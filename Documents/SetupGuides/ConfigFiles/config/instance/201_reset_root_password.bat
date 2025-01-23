@echo off

setlocal enabledelayedexpansion

:: Create log directory if it doesn't exist
if not exist "reset_root_pwd" mkdir reset_root_pwd

:: Define log file
set LOG_FILE=reset_root_pwd\reset_root_pwd_log.txt

set "FETCH_ROOT_PWD_FROM_FILE=201_fetch_root_password.py"


REM Debugging: Check if Python is available in the PATH
python --version
if %errorlevel% neq 0 (
    echo Python is not found in the system PATH.
    pause
    exit /b 1
)

set CURR_DIR=%cd%
for %%a in ("%CURR_DIR%") do set CURR_DIR_NAME=%%~nxa

:: Step 2: Find Parent directory of CURR_DIR and store in PAR_DIR
set PAR_DIR=%CURR_DIR%\..
for %%a in ("%PAR_DIR%") do set PAR_DIR_NAME=%%~nxa

:: Step 3: Find Grandparent directory of PAR_DIR and store in GRAND_PAR_DIR
set GRAND_PAR_DIR=%PAR_DIR%\..
for %%a in ("%GRAND_PAR_DIR%") do set GRAND_PAR_DIR_NAME=%%~nxa

:: Step 4: Locate db_instances directory and store in DB_INSTANCES_DIR
set DB_INSTANCES_DIR=%GRAND_PAR_DIR%\db_instances
set DB_INSTANCES_DIR_NAME=db_instances

:: Step 5: Count subdirectories in DB_INSTANCES_DIR that start with 'instance'
set INSTANCE_DIR_COUNT=0

:: Loop through each subdirectory in DB_INSTANCES_DIR starting with 'instance'
for /d %%a in ("%DB_INSTANCES_DIR%\instance*") do (
    set /a INSTANCE_DIR_COUNT+=1
)

set BATCH_DIR=%~dp0
echo Batch Directory : %BATCH_DIR% >> %LOG_FILE%

:: Define the cnf directory (which is in the same directory as the batch file)
set CNF_DIR=%BATCH_DIR%cnf

:: Define the 00_config.ini file path
set CONFIG_FILE=%CNF_DIR%\00_config.ini

:: Read the ROOT_PASSWORD value from the global_variables.ini file
for /f "tokens=1,2 delims==" %%A in ('findstr /i "ROOT_PASSWORD" "%CONFIG_FILE%"') do set "ROOT_PASSWORD=%%B"

:: Remove any leading and trailing spaces from ROOT_PASSWORD
for /f "tokens=* delims=" %%a in ("%ROOT_PASSWORD%") do set "ROOT_PASSWORD=%%a"

:: Step 6: Set root and new root password
set ROOT_USER=root

:: Step 7: Loop through each instance subdirectory and process files
for /d %%a in ("%DB_INSTANCES_DIR%\instance*") do (
    set INSTANCE_DIR=%%a
    set INSTANCE_DIR_NAME=%%~nxa

    :: Step 8: Set file paths for .instance.cnf and root_password.txt
    set INS_FILE_NAME=!INSTANCE_DIR!\.instance.cnf
    set ROOT_FILE_NAME=!INSTANCE_DIR!\root_password.ini

    :: Step 9: Check if the .instance.cnf and root_password.txt exist
    if exist "!INS_FILE_NAME!" if exist "!ROOT_FILE_NAME!" (

        :: Read user
        for /f "tokens=2 delims==" %%b in ('findstr "user" "!INS_FILE_NAME!"') do set CL_USER=%%b
        REM Remove any leading and trailing spaces
        for /f "tokens=* delims=" %%a in ("%CL_USER%") do set "CL_USER=%%a"

        :: Read password
        for /f "tokens=2 delims==" %%b in ('findstr "password" "!INS_FILE_NAME!"') do set CL_PASSWORD=%%b
        REM Remove any leading and trailing spaces
        for /f "tokens=* delims=" %%a in ("%CL_PASSWORD%") do set "CL_PASSWORD=%%a"

        :: Read host (searching specifically for 'host')
        for /f "tokens=2 delims==" %%b in ('findstr "host" "!INS_FILE_NAME!"') do set CL_HOST=%%b
		
		echo the extracted CL_HOST !CL_HOST! 
        REM Remove any leading and trailing spaces
        for /f "tokens=* delims=" %%a in ("%CL_HOST%") do set "CL_HOST=%%a"

        :: Read port
        for /f "tokens=2 delims==" %%b in ('findstr "port" "!INS_FILE_NAME!"') do set CL_PORT=%%b
        REM Remove any leading and trailing spaces
        for /f "tokens=* delims=" %%a in ("%CL_PORT%") do set "CL_PORT=%%a"

        echo User: !CL_USER!  >> %LOG_FILE%
        echo Password: !CL_PASSWORD!   >> %LOG_FILE%
        echo Host: !CL_HOST!  >> %LOG_FILE%
        echo Port: !CL_PORT!  >> %LOG_FILE%
        echo Current Password: !ROOT_PWD!  >> %LOG_FILE%
        echo New Password: !ROOT_PASSWORD!  >> %LOG_FILE%
		echo File name !FETCH_ROOT_PWD_FROM_FILE! >> %LOG_FILE%

		echo Instance Name  !INSTANCE_DIR_NAME! >> %LOG_FILE%
		
		set ROOT_PWD=
		set SCRIPT_PATH=%CURRENT_DIR%!FETCH_ROOT_PWD_FROM_FILE!
		echo Script Path with file name !SCRIPT_PATH!	>> %LOG_FILE%	
		for /f %%i in ('python "!SCRIPT_PATH!" "!INSTANCE_DIR_NAME!"') do set ROOT_PWD=%%i

        :: Trim ROOT_PASSWORD in the same way (remove leading and trailing spaces)
        set "ROOT_PASSWORD=!ROOT_PASSWORD: =!"
		
		echo Current Password: !ROOT_PWD!
		echo New Password: !ROOT_PASSWORD!

        :: Compare the existing root password (ROOT_PWD) with the new password (ROOT_PASSWORD)
        if "!ROOT_PWD!" == "!ROOT_PASSWORD!" (
            echo Both existing and requested root passwords are the same for the instance !INSTANCE_DIR_NAME!, no changes required. Skipping... >> %LOG_FILE%
            echo Both existing and requested root passwords are the same for the instance !INSTANCE_DIR_NAME!, no changes required. Skipping...
        ) else (
			
			echo  Host !CL_HOST! , PORT !CL_PORT!, ROOT USER !ROOT_USER!, ROOT PASSWD !ROOT_PWD!,  ALTER TO THE PASSWORD  !ROOT_PASSWORD! for the  !INSTANCE_DIR_NAME! 
			:: Proceed with password change if passwords are different
			mysql -h !CL_HOST! -P !CL_PORT! -u !ROOT_USER! -p"!ROOT_PWD!" --connect-expired-password -e "ALTER USER '!ROOT_USER!'@'!CL_HOST!' IDENTIFIED BY '!ROOT_PASSWORD!';" >> %LOG_FILE% 2>&1					
			
			:: Capture the ERRORLEVEL immediately after the mysql command
			set MYSQL_ERRORLEVEL=!ERRORLEVEL!
			echo Mysql error level !MYSQL_ERRORLEVEL!
			:: Step 3: Check if the MySQL command was successful
			if !MYSQL_ERRORLEVEL! EQU 0 (
				echo MySQL password change successful.  >> %LOG_FILE%

				:: Step 4: Update the root_password.ini with the new password
				set ROOT_FILE_NAME=!INSTANCE_DIR!\root_password.ini

				:: Ensure the file is empty before updating (without adding extra line)
				> "!ROOT_FILE_NAME!" (
					echo password=!ROOT_PASSWORD!
				)

				echo The File root_password.ini is updated with new password !ROOT_PASSWORD! for the  !INSTANCE_DIR_NAME!   >> %LOG_FILE%
				echo The File root_password.ini is updated with new password !ROOT_PASSWORD! for the  !INSTANCE_DIR_NAME!			
			) else (
				echo The File root_password.ini is not updated with new password !ROOT_PASSWORD! for the  !INSTANCE_DIR_NAME! due to the error !MYSQL_ERRORLEVEL!  >> %LOG_FILE%
				echo The File root_password.ini is not updated with new password !ROOT_PASSWORD! for the  !INSTANCE_DIR_NAME! due to the error !MYSQL_ERRORLEVEL! 			
			)

			echo Root password reset process completed for !INSTANCE_DIR_NAME!..  >> %LOG_FILE%
			echo Root password reset process completed for !INSTANCE_DIR_NAME!..  
		)
    ) else (
        echo Missing files for !INSTANCE_DIR_NAME!, skipping...  >> %LOG_FILE%
        echo Missing files for !INSTANCE_DIR_NAME!, skipping...  
    )
	
)

endlocal
