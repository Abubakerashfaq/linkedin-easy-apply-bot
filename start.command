#!/bin/bash
#
# Author:  Abubaker Ashfaq
# License: MIT License
#          https://opensource.org/license/mit
#
# One-click launcher for macOS. Double-click this file in Finder (or run it from
# a terminal). It sets up everything the first time, then opens the control
# panel in your web browser. Safe to run again any time.
#
# Nothing needs to be installed first, not even Python. The first run downloads
# uv (a small, widely used Python installer) into the .tools folder, and uv then
# downloads a private copy of Python and the packages. The Python that comes
# with macOS is never used, so it doesn't matter how old it is or if it's there.

# Move into the project folder (this script's own folder).
cd "$(dirname "$0")" || exit 1

# Pinned so every user gets the same setup that was tested.
UV_VERSION="0.12.24"
PYTHON_VERSION="3.12"
UV=".tools/uv"
VENV_PY=".venv/bin/python"

fail() {
    echo ""
    echo "$1"
    echo ""
    read -r -p "Press Return to close..." _
    exit 1
}

echo ""
echo "========================================================"
echo "  Easy Apply Autopilot - starting your control panel"
echo "========================================================"
echo ""

# 1) Get uv the first time. It lives in this folder, nothing is installed
#    system-wide.
if [ ! -x "$UV" ]; then
    echo "Downloading the installer (one time only)..."
    curl -LsSf "https://astral.sh/uv/$UV_VERSION/install.sh" | env UV_UNMANAGED_INSTALL="$PWD/.tools" sh >/dev/null
    [ -x "$UV" ] || fail "Could not download the installer. Check your internet connection and run this again."
fi

# 2) Set up a private Python the first time. Also rebuilds it if it is broken,
#    or if an older version of this script built it on the Mac's own Python 3.9,
#    which is too old for the AI packages.
if ! "$VENV_PY" -c 'import sys; sys.exit(sys.version_info < (3, 10))' >/dev/null 2>&1; then
    echo "Setting up Python (one time only)..."
    rm -rf .venv
    "$UV" venv --quiet --seed --managed-python --python "$PYTHON_VERSION" .venv \
        || fail "Could not set up Python. Check your internet connection and run this again."
fi

# 3) Install the required packages. Runs again whenever .deps_installed is
#    missing, which is how the in-app updater brings in new requirements.
if [ ! -f ".venv/.deps_installed" ]; then
    echo "Installing required packages (one time only, this can take a few minutes)..."
    "$UV" pip install --quiet --python "$VENV_PY" -r requirements.txt \
        || fail "Could not install required packages. Check your internet connection and run this again."
    touch ".venv/.deps_installed"
fi

# 4) Google Chrome is the one thing this can't set up for you.
if [ ! -d "/Applications/Google Chrome.app" ] && [ ! -d "$HOME/Applications/Google Chrome.app" ]; then
    echo ""
    echo "Google Chrome is needed to apply for jobs, and it isn't installed."
    echo "Opening the download page. Install Chrome, then carry on in the control panel."
    open "https://www.google.com/chrome/"
fi

# 5) Start the control panel. It chooses a free port (port 5000 is used by
#    AirPlay on macOS), prints the address, and opens your browser to it.
export PANEL_OPEN_BROWSER=1

echo ""
echo "Starting the control panel and opening it in your browser..."
echo "Keep this window open while you use the tool. Close it to stop the server."
echo ""

# 6) Start the local control panel (runs until you close this window).
"$VENV_PY" app.py

echo ""
read -r -p "The control panel has stopped. Press Return to close..." _
