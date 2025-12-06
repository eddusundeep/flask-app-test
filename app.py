from flask import Flask
from routes import api_routes

app = Flask(__name__)

# Register blueprints
app.register_blueprint(api_routes.bp)

@app.route('/')
def home():
    return "Hello! Version 2.0 - Now with enhanced features!"

@app.route('/version')
def version():
    return {"version": "2.0", "features": ["API routes", "User models", "Helper utilities", "Version endpoint"]}

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)