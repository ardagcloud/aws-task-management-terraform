#!/bin/bash

# Update packages
dnf update -y

# Install Python and pip
dnf install -y python3 python3-pip

# Install application dependencies
pip3 install boto3 psycopg2-binary

# Create app directory
mkdir -p /opt/app

# Create Python application
cat > /opt/app/app.py <<'PYTHON'
import os
import json
import boto3
import psycopg2
from http.server import BaseHTTPRequestHandler, HTTPServer

DB_ENDPOINT = os.environ["DB_ENDPOINT"]
SECRET_ARN = os.environ["RDS_SECRET_ARN"]

# RDS endpoint comes as hostname:port
DB_HOST = DB_ENDPOINT.rsplit(":", 1)[0]

# Get AWS region from the Secret ARN
REGION = SECRET_ARN.split(":")[3]

# Retrieve database credentials from Secrets Manager
client = boto3.client("secretsmanager", region_name=REGION)

response = client.get_secret_value(SecretId=SECRET_ARN)
secret = json.loads(response["SecretString"])

DB_USERNAME = secret["username"]
DB_PASSWORD = secret["password"]

# Connect to PostgreSQL
conn = psycopg2.connect(
    host=DB_HOST,
    port=5432,
    database="taskmanagement",
    user=DB_USERNAME,
    password=DB_PASSWORD
)

conn.autocommit = True

# Create tasks table if it does not exist
with conn.cursor() as cursor:
    cursor.execute("""
        CREATE TABLE IF NOT EXISTS tasks (
            id SERIAL PRIMARY KEY,
            title VARCHAR(255) NOT NULL
        );
    """)


class TaskHandler(BaseHTTPRequestHandler):

    def do_GET(self):

        if self.path == "/":
            self.send_response(200)
            self.end_headers()
            self.wfile.write(b"Task Management App")

        elif self.path == "/tasks":
            with conn.cursor() as cursor:
                cursor.execute("SELECT id, title FROM tasks ORDER BY id;")
                tasks = cursor.fetchall()

            body = json.dumps([
                {"id": task[0], "title": task[1]}
                for task in tasks
            ])

            self.send_response(200)
            self.send_header("Content-Type", "application/json")
            self.end_headers()
            self.wfile.write(body.encode())

        else:
            self.send_response(404)
            self.end_headers()

    def do_POST(self):

        if self.path == "/tasks":
            length = int(self.headers["Content-Length"])
            data = json.loads(self.rfile.read(length))

            with conn.cursor() as cursor:
                cursor.execute(
                    "INSERT INTO tasks (title) VALUES (%s);",
                    (data["title"],)
                )

            self.send_response(201)
            self.end_headers()
            self.wfile.write(b"Task created")

        else:
            self.send_response(404)
            self.end_headers()


HTTPServer(("0.0.0.0", 8080), TaskHandler).serve_forever()
PYTHON

# Start application
DB_ENDPOINT="${db_endpoint}" \
RDS_SECRET_ARN="${rds_secret_arn}" \
nohup python3 /opt/app/app.py > /var/log/taskapp.log 2>&1 &