#!/bin/bash
echo "#123456789#123456789#123456789#123456789#123456789#123456789#123456789#123456789"
echo "********************************************************************************"
echo "* Compile the latest release of Amiberry                                       *"
echo "********************************************************************************"
#Backup configuration files
cd
AMIBERRY_CONF_DIRECTORY=`pwd`/amiberry/conf
AMIBERRY_CONF_BACKUP=`pwd`/amiberryconfbackup
if [ -d $AMIBERRY_CONF_DIRECTORY ]
then 
  mkdir amiberryconfbackup
  cp -v $AMIBERRY_CONF_DIRECTORY/* $AMIBERRY_CONF_BACKUP
fi
GIT_REPOSITORY=https://github.com/midwan/amiberry.git
FIRMWARES_ORIGIN=/mnt/kodi_d/emulators/firmware/amiga/KS-ROMs
. ./git/git_fetch_last_release/git_fetch_last_release.sh
if [ $? = 0 ]
then
  sudo apt-get -y install libsdl2-dev libsdl2-ttf-dev libsdl2-image-dev libxml2-dev libflac-dev libmpg123-dev libpng-dev libmpeg2-4-dev
  cd $FETCHING_DIRECTORY
  make -j4 PLATFORM=rpi4-sdl2
  if [ $? = 0 ]
  then
    if [ -d $FIRMWARES_ORIGIN ]
    then
      cp $FIRMWARES_ORIGIN/* $SOURCE_DIRECTORY/kickstarts
    fi
    rm -rf $SOURCE_DIRECTORY/src
    mv -v $SOURCE_DIRECTORY $MY_DIRECTORY
    cd $MY_DIRECTORY/$GIT_DIRECTORY
    #Restore configuration files
    cp -v $AMIBERRY_CONF_BACKUP/* $AMIBERRY_CONF_DIRECTORY
    ./amiberry
  fi
fi
