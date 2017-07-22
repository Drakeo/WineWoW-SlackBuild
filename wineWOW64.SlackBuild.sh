#!/bin/bash

PRGNAM=wineWOW64
VERSION=${VERSION:-2.13}
BUILD=${BUILD:-3}
TAG=${TAG:-_SBo}
GTAG=wine-2.13

if [ -z "$ARCH" ]; then
  case "$( uname -m )" in
    i?86) ARCH=i486 ;;
    arm*) ARCH=arm ;;
       *) ARCH=$( uname -m ) ;;
  esac
fi

CWD=$(pwd)
TMP=${TMP:-/tmp/SBo}
PKG=$TMP/package-$PRGNAM
OUTPUT=${OUTPUT:-/tmp}

if [ "$ARCH" = "i486" ]; then
  SLKCFLAGS="-O2 -march=i486 -mtune=i686"
  LIBDIRSUFFIX=""
elif [ "$ARCH" = "i686" ]; then
  SLKCFLAGS="-O2 -march=i686 -mtune=i686"
  LIBDIRSUFFIX=""
elif [ "$ARCH" = "x86_64" ]; then
  SLKCFLAGS="-O2 -fPIC"
  LIBDIRSUFFIX="64"
else
  SLKCFLAGS="-O2"
  LIBDIRSUFFIX=""
fi


set -e

rm -rf $PKG
mkdir -p $TMP $PKG $OUTPUT
cd $TMP
rm -rf $PRGNAM-$VERSION
mkdir -p $PRGNAM-$VERSION/wine64-build
mkdir -p $PRGNAM-$VERSION/wine32-build
cd $PRGNAM-$VERSION
if [ -d $CWD/wine  ]
then
echo use our own wine version
sleep 4
cp -rf $CWD/wine $TMP/$PRGNAM-$VERSION
else
echo cloning wine takes a few
git clone git://source.winehq.org/git/wine.git
cd wine
git checkout $GTAG
fi
#tar xvf $CWD/$PRGNAM-$VERSION.tar.gz
cd $TMP
cd $PRGNAM-$VERSION

chown -R root:root .
find -L . \
 \( -perm 777 -o -perm 775 -o -perm 750 -o -perm 711 -o -perm 555 -o -perm 511 \) \
 -exec chmod 755 {} \; -o \
 \( -perm 666 -o -perm 664 -o -perm 600 -o -perm 444 -o -perm 440 -o -perm 400 \) \
 -exec chmod 644 {} \;


cd wine64-build
echo build64
sleep 2
../wine/configure --enable-win64
make -j8

cd $TMP
cd $PRGNAM-$VERSION
cd wine32-build
echo build32
sleep 2
PKG_CONFIG_PATH=/usr/lib/pkgconfig  ../wine/configure --with-win64=../wine64-build
make -j8
make install DESTDIR=$PKG
cd $TMP
cd $PRGNAM-$VERSION
cd wine64-build
make install DESTDIR=$PKG

cd $PKG
/sbin/makepkg -l y -c n $OUTPUT/$PRGNAM-$VERSION-$ARCH-$BUILD$TAG.${PKGTYPE:-tgz}

