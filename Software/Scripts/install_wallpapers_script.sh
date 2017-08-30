#!/bin/sh
# title			: installation_Script
# description	: This script download and install numantinos wallpaper pack
# author		: https://github.com/pablomario
# date			: 28/08/2017
# version		: 0.1
# usage			: sudo ./install_wallpapers_script.sh
#
# Execute this script with root privileges

    
    # DEFINITIONS UTILS
    
    # DIRECTORYs
    USER_BACKGROUNDS_DIRECTORY="/usr/share/backgrounds"

    
    # SOFTWARE REPOSITORY
    # Add new software - softwareRepository=("software1", "software2", "software3")
    # 
    declare -a urlResourcesRepository=(
        "https://raw.githubusercontent.com/pablomario/numantinos-project/master/Artwork/Wallpapers/numantinos.jpg"
        "https://raw.githubusercontent.com/pablomario/numantinos-project/master/Artwork/Wallpapers/numantinos_base_filter_wallpaper.png"
        "https://raw.githubusercontent.com/pablomario/numantinos-project/master/Artwork/Wallpapers/numantinos_developer.jpg"
        "https://raw.githubusercontent.com/pablomario/numantinos-project/master/Artwork/Wallpapers/numantinos_ninja.jpg"
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
        
        if [ -d $USER_BACKGROUNDS_DIRECTORY ];
        then
            cd $USER_BACKGROUNDS_DIRECTORY
            mkdir _old
            mv *  _old
        fi       
    }
    
    
    # Support method
    # Download Required Software from repository
    downloadResources () {
        echo "Downloading resources..."
        cd $USER_BACKGROUNDS_DIRECTORY
        pwd
        for i in "${urlResourcesRepository[@]}"
        do
           showInfoMessage "Downloading $i"
           wget -q "$i"
           showOKMessage
        done
    }
    
    updateEnviroment() {
        echo "Updating Desktop and Workspaces..."
        #Debug
        #xfconf-query --channel xfce4-desktop --list
        
        # Create property
        #xfconf-query -c xfce4-desktop -p /backdrop/single-workspace-mode --create --type 'bool' --set 'false'

        xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorDFP2/workspace0/last-image --set /usr/share/backgrounds/numantinos.jpg 
        xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorDFP2/workspace1/last-image --set /usr/share/backgrounds/numantinos_base_filter_wallpaper.png
        xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorDFP2/workspace3/last-image --set /usr/share/backgrounds/numantinos_developer.jpg
        xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorDFP2/workspace2/last-image --set /usr/share/backgrounds/numantinos_ninja.jpg    
    }
    
    
    ### Initialization script 
    init () {
        
        # 1- Preparing pre-installation environment
        makeEnvironment
        
        # 2- Download resources
       downloadResources
        
        # 3- Installing pacakges
        updateEnviroment
        
    }
    # Execute process
    init









