#!/bin/bash

# Update packages
dnf update -y

# Install Python
dnf install -y python3

# Create app directory
mkdir -p /opt/app

# Create a simple test page
echo "Task Management App Server" > /opt/app/index.html

# Start a web server on port 8080
cd /opt/app
nohup python3 -m http.server 8080 > /var/log/taskapp.log 2>&1 &