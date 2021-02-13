#!/bin/bash
# echo "********************************************************************************"
# echo "* Compile DOSBOX X last release                                                *"
# echo "********************************************************************************"
. ./git_fetch_last_release.sh -r 'https://github.com/joncampbell123/dosbox-x.git' -t 'dosbox-x-v0.83.10'
if [ $? = 0 ]; then
  cd $FETCHING_DIRECTORY 
	sudo apt -y install automake libncurses-dev nasm libsdl-net1.2-dev \
	libpcap-dev libfluidsynth-dev ffmpeg libavdevice58 libavformat-* \
	libswscale-* libavcodec-*
  ./build
  sudo make install
  if [ $? = 0 ]; then
    printf 'Are you ok to delete the directory %s ? (y/n)\n' $FETCHING_DIRECTORY
    read answer 
    if [ "${answer^^}" = "Y" ]; then
      printf 'Deletion of the following directory : %s\n' $FETCHING_DIRECTORY
    fi
    cd
    dosbox-x
  fi
fi