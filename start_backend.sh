#!/bin/bash

# Navigate to backend directory
cd "$(dirname "$0")/backend"

# Check if venv exists
if [ ! -d "venv" ]; then
    echo "Virtual environment not found. Please create it first."
    exit 1
fi

echo "🚀 Starting SENTINEL X Backend..."
echo "API will be available at http://localhost:8000"
echo "Press Ctrl+C to stop"
echo "----------------------------------------"

# Run the application
./venv/bin/uvicorn main:app --reload --host 0.0.0.0 --port 8000
