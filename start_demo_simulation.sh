#!/bin/bash

# start_demo_simulation.sh
# Starts Backend, Frontend, and Admin Dashboard, then runs the demo simulation.

# Function to kill all background jobs on exit
cleanup() {
    echo ""
    echo "🛑 Shutting down all services..."
    kill $(jobs -p) 2>/dev/null
    echo "✅ All services stopped."
}

# Trap SIGINT (Ctrl+C)
trap cleanup EXIT INT TERM

echo "🚀 Starting SENTINEL X Demo Simulation Environment..."
echo "==================================================="

# 1. Start Backend
echo "📡 Starting Backend..."
./start_backend.sh > /dev/null 2>&1 &
BACKEND_PID=$!
echo "   PID: $BACKEND_PID"

# Wait for Backend to be ready
echo "⏳ Waiting for Backend API at http://localhost:8000..."
MAX_RETRIES=30
COUNT=0
while ! curl -s http://localhost:8000/health > /dev/null; do
    sleep 1
    COUNT=$((COUNT+1))
    if [ $COUNT -ge $MAX_RETRIES ]; then
        echo "❌ Backend failed to start within $MAX_RETRIES seconds."
        exit 1
    fi
done
echo "✅ Backend is UP!"

# 2. Start Frontend
echo "💻 Starting Frontend..."
./start_frontend.sh > /dev/null 2>&1 &
FRONTEND_PID=$!
echo "   PID: $FRONTEND_PID"

# 3. Start Admin Dashboard
echo "📊 Starting Admin Dashboard..."
./start_admin_dashboard.sh > /dev/null 2>&1 &
DASHBOARD_PID=$!
echo "   PID: $DASHBOARD_PID"

# Give a moment for frontends to initialize
sleep 5

echo "==================================================="
echo "🌟 Environment is ready!"
echo "   - Backend: http://localhost:8000"
echo "   - Frontend: http://localhost:5173 (usually)"
echo "   - Dashboard: http://localhost:5174 (usually)"
echo "==================================================="

# 4. Run Real-time Simulation
echo "🤖 Running Real-time Simulation (backend/simulation.py)..."
echo "   Generates live incidents and posts them to the API."
echo "---------------------------------------------------"
cd backend
./venv/bin/python simulation.py
cd ..
echo "---------------------------------------------------"

echo "🎉 Simulation stopped."
echo "ℹ️  The environment is still running."
echo "🔴 Press Ctrl+C to stop all services."

# Wait indefinitely so user can use the app
wait
