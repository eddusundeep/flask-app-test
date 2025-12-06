#!/bin/bash
# Automated deployment script for VPS
# Usage: ./deploy.sh [version]
# Example: ./deploy.sh v2.0  or  ./deploy.sh main

VERSION=${1:-main}

echo "================================"
echo "Deploying Flask App - $VERSION"
echo "================================"

# Navigate to app directory
cd /home/Trading/flask-app-test || exit 1

# Fetch latest changes
echo "[1/5] Fetching updates from GitHub..."
git fetch --all --tags

# Checkout specified version
echo "[2/5] Switching to $VERSION..."
git checkout $VERSION
git pull origin $VERSION 2>/dev/null || echo "Already on latest"

# Activate virtual environment
echo "[3/5] Activating virtual environment..."
source venv/bin/activate

# Install/update dependencies
echo "[4/5] Installing dependencies..."
pip install -q -r requirements.txt

# Restart application
echo "[5/5] Restarting application..."
pkill gunicorn 2>/dev/null || echo "No running instance found"
sleep 2
nohup gunicorn --bind 0.0.0.0:5000 app:app > gunicorn.log 2>&1 &

echo ""
echo "✓ Deployment complete!"
echo "✓ Application is running on port 5000"
echo ""
echo "Check status: curl http://localhost:5000/"
echo "View logs: tail -f gunicorn.log"
echo ""
