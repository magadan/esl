#!/bin/bash

if [ $USER != "root" ]; then
   sudo $0 $HOME
   exit 0
fi

INSTALLPATH="$1/install_scripts_ubuntu/apache2"
APACHEFOLDER="/etc/apache2"
CONFFILE="esl-webapp.conf"

sudo apt install apache2 -y
sudo cp -a "$INSTALLPATH/$CONFFILE" "$APACHEFOLDER/sites-available/"
sudo a2enmod proxy_http proxy_html proxy_wstunnel rewrite 
sudo a2dissite 000-default.conf
sudo a2ensite $CONFFILE
sudo systemctl reload apache2.service