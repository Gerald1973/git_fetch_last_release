#!/bin/bash
echo "********************************************************************************"
echo "* Compile Pinta                                                                *"
echo "********************************************************************************"
sudo apt -y install make automake autoconf mono-devel gtk-sharp2 intltool
. ./git_fetch_last_release.sh -r 'https://github.com/PintaProject/Pinta.git' -t '1.7'
cd $FETCHING_DIRECTORY
./autogen.sh
if [ $? = 0 ]; then
  make
  if [ $? = 0 ]; then
    sudo make install
    if [ $? = 0 ]; then
	    echo "Compilation of Pinta succeeded."
      cd
      pinta
    fi
  fi
fi 
