#!/bin/sh
# title			: installation_Script
# description	: This script help and simplify installation 
# author		: https://github.com/pablomario
# date			: 28/08/2017
# version		: 0.1
# usage			: sudo ./installationScript.sh
#
# Execute this script with root privileges
cd
    
    # DEFINITIONS UTILS
    
    # DIRECTORYs
    USER_INSTALLATION_DIRECTORY=$(pwd $1)/tmp
    DEFAULT_THEMES_DIRECTORY="/usr/share/plymouth/themes/"
    
    # SOFTWARE REPOSITORY
    # A plymouth theme
    # 
    declare -a softwareRepository=(
        "https://github.com/pablomario/numantinos-project/blob/master/Artwork/plymouth/plymouthd.conf"
        "https://github.com/pablomario/numantinos-project/tree/master/Artwork/plymouth/numantinos-elegant"
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
    # Download Required Software from repository
    downloadSoftware () {
        echo "Download Required Software..."
        cd $USER_INSTALLATION_DIRECTORY
        for i in "${softwareRepository[@]}"
        do
           showInfoMessage "Downloading $i"
           wget -q "$i"
           showOKMessage
        done
    }
    
    installTheme() {
        echo "Installing numantinos-elegant theme..."
        sudo cp -a -r $USER_INSTALLATION_DIRECTORY/numantinos-elegant $DEFAULT_THEMES_DIRECTORY
        sudo cp $USER_INSTALLATION_DIRECTORY/plymouthd.conf /etc/plymouth/plymouthd.conf
        showInfoMessage "Installing theme, re-compile kernel"
        showKOMessage "do not panic!!!, please"
        sudo plymouth-set-default-theme -R numantinos-elegant
        reboot
    }
    
    
    ### Initialization script 
    init () {
        
        # 1- Preparing pre-installation environment
        makeEnvironment
        
        # 2- Download packages
        downloadSoftware
        
        # 3- Installing plymouth theme
        installTheme;
        
     
        showInfoMessage "Have a nice day!"   
    }
    # Execute process
    init









