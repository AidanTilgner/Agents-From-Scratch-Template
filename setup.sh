#!/bin/bash

# Check Python version
python_version=$(python -c 'import sys; print(".".join(map(str, sys.version_info[:2])))')
required_version="3.10"

if [ "$(printf '%s\n' "$required_version" "$python_version" | sort -V | head -n1)" != "$required_version" ]; then 
    echo "Error: This script requires Python $required_version or higher."
    echo "Your current Python version is $python_version"
    exit 1
fi

echo "Python version check passed. Creating virtual environment..."

# Create a Python virtual environment
python -m venv ./venv/

echo "Python virtual environment created in ./venv/"
echo "Activating the virtual environment..."

# Source the activate script to activate the virtual environment
source ./venv/bin/activate

echo "Virtual environment activated. Installing dependencies..."

# Check if requirements.txt exists
if [ -f "requirements.txt" ]; then
    pip install -r requirements.txt
    echo "Dependencies installed successfully."
else
    echo "Warning: requirements.txt not found. No dependencies were installed."
fi

echo "Updating requirements.txt with current dependencies..."
pip freeze > requirements.txt
echo "requirements.txt has been updated."

echo "Setup complete. You can now start working in your Python $python_version virtual environment."
