h#!/bin/sh
# title			: startingServices.sh
# description	: This script help and simplify services starting.
# author		: https://github.com/pablomario
# date			: 17/02/2017
# version		: 0.1
# usage			: sudo ./startingServices.sh
#
# Execute this script with root privileges
# 

# AVAILABLES SERVICES
SERVICE_APACHE="httpd";
SERVICE_MARIADB="mariadb";
SERVICE_MONGODB="mongodb.service";
SERVICE_DOCKER="docker";

# Status Message
STATUS_MESSAGE_ACTIVE="Active: active (running)";

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
UBLUE='\033[0;96m'
NC='\033[0m' # No Color

# Show OK Message
showOKMessage () {
    echo -e "Good, service is (${GREEN}STOPPED${NC})\n"
}

# Show Error Message when initializing service
showKOMessage () {
    echo -e "Error, The service is (${RED}ACTIVE${NC})\n"
}

# Main Script
stopService () {    
    echo -e "Stoping ${UBLUE}$1${NC} (service) ..."    
    STATUS_SERVICE=$(sudo systemctl status $1)
    if [[ $STATUS_SERVICE == *$STATUS_MESSAGE_ACTIVE* ]]; then
        sudo systemctl stop $SERVICE_APACHE;
        STATUS_SERVICE=$(sudo systemctl status $1);
        if [[ $STATUS_SERVICE == *$STATUS_MESSAGE_ACTIVE* ]]; then
            showKOMessage
        else
            showOKMessage
        fi
    else
        showOKMessage
    fi        
}


echo -e "\n> Stopping Services ... \n";
stopService $SERVICE_MONGODB
stopService $SERVICE_MARIADB
stopService $SERVICE_APACHE
stopService $SERVICE_DOCKER
# ... more services    
echo -e "Have a good day!"
