#!/bin/sh
# title			: Install Astronomy Basic Software
# description	: This script help and simplify installation 
# author		: https://github.com/pablomario
# date			: 11/05/2018
# version		: 0.1
# usage			: sudo ./install_astronomy.sh
#
# Execute this script with root privileges
cd
    
    # DEFINITIONS UTILS
    
    # DIRECTORYs
    USER_INSTALLATION_DIRECTORY=$(pwd $1)/tmp
    
    # SOFTWARE REPOSITORY
    declare -a softwareRepository=(
        "sudo pacman -S celestia"
        "sudo pacman -S stellarium"
        "yaourt -S qastrocam-g2"
        "yaourt -S skychart"
        "yaourt -S xephem"
        "yaourt -S starplot"
        )
    
    # COLORS
    RED='\033[0;31m'
    GREEN='\033[0;32m'
    UBLUE='\033[0;96m'
    NC='\033[0m' # No Color

    # Show Info Message
    showInfoMessage() {
        echo -e "INFO - ${UBLUE}$1${NC}"
    }
    
    # Show OK Message
    showOKMessage () {
        if [[ $1 ]];
        then
            echo -e "${GREEN}$1${NC}\n"
        else
            echo -e "${GREEN}OK${NC}"
        fi
    }
    
    # Show Error Message
    showKOMessage () {
        echo -e "ERROR - ${RED}$1${NC}\n"
    }
        
           
    # Support method
    # Preparing pre-installation environment
    makeEnvironment () {
        echo "Preparing pre-installation environment..."
        cd        
        echo "$RUTA"
        if [ ! -d $USER_INSTALLATION_DIRECTORY ];
        then
            mkdir $USER_INSTALLATION_DIRECTORY
        fi
        cd $USER_INSTALLATION_DIRECTORY
        ACTUAL_DIRECTORY=$(pwd $1)
        if [[ $USER_INSTALLATION_DIRECTORY == *$ACTUAL_DIRECTORY*  ]];
        then
            showOKMessage "The '$ACTUAL_DIRECTORY' Directory was created successfully"
        else
            showKOMessage "An unexpected problem occured - function 'makeEnvironment' "
        fi
    }
    
    
    # Support method
    # Install Software from repository
    installSoftware () {
        echo "Installing Astronomy Software..."
        cd $USER_INSTALLATION_DIRECTORY
        for i in "${softwareRepository[@]}"
        do
           showInfoMessage "[Installation] Operation: $i"
           $($i)
           showOKMessage
        done
    }
    
    openDirectory() {
        thunar $USER_INSTALLATION_DIRECTORY
    }
    
    
    ### Initialization script 
    init () {
        
        # 1- Preparing pre-installation environment
        makeEnvironment
        
        # 2- Install packages
        installSoftware
     
        showInfoMessage "Have a nice day!"   
    }
    # Execute process
    init









