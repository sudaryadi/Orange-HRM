@echo off
REM This is the batch equivalent of build.sh

REM Install dependencies if requirements.txt exists
if exist requirements.txt (
    echo Installing dependencies...
    pip install -r requirements.txt
) else (
    echo No requirements.txt found. Skipping dependency installation.
)

REM Run the web automation (replace with your actual command, e.g., python main.py)
echo Running web automation...
python main.py
