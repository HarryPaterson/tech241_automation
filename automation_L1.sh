#!/bin/bash

# Update and upgrade the system
sudo apt update
sudo apt upgrade -y

# Install Node.js (version 12.x)
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt install nodejs -y

# Install Nginx and pm2

sudo apt install nginx -y
sudo npm install pm2 -g

# Restart and enable Nginx
sudo systemctl restart nginx
sudo systemctl enable nginx

# Copy the app folder to the VM
git clone https://github.com/HarryPaterson/tech241_sparta_app.git /home/adminuser/sparta-app
# Change to the app folder
cd /home/adminuser/sparta-app/app2

# Install app dependencies
npm install

# Run the Sparta app in the background using pm2

pm2 start app.js --name sparta-app

# Set the DB_HOST environment variable
export DB_HOST="mongodb://20.108.20.81:27017/posts"

