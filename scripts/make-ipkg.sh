#!/bin/bash

#
# This script packages a correct folder structure as an .ipk file
# usage: ./makepkg <target>
# it expects to find the folder structure under packages/<target>/ipkbuild
# outputs <target>_<version>_<arch>.ipk in packages/<target>/
#

# local variables
PKGDIR=ipkbuild
BUILDDIR=build

PROJECTS=$1
TARGET=$2

# TODO check existence and structure
echo "making package $TARGET..."
cd $PROJECTS/$TARGET

VERSION=`cat $PKGDIR/control/control | grep Version | cut -d' ' -f2`
ARCH=`cat $PKGDIR/control/control | grep Architecture | cut -d' ' -f2`
PACKAGE=${TARGET}_${VERSION}_${ARCH}.ipk

echo "removing previous package..."
rm $PACKAGE
mkdir $BUILDDIR

echo "creating package structure..."
echo "- control file"
cd $PKGDIR/control
tar --numeric-owner --group=0 --owner=0 -czf ../../$BUILDDIR/control.tar.gz ./*
cd ../..

echo "- data file"
cd $PKGDIR/data
tar --numeric-owner --group=0 --owner=0 -czf ../../$BUILDDIR/data.tar.gz ./*
cd ../..

echo "- signature"
cp $PKGDIR/debian-binary $BUILDDIR

echo "making package..."
cd $BUILDDIR
tar --numeric-owner --group=0 --owner=0 -czf ../$PACKAGE ./*
cd ..
# ar rv $PACKAGE $BUILDDIR/*

echo "cleaning..."
rm -rf $BUILDDIR

echo "OK"
