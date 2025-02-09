@echo off
setlocal enabledelayedexpansion

:: Check if a parameter is provided
if "%~1"=="" (
    echo Error: No keyword provided. Usage: script.bat Company_3
    exit /b 1
)

:: Capture the input parameter
set "SEARCH_TERM=%~1"

:: Run handle.exe with the provided parameter and capture output
handle.exe "%SEARCH_TERM%" > temp_handle_output.txt

:: Read output and extract node.exe PID
for /f "tokens=3" %%A in ('findstr /I "node.exe" temp_handle_output.txt') do (
    set "PID=%%A"
	echo %PID%
)

:: Kill the process if found
if defined PID (
    echo Found node.exe with PID: !PID!
    taskkill /PID !PID! /F
) else (
    echo No matching node.exe process found for %SEARCH_TERM%.
)

:: Clean up
del temp_handle_output.txt
