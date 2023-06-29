#!/bin/bash

# Update and upgrade the system
sudo apt update -y
sudo apt upgrade -y

# Install nginx
sudo apt install nginx -y

#enable Nginx
sudo systemctl enable nginx

# start nginx
sudo systemctl start nginx

# restart nginx
sudo systemctl restart nginx

# Install Node.js (version 12.x)
curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt install nodejs -y

# Install and pm2

sudo npm install pm2 -g

# Set the DB_HOST environment variable
export DB_HOST=mongodb://20.68.23.200:27017/posts

# Copy the app folder to the VM
git clone https://github.com/HarryPaterson/tech241_sparta_app.git sparta-app

# Change to the app folder
cd sparta-app/app2

# Install app dependencies
npm install -y

# Run the Sparta app in the background using pm2

pm2 -f start app.js

