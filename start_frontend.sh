#!/bin/bash

# Navigate to frontend directory
cd "$(dirname "$0")/Sentinel_X_Frontend/cyber-sentinel-67"

echo "🌐 Starting SENTINEL X Frontend..."
echo "Waiting for backend to be ready..."
echo "Press Ctrl+C to stop"
echo "----------------------------------------"

# Run the application
npm run dev
