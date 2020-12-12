#!/bin/bash

_help_for_r() {
  printf -- '\t-r\n\n'
  printf '\tDefines the GIT repository, MANDATORY.\n\n'
  printf '\tUsage\n'
  printf '\t=====\n\n'
  printf "\t-r 'https://github.com/PintaProject/Pinta.git\n"
}

_help_for_t() {
  printf -- '\t-t\n\n'
  printf '\tDefines the tag, by default the last one.\n\n'
  printf '\tUsage\n'
  printf '\t=====\n\n'
  printf "\t-t '1.7'\n"
}

_help_for_d() {
  printf -- '\t-d\n\n'
  printf '\tDefines the git directory, by default git.\n\n'
  printf '\tUsage\n'
  printf '\t=====\n\n'
  printf "\t-d 'my_git_directory'\n"
}

_help() {
  _help_for_r
  printf '\n'
  _help_for_t
  printf '\n'
  _help_for_d
  printf '\n'
}

_checkout(){
  cd $FETCHING_DIRECTORY
  git checkout $TAG;
  if [ ! $? = 0 ]; then
    echo "The checkout of the tag failed." 1>&2;
    exit 1;
  fi
}

cd
MY_DIRECTORY=`pwd`
GIT=git
while getopts :r:t:d:h opt; do
  case $opt in
    r)
      GIT_REPOSITORY=$OPTARG;;
    t)
      TAG=$OPTARG;;
    d)
      GIT=$OPTARG;;
    h)
      _help;;
    *)
      _help;;
  esac
done
if [ ! -z $GIT_REPOSITORY ]; then
  GIT_DIRECTORY=`echo "${GIT_REPOSITORY##*/}"`
  GIT_DIRECTORY=`echo "${GIT_DIRECTORY%.git}"` 
  if [ -z $TAG ]; then
    TAGS=`git ls-remote -t --refs $GIT_REPOSITORY`
    TAG=`echo "${TAGS##*/}"`
  fi
  FETCHING_DIRECTORY="$MY_DIRECTORY/$GIT/$GIT_DIRECTORY"
  printf 'Git remote repository : %s\n' $GIT_REPOSITORY
  printf 'The slected tag is    : %s\n' $TAG
  printf 'Git directory         : %s\n' $GIT
  printf 'Fetching directory    : %s\n' $FETCHING_DIRECTORY
  if [ ! -d $GIT ]; then
    printf "Creation of the %s directory.\n"
    mkdir $MY_DIRECTORY/$GIT
    if [ ! $? = 0 ]; then
      echo "The creation of the %GIT directory is not possible" 1>&2
      exit 1
    fi
  fi
  cd $MY_DIRECTORY/$GIT
  if [ ! -d $FETCHING_DIRECTORY ]; then 
    git clone $GIT_REPOSITORY
    if [ ! $? = 0 ]; then
      echo "The cloning of $GIT_REPOSITORY failed." 1>&2; 
      exit 1;
    fi
  fi 
  _checkout
else
  echo "The git repository is unknown." 1>&2
  exit 1
fi