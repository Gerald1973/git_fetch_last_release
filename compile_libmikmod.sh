#!/bin/bash
echo "********************************************************************************"
echo "* Compile libmikmod                                                                *"
echo "********************************************************************************"
sudo apt-get -y install libudev-dev libasound2-dev libdbus-1-dev
. ./git_fetch_last_release.sh -r 'https://github.com/sezero/mikmod.git' -t 'libmikmod-3.3.11.1'
if [ $? = 0 ]; then
  cd $FETCHING_DIRECTORY/libmikmod
  echo `pwd`
  mkdir build
  cd build
  cmake ..
  if [ $? = 0 ]; then
    make
    if [ $? = 0 ]; then
      sudo make install
    fi
  fi
fi 