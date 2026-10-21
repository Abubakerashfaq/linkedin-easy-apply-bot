#!/bin/bash
#
# Author:  Abubaker Ashfaq
# License: MIT License
#          https://opensource.org/license/mit
#
# One-click launcher for Linux. Run it with:  ./start.sh
# It sets up everything the first time, then opens the control panel in your web
# browser. Safe to run again any time.
#
# Nothing needs to be installed first, not even Python. The first run downloads
# uv (a small, widely used Python installer) into the .tools folder, and uv then
# downloads a private copy of Python and the packages. The system Python is
# never used, so it doesn't matter how old it is or if it's there.

# Move into the project folder (this script's own folder).
cd "$(dirname "$0")" || exit 1

# Pinned so every user gets the same setup that was tested.
UV_VERSION="0.12.24"
PYTHON_VERSION="3.12"
UV=".tools/uv"
VENV_PY=".venv/bin/python"

echo ""
echo "========================================================"
echo "  Easy Apply Autopilot - starting your control panel"
echo "========================================================"
echo ""

# 1) Get uv the first time. It lives in this folder, nothing is installed
#    system-wide. Some distros ship wget but not curl, so either will do.
if [ ! -x "$UV" ]; then
    echo "Downloading the installer (one time only)..."
    UV_URL="https://astral.sh/uv/$UV_VERSION/install.sh"
    if command -v curl >/dev/null 2>&1; then
        curl -LsSf "$UV_URL" | env UV_UNMANAGED_INSTALL="$PWD/.tools" sh >/dev/null
    else
        wget -qO- "$UV_URL" | env UV_UNMANAGED_INSTALL="$PWD/.tools" sh >/dev/null
    fi
    [ -x "$UV" ] || { echo "Could not download the installer. Check your internet connection and run this again."; exit 1; }
fi

# 2) Set up a private Python the first time. Also rebuilds it if it is broken,
#    or if an older version of this script built it on a system Python that is
#    too old for the AI packages.
if ! "$VENV_PY" -c 'import sys; sys.exit(sys.version_info < (3, 10))' >/dev/null 2>&1; then
    echo "Setting up Python (one time only)..."
    rm -rf .venv
    "$UV" venv --quiet --seed --managed-python --python "$PYTHON_VERSION" .venv \
        || { echo "Could not set up Python. Check your internet connection and run this again."; exit 1; }
fi

# 3) Install the required packages. Runs again whenever .deps_installed is
#    missing, which is how the in-app updater brings in new requirements.
if [ ! -f ".venv/.deps_installed" ]; then
    echo "Installing required packages (one time only, this can take a few minutes)..."
    "$UV" pip install --quiet --python "$VENV_PY" -r requirements.txt \
        || { echo "Could not install required packages. Check your internet connection and run this again."; exit 1; }
    touch ".venv/.deps_installed"
fi

# 4) Google Chrome (or Chromium) is the one thing this can't set up for you.
if ! command -v google-chrome >/dev/null 2>&1 && ! command -v google-chrome-stable >/dev/null 2>&1 \
   && ! command -v chromium >/dev/null 2>&1 && ! command -v chromium-browser >/dev/null 2>&1; then
    echo ""
    echo "Google Chrome is needed to apply for jobs, and it isn't installed."
    echo "Get it from https://www.google.com/chrome/ then carry on in the control panel."
    command -v xdg-open >/dev/null 2>&1 && xdg-open "https://www.google.com/chrome/" >/dev/null 2>&1 &
fi

# 5) Start the control panel. It chooses a free port, prints the address, and
#    opens your browser to it.
export PANEL_OPEN_BROWSER=1

echo ""
echo "Starting the control panel and opening it in your browser..."
echo "The address is printed below. Keep this terminal open; press Ctrl+C to stop."
echo ""

# 6) Start the local control panel (runs until you press Ctrl+C).
"$VENV_PY" app.py
