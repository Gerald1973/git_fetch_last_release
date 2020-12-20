#!/bin/bash
echo "********************************************************************************"
echo "* Compile SDL 2 last release                                                   *"
echo "* More instruction on :                                                        *"
echo "* https://github.com/SDL-mirror/SDL/blob/master/docs/README-raspberrypi.md     *"
echo "********************************************************************************"
sudo apt-get -y install libudev-dev libasound2-dev libdbus-1-dev
. ./git_fetch_last_release.sh -r 'https://github.com/SDL-mirror/SDL.git' -t 'release-2.0.12'
if [ $? = 0 ]; then
  cd $FETCHING_DIRECTORY
  ./configure
  ./build
  sudo make install
  if [ $? = 0 ]; then
    printf 'Are you ok to delete the directory %s ? (y/n)\n' $FETCHING_DIRECTORY
    read answer 
    if [ "${answer^^}" = "Y" ]; then
      printf 'Deletion of the following directory : %s\n' $FETCHING_DIRECTORY
    fi
  fi
fi