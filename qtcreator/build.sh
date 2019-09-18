#!/bin/bash

#
# This script uses the Docker image rm-qtcreator to build a qt app from command line
# usage: ./build.sh <folder> <file.pro>
# example: ./build.sh button-capture-reMarkable button-capture.pro
# the compiled binary is found in <folder>/build
#

FOLDER=$1
PROJECT=$2

DOCKER=`which docker`
HOST_PROJECTS=`pwd`/projects

TARGET=/root/projects/$FOLDER/$PROJECT
BUILD=/root/projects/$FOLDER/build

QMAKE=/opt/poky/2.1.3/sysroots/x86_64-pokysdk-linux/usr/bin/qt5/qmake
OPTS="-spec linux-oe-g++"
SOURCE="source /opt/poky/2.1.3/environment-setup-cortexa9hf-neon-poky-linux-gnueabi"

echo "building $FOLDER/$PROJECT..."
$DOCKER run -it \
  -v $HOST_PROJECTS:/root/projects \
  rm-qtcreator \
  bash -c "mkdir -p $BUILD && cd $BUILD && $SOURCE && $QMAKE $TARGET $OPTS && make"

echo "done"
BUILT="$HOST_PROJECTS/$FOLDER/build"
echo "$BUILT"
ls -la $BUILT
