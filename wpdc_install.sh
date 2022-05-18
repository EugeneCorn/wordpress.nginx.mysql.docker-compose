#!/bin/bash

# Make update of repositories

sudo apt-get update

# Installing packages

sudo apt-get -y install ca-certificates curl gnupg lsb-release

# Add Docker's official GPG key

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

# Set up the stable repository

echo \ 
"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Installing Docker Engine

sudo apt-get update

sudo apt-get -y install docker-ce docker-ce-cli container.io docker-compose-plugin


#Create user for MySQL with user id 999

#If user mysql exist
if [ `id -u --name 999 2> /dev/null` = "mysql" ]; then

        echo "Current mysql id is 999."

#If /etc/passwd have another user with id 999
elif [ `id -u --name 999 2> /dev/null`  != "mysql" ]; then

        #Make variable with name of current user with id 999

        id -u --name 999 > fileforscript.himark

        CURUSER=`cat ./fileforscript.himark`

        # Delete current user with id 999
        echo "Delete user $CURUSER with id 999"
        sudo userdel $CURUSER

        # Create user mysql with id 999
        echo "Create mysql user with id 999"
        sudo userdel mysql
        sudo useradd -u 999 mysql

        # Create past user
        echo "Create user $CURUSER"
        sudo useradd $CURUSER

        # remove temporary files
        rm ./fileforscript.himark


#If user mysql don't exist
else
        #Create user mysql with id 999
        sudo userdel mysql
        sudo useradd -u 999 mysql

        echo "Created mysql user with id 999"

fi 2> /dev/null

#Create directory and set the owner for it

sudo mkdir -p /data/mysql
sudo chown -R mysql:mysql /data/mysql


#Create user www-data for NGINX with user id 82

#If user www-data exist
if [ `id -u --name 82 2> /dev/null` = "www-data" ]; then

        echo "Current www-data id is 82."

#If /etc/passwd have another user with id 82
elif [ `id -u --name 82 2> /dev/null`  != "www-data" ]; then

        #Make variable with name of current user with id 82
        id -u --name 82 > fileforscript1.himark

        CURUSER=`cat ./fileforscript1.himark`

        # Delete current user with id 82
        echo "Delete user $CURUSER with id 82"
        sudo userdel $CURUSER

        # Create user www-data with id 82
        echo "Create www-data user with id 82"
        sudo userdel www-data 
        sudo useradd -u 82 www-data

        # Create past user
        echo "Create user $CURUSER"
        sudo useradd $CURUSER

        # remove temporary files
        rm ./fileforscript1.himark


#If user www-data don't exist
else
        #Create user www-data with id 82
        sudo userdel www-data
        sudo useradd -u 82 www-data

        echo "Created www-data user with id 82"

fi 2> /dev/null

# Create directories for NGINX /data/html and set owner for it
sudo mkdir -p /data/html /data/nginx
sudo chown -R www-data:www-data /data/html /data/nginx

# Copy config file for docker-nginx
sudo cp ./nginx.conf /data/nginx

# Start docker-compose containers
sudo docker-compose up -d
