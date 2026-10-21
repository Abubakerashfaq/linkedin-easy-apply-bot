@echo off
REM
REM Author:  Abubaker Ashfaq
REM License: MIT License
REM          https://opensource.org/license/mit
REM
REM One-click launcher for Windows. Double-click this file. It sets up everything
REM the first time, then opens the control panel in your web browser. Safe to run
REM again any time.
REM
REM Nothing needs to be installed first, not even Python. The first run downloads
REM uv (a small, widely used Python installer) into the .tools folder, and uv then
REM downloads a private copy of Python and the packages. Any Python already on
REM this PC is never used, so it doesn't matter which one it is or if it's there.

setlocal
cd /d "%~dp0"

REM Pinned so every user gets the same setup that was tested.
set "UV_VERSION=0.12.24"
set "PYTHON_VERSION=3.12"
set "UV=.tools\uv.exe"
set "VENV_PY=.venv\Scripts\python.exe"

echo.
echo ========================================================
echo   Easy Apply Autopilot - starting your control panel
echo ========================================================
echo.

REM Opening this file straight from the ZIP, without extracting it first, runs it
REM alone from a temp folder without the rest of the project. Say how to fix it.
if not exist "app.py" (
    echo This file needs the rest of its folder next to it.
    echo Right-click the downloaded ZIP file, choose "Extract All...", then
    echo double-click start.bat inside the extracted folder.
    echo.
    pause
    exit /b 1
)

REM 1) Get uv the first time. It lives in this folder, nothing is installed
REM    system-wide. TLS 1.2 is switched on for older Windows 10 installs.
if not exist "%UV%" (
    echo Downloading the installer ^(one time only^)...
    set "UV_UNMANAGED_INSTALL=%CD%\.tools"
    powershell -NoProfile -ExecutionPolicy Bypass -Command "[Net.ServicePointManager]::SecurityProtocol = [Net.ServicePointManager]::SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12; irm https://astral.sh/uv/%UV_VERSION%/install.ps1 | iex" >nul
)
if not exist "%UV%" (
    echo Could not download the installer. Check your internet connection and run this again.
    echo.
    pause
    exit /b 1
)

REM 2) Set up a private Python the first time. Also rebuilds it if it is broken,
REM    or if an older version of this script built it on a Python that is too
REM    old for the AI packages.
"%VENV_PY%" -c "import sys; sys.exit(sys.version_info < (3, 10))" >nul 2>&1
if errorlevel 1 (
    echo Setting up Python ^(one time only^)...
    if exist ".venv" rmdir /s /q ".venv"
    "%UV%" venv --quiet --seed --managed-python --python %PYTHON_VERSION% .venv
    if errorlevel 1 (
        echo Could not set up Python. Check your internet connection and run this again.
        echo.
        pause
        exit /b 1
    )
)

REM 3) Install the required packages. Runs again whenever .deps_installed is
REM    missing, which is how the in-app updater brings in new requirements.
if not exist ".venv\.deps_installed" (
    echo Installing required packages ^(one time only, this can take a few minutes^)...
    "%UV%" pip install --quiet --python "%VENV_PY%" -r requirements.txt
    if errorlevel 1 (
        echo Could not install required packages. Check your internet connection and run this again.
        echo.
        pause
        exit /b 1
    )
    echo done> ".venv\.deps_installed"
)

REM 4) Google Chrome is the one thing this can't set up for you.
set "HAS_CHROME="
if exist "%ProgramFiles%\Google\Chrome\Application\chrome.exe" set "HAS_CHROME=1"
if exist "%ProgramFiles(x86)%\Google\Chrome\Application\chrome.exe" set "HAS_CHROME=1"
if exist "%LocalAppData%\Google\Chrome\Application\chrome.exe" set "HAS_CHROME=1"
if not defined HAS_CHROME (
    echo.
    echo Google Chrome is needed to apply for jobs, and it isn't installed.
    echo Opening the download page. Install Chrome, then carry on in the control panel.
    start "" "https://www.google.com/chrome/"
)

REM 5) Start the control panel. It chooses a free port, prints the address, and
REM    opens your browser to it.
set "PANEL_OPEN_BROWSER=1"

echo.
echo Starting the control panel and opening it in your browser...
echo Keep this window open while you use the tool. Close it to stop the server.
echo.

REM 6) Start the local control panel (runs until you close this window).
"%VENV_PY%" app.py

echo.
echo The control panel has stopped.
pause
