def get_timestamp():
    """Get current timestamp"""
    from datetime import datetime
    return datetime.now().strftime("%Y-%m-%d %H:%M:%S")

def format_response(data, status="success"):
    """Format API response"""
    return {
        "status": status,
        "data": data,
        "timestamp": get_timestamp()
    }