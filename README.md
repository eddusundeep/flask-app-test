# Flask Sample Project

A sample Flask application with organized folder structure.

## Structure
- `app.py` - Main application entry point
- `routes/` - API route handlers
- `models/` - Data models
- `utils/` - Helper functions

## Installation
```bash
pip install -r requirements.txt
```

## Run Locally
```bash
python app.py
```

## Endpoints
- `GET /` - Home page
- `GET /api/status` - API status
- `GET /api/users` - Get sample users

## Deploy to VPS
```bash
gunicorn --bind 0.0.0.0:5000 app:app
```