#!/bin/bash
echo "#123456789#123456789#123456789#123456789#123456789#123456789#123456789#123456789"
echo "********************************************************************************"
echo "* Compile the latest release of Amiberry                                       *"
echo "********************************************************************************"
#Backup configuration files
CURRENT_DIR=$(pwd)
cd ${HOME}
AMIBERRY_CONF_BACKUP="${HOME}/amiberryconfbackup"
AMIBERRY_CONF_DIRECTORY="${HOME}/amiberry/conf"
FIRMWARES_ORIGIN="/mnt/data_02/emulators/firmware/amiga/KS-ROMs"
GIT_REPOSITORY="https://github.com/midwan/amiberry.git"
if [[ -d ${AMIBERRY_CONF_DIRECTORY} ]]
then 
  mkdir ${AMIBERRY_CONF_BACKUP}
  cp -v ${AMIBERRY_CONF_DIRECTORY}/* ${AMIBERRY_CONF_BACKUP}
fi
cd ${CURRENT_DIR}
. ./git_fetch_last_release.sh
if [[ ${?} == 0 ]]
then
  cd ${FETCHING_DIRECTORY}
  sudo apt-get -y install libsdl2-dev libsdl2-ttf-dev libsdl2-image-dev libxml2-dev libflac-dev libmpg123-dev libpng-dev libmpeg2-4-dev
  make -j2 PLATFORM=rpi4-sdl2
  if [[ ${?} == 0 ]]
  then
    echo "Remove the previous amiberry in ${HOME}/${GIT_DIRECTORY}"
    rm -rf ${HOME}/${GIT_DIRECTORY}
    if [[ -d ${FIRMWARES_ORIGIN} ]]
    then
      cp ${FIRMWARES_ORIGIN}/* ${FETCHING_DIRECTORY}/kickstarts
    fi
    rm -rf ${FETCHING_DIRECTORY}/src
    mv -v ${FETCHING_DIRECTORY} ${HOME}
    cd ${HOME} 
    #Restore configuration files
    cp -v ${AMIBERRY_CONF_BACKUP}/* ${AMIBERRY_CONF_DIRECTORY}
    cd ${HOME}/amiberry
    ./amiberry 
  fi
fi
