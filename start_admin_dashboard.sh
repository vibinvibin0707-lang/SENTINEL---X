#!/bin/bash

# Navigate to Admin-Dashboard directory
cd "$(dirname "$0")/Admin-Dashboard"

echo "🌐 Starting SENTINEL X Admin Dashboard..."
echo "Waiting for backend to be ready..."
echo "Press Ctrl+C to stop"
echo "----------------------------------------"

# Check if node_modules exists
if [ ! -d "node_modules" ]; then
    echo "📦 Installing dependencies..."
    npm install
fi

# Run the application
npm run dev
