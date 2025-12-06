from flask import Flask

app = Flask(__name__)

@app.route('/')
def home():
    return "Hello! Version 1.0"

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)
```

**requirements.txt**
```
flask==3.0.0
gunicorn==21.2.0
```

**.gitignore**
```
__pycache__/
*.pyc
venv/
.env