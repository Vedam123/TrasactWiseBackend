@echo off
SETLOCAL

:: Check if PM2 is installed
echo Checking if PM2 is installed...
where pm2 >nul 2>nul
IF %ERRORLEVEL% NEQ 0 (
    echo PM2 is not installed. Installing...
    npm install -g pm2
    where pm2 >nul 2>nul
    IF %ERRORLEVEL% NEQ 0 (
        echo Failed to install PM2.
        exit /b 1
    ) ELSE (
        echo PM2 installed successfully.
    )
) ELSE (
    echo PM2 is already installed.
)

:: Check if PyInstaller is installed
echo Checking if PyInstaller is installed...
pyinstaller --version >nul 2>nul
IF %ERRORLEVEL% NEQ 0 (
    echo PyInstaller is not installed. Installing...
    pip install pyinstaller
    pyinstaller --version >nul 2>nul
    IF %ERRORLEVEL% NEQ 0 (
        echo Failed to install PyInstaller.
        exit /b 1
    ) ELSE (
        echo PyInstaller installed successfully.
    )
) ELSE (
    echo PyInstaller is already installed.
)

echo All checks completed successfully.
pause
