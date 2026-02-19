import os
import subprocess
import pickle
import json
from flask import Flask, request, render_template_string
import mysql.connector

app = Flask(__name__)
SECRET_KEY = "hardcoded_secret_12345"
DATABASE_PASSWORD = "admin123"
API_TOKEN = "sk-1234567890abcdefghijk"

# SQL Injection vulnerability
@app.route('/search')
def search():
    user_input = request.args.get('query')
    db = mysql.connector.connect(host="localhost", user="root", password=DATABASE_PASSWORD)
    cursor = db.cursor()
    query = "SELECT * FROM users WHERE name = '" + user_input + "'"
    cursor.execute(query)
    return str(cursor.fetchall())

# Command injection vulnerability
@app.route('/process')
def process_file():
    filename = request.args.get('file')
    result = subprocess.call("cat " + filename, shell=True)
    return str(result)

# Insecure deserialization
@app.route('/load')
def load_data():
    data = request.args.get('data')
    obj = pickle.loads(data)
    return str(obj)

# Template injection
@app.route('/greet')
def greet():
    name = request.args.get('name', 'World')
    template = "Hello " + name + "!"
    return render_template_string(template)

# Hardcoded credentials
def connect_to_db():
    return mysql.connector.connect(
        host="db.example.com",
        user="admin",
        password="P@ssw0rd123",
        database="sensitive_data"
    )

# Weak cryptography
import hashlib
def hash_password(password):
    return hashlib.md5(password.encode()).hexdigest()

# Unused imports and variables
import unused_module
unused_var = 42

# No input validation
@app.route('/upload', methods=['POST'])
def upload():
    file = request.files['file']
    file.save('/var/www/uploads/' + file.filename)
    return "File uploaded"

# Weak random
import random
token = random.randint(1, 1000000)

# Exception handling too broad
try:
    risky_operation()
except:
    pass

if __name__ == '__main__':
    app.run(debug=True, host='0.0.0.0')