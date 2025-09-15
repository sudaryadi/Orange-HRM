#!/bin/bash

set -e  # Exit on error (customize flags here if needed)

# Install dependencies if requirements file exists
if [ -f "requirements.txt" ]; then
    echo "Installing dependencies..."
    pip install -r requirements.txt
else
    echo "No requirements.txt found. Skipping dependency installation."
fi

# Run the web automation (replace with your actual run command)
echo "Running web automation..."
python main.py
