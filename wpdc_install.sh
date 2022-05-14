#!/bin/bash

# Make update of repositories

sudo apt-get update

# Installing packages

sudo apt-get install ca-certificates curl gnupg lsb-release

# Add Docker's official GPG key

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/shre/keyrings/docker-archive-keyring.gpg

# Set up the stable repository

echo \ 
"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Installing Docker Engine

sudo apt-get update

sudo apt-get install docker-ce docker-ce-cli container.io docker-compose-plugin

#Create user for MySQL with user is 999

sudo userdel mysql

sudo 
