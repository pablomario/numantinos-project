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
    
    # SOFTWARE REPOSITORY
    # Add new software - softwareRepository=("software1", "software2", "software3")
    # 
    declare -a softwareRepository=(
        "http://ftp.gnu.org/gnu/gnuzilla/52.1.0/icecat-52.1.0.en-US.linux-x86_64.tar.bz2"
        "http://ftp.gnu.org/gnu/gnuzilla/52.1.0/langpacks/icecat-52.1.0.es-ES.langpack.xpi"
        "http://ftp.gnu.org/gnu/gnuzilla/52.1.0/langpacks/icecat-52.1.0.es-ES.langpack.xpi.sig"
        "http://downloads.activestate.com/Komodo/releases/10.2.3/Komodo-Edit-10.2.3-17708-linux-x86_64.tar.gz"
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
    
    openDirectory() {
        thunar $USER_INSTALLATION_DIRECTORY
    }
    
    
    ### Initialization script 
    init () {
        
        # 1- Preparing pre-installation environment
        makeEnvironment
        
        # 2- Download packages
        downloadSoftware
        
        # 3- Installing pacakges
        # TODO
        #installingSoftware;
        
        # 4- Abre en ventana la crpeta "/tmp" de descarga
        openDirectory
     
        showInfoMessage "Have a nice day!"   
    }
    # Execute process
    init









