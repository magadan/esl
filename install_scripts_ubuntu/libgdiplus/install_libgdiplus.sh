#!/bin/bash

if [ $USER != "root" ]; then
   sudo $0 $HOME
   exit 0
fi

HOMEPATH="$1"
INSTALLPATH="$HOMEPATH/install_scripts_ubuntu/libgdiplus"
LIBPATH="/usr/local/lib"

sudo cp -a $INSTALLPATH/libgdiplus.so.0.0.0 $LIBPATH
sudo chmod 755 $LIBPATH/libgdiplus.so.0.0.0
sudo chown root:root $LIBPATH/libgdiplus.so.0.0.0

sudo cp -a $INSTALLPATH/libgdiplus.a $LIBPATH
sudo chmod 644 $LIBPATH/libgdiplus.a
sudo chown root:root $LIBPATH/libgdiplus.a
sudo cp -a $INSTALLPATH/libgdiplus.la $LIBPATH
sudo chmod 755 $LIBPATH/libgdiplus.la
sudo chown root:root $LIBPATH/libgdiplus.la
echo LibGDI+ moved to /usr/local/lib

sudo ln -s -f $LIBPATH/libgdiplus.so.0.0.0 $LIBPATH/libgdiplus.so.0
sudo ln -s -f $LIBPATH/libgdiplus.so.0.0.0 $LIBPATH/libgdiplus.so
echo Added symbolic links to the LibGDI+ library

sudo mkdir -p $LIBPATH/pkgconfig
sudo /usr/bin/install -c -m 664 $INSTALLPATH/libgdiplus.pc $LIBPATH/pkgconfig

#Now we need to set /usr/local/lib in the LD_LIBRARY_PATH variable and install a host of dependencies for libgdiplus.
export LD_LIBRARY_PATH=$LIBPATH${LD_LIBRARY_PATH:+:$LD_LIBRARY_PATH}
sudo apt install libcairo2 libexif12 libgif7 libjbig0 libpixman-1-0 libpng-tools libtiff5 libwebp6 libxcb-render0 libxcb-shm0 libxrender1 libc6-dev -y