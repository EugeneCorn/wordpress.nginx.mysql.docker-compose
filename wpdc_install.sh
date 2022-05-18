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
        echo "Deleted user $CURUSER with id 999"
        sudo userdel $CURUSER

        # Create user mysql with id 999
        echo "Created mysql user with id 999"
        sudo userdel mysql > /dev/null
        sudo useradd -u 999 mysql

        # Create past user
        echo "Created user $CURUSER"
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

