# Deployment Guide

## Quick Deploy (Recommended)

On your VPS, run ONE command:

```bash
cd /home/Trading/flask-app-test && ./deploy.sh
```

That's it! The script will:
- Pull latest changes from GitHub
- Install dependencies
- Restart the application

## Deploy Specific Version

```bash
./deploy.sh v1.0    # Deploy version 1.0
./deploy.sh v2.0    # Deploy version 2.0
./deploy.sh main    # Deploy latest
```

## First-Time Setup (One Time Only)

```bash
# 1. Clone repository
cd /home/Trading
git clone https://github.com/eddusundeep/flask-app-test.git
cd flask-app-test

# 2. Setup Python environment
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# 3. Make deploy script executable
chmod +x deploy.sh

# 4. Run the app
./deploy.sh
```

## Local Development Workflow

```bash
# 1. Make your changes locally
# 2. Test locally: python app.py
# 3. Commit and push
git add .
git commit -m "Your changes"
git push origin main

# 4. On VPS - run ONE command:
./deploy.sh
```

## Useful Commands

```bash
# Check if app is running
curl http://localhost:5000/

# View live logs
tail -f gunicorn.log

# Stop the app
pkill gunicorn

# Check running processes
ps aux | grep gunicorn
```
