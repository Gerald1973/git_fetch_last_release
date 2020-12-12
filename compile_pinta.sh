#!/bin/bash
echo "********************************************************************************"
echo "* Compile Pinta                                                                *"
echo "********************************************************************************"
sudo apt install apt-transport-https dirmngr gnupg ca-certificates
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 3FA7E0328081BFF6A14DA29AA6A19B38D3D831EF
echo "deb https://download.mono-project.com/repo/debian stable-raspbianbuster main" | sudo tee /etc/apt/sources.list.d/mono-official-stable.list
sudo apt update && sudo apt upgrade
sudo apt install make automake autoconf mono-devel gtk-sharp2 intltool
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
