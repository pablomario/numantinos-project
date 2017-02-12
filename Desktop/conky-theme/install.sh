#!/bin/sh
# 
# Numantinos
# install a 'Simple Conky Theme' 
#
echo "[numantinos]"
echo "Simple script to download a install conky theme"

# Creating resources.
REMOTE_CONKY_GIT_PATH='https://github.com/pablomario/Manjaro-simple-conky-theme.git'
TMP_PATH='/tmp/conkytheme'

# Download conky theme into local '/tmp' directory.
echo "Downloading ..."
git clone $REMOTE_CONKY_GIT_PATH $TMP_PATH

# Exit conky 'kill'
killall conky

# Copying file '.conkyrc' -> is the default  configuration file to 'numantinos'  
echo "Installing..."
cp $TMP_PATH/.conkyrc $HOME

# Deleting 'tmp' files and directory
echo "Deletin 'tmp' conky files..."
rm -rf TMP_PATH

# Restarting Conky with the new '.conkytheme' file
echo "Restart Conky..." 
conky > /dev/null
