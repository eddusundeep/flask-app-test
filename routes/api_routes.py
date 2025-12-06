from flask import Blueprint, jsonify
from utils.helpers import format_response
from models.user import User

bp = Blueprint('api', __name__, url_prefix='/api')

@bp.route('/status')
def status():
    """API status endpoint"""
    return jsonify(format_response({"message": "API is running"}))

@bp.route('/users')
def get_users():
    """Get sample users"""
    users = [
        User(1, "John Doe", "john@example.com"),
        User(2, "Jane Smith", "jane@example.com"),
        User(3, "Bob Wilson", "bob@example.com")
    ]
    return jsonify(format_response([user.to_dict() for user in users]))

@bp.route('/health')
def health_check():
    """Health check endpoint - NEW in v2.0"""
    return jsonify(format_response({
        "status": "healthy",
        "version": "2.0",
        "database": "connected"
    }))