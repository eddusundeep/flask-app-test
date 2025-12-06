#!/bin/bash
# Automated deployment script for VPS
# Usage: ./deploy.sh [version]
# Example: ./deploy.sh v2.0  or  ./deploy.sh main

VERSION=${1:-main}
PORT=5000

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
git stash 2>/dev/null
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
nohup gunicorn --bind 0.0.0.0:$PORT app:app > gunicorn.log 2>&1 &

# Wait a moment for the app to start
sleep 2

# Get public IP address
PUBLIC_IP=$(curl -s ifconfig.me || curl -s icanhazip.com || hostname -I | awk '{print $1}')

# Test if app is running
if curl -s http://localhost:$PORT/ > /dev/null 2>&1; then
    APP_STATUS="✓ RUNNING"
    APP_RESPONSE=$(curl -s http://localhost:$PORT/)
else
    APP_STATUS="✗ FAILED - Check logs below"
fi

echo ""
echo "=========================================="
echo "  DEPLOYMENT SUCCESSFUL!"
echo "=========================================="
echo ""
echo "Version:        $VERSION"
echo "Status:         $APP_STATUS"
echo "Server IP:      $PUBLIC_IP"
echo "Port:           $PORT"
echo ""
echo "Access your app from Windows PC:"
echo "  → http://$PUBLIC_IP:$PORT/"
echo ""
if [ ! -z "$APP_RESPONSE" ]; then
    echo "Response: $APP_RESPONSE"
    echo ""
fi
echo "Available endpoints:"
echo "  → http://$PUBLIC_IP:$PORT/"
echo "  → http://$PUBLIC_IP:$PORT/api/status"
echo "  → http://$PUBLIC_IP:$PORT/api/users"
if [ "$VERSION" != "v1.0" ]; then
    echo "  → http://$PUBLIC_IP:$PORT/version"
    echo "  → http://$PUBLIC_IP:$PORT/api/health"
fi
echo ""
echo "Useful commands:"
echo "  View logs:      tail -f gunicorn.log"
echo "  Stop app:       pkill gunicorn"
echo "  Switch version: ./deploy.sh v1.0 or ./deploy.sh v2.0"
echo ""
echo "=========================================="
