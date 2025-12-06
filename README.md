# Flask Sample Project - Version 2.0

A sample Flask application with organized folder structure.

## Version History
- **v2.0** - Added version endpoint, health check, additional user
- **v1.0** - Initial release

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
- `GET /version` - Get version info (v2.0+)
- `GET /api/status` - API status
- `GET /api/users` - Get sample users
- `GET /api/health` - Health check (v2.0+)

## Deploy to VPS
```bash
gunicorn --bind 0.0.0.0:5000 app:app
```