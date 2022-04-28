#!/bin/bash

HOMEPATH=$2

SVC="eslcorewebapp.service"
WEBROOT="/var/www"
WEBFOLDER="$WEBROOT/eslcorewebapp"

CERTFILEPATH="$WEBFOLDER/ebs-50.pfx"
CERTCONFPATH="$WEBFOLDER/certificate.json"

DEPLOY="$HOMEPATH/linux_x64_deploy"
SCRIPTSFOLDER="$HOMEPATH/install_scripts_ubuntu"
DEPCERTFILE="$DEPLOY/ebs-50.pfx"
DEPCERTCONF="$DEPLOY/certificate.json"



#First we need to check if ESL Server service already runs
#(should only be false at the very first time this script runs,
#since you don't want to register a service if the files do not exist yet)
if [ "$(systemctl is-active $SVC)" = "active" ]; then
    echo "Stopping ESL Web Server..."
	sudo systemctl stop $SVC
	echo "Stopped"
fi

if [ -d $WEBFOLDER ]; then
  if [ -f $CERTCONFPATH ]; then
    if [ -f $CERTFILEPATH ]; then
      cp $CERTCONFPATH $DEPLOY/
      cp $CERTFILEPATH $DEPLOY/
      echo "Existing certificate configuration backed up"
    else
      echo "The certificate.json file exists in the current installation, but I could not find the certificate (*.pfx) itself. This deployscript probably has the wrong path set for the certificate file. Please edit deployscript.sh accordingly."
      exit 2
    fi
  else
    #The webfolder exists, but without certificate.json file. That means our existing installation is running without HTTPS protection, so we must remove the default files present in the new installation.
    rm -rf $DEPCERTCONF $DEPCERTFILE
  fi
fi

if [ -d $WEBFOLDER/Templates/ ]; then
  cp -a $WEBFOLDER/Templates/ $DEPLOY/
  echo "Existing templates folder recovered"
else
  cp -a $SCRIPTSFOLDER/Templates/ $DEPLOY/
  echo "No existing templates, defaults will be used"
fi

if [ -f $WEBFOLDER/appsettings.json ]; then
  cp $WEBFOLDER/appsettings.json $DEPLOY/
  echo "Existing application settings file recovered"
fi


#The following two are usually not necessary to be backed up, as they are stored on a per-user basis. However, they do contain configurations set during the original installation, so backing them up if they exist is good practice.
if [ -f $WEBFOLDER/app.config ]; then
  cp $WEBFOLDER/app.config $DEPLOY/
fi
if [ -f $WEBFOLDER/EslCoreWebApplication.dll.config ]; then
  cp $WEBFOLDER/EslCoreWebApplication.dll.config $DEPLOY/
fi

echo "Backed up existing configuration to the new source folder, now removing the current installation"
sudo rm -r -f $WEBFOLDER

echo "Copying new source files to the web folder (this may take a while...)"
if [ ! -d $WEBROOT ]; then
  sudo mkdir -p $WEBROOT
fi
sudo cp -a $DEPLOY/ $WEBFOLDER
sudo chmod 775 $WEBFOLDER/EslCoreWebApplication

#If the service is not yet enabled (usually only on first time this script runs) enable the service
if [ "$(systemctl is-enabled $SVC)" != "enabled" ]; then
    echo "Registering ESL Web Server as a service..."
	sudo cp -a $SCRIPTSFOLDER/$SVC /etc/systemd/system/
	sudo systemctl enable $SVC
fi

#Since the webfolder has been updated and we either stopped an enabled service or registered an unknown service, we can now safely boot.
sudo systemctl start $SVC

echo "Updating complete. Please wait 15 seconds for ESL Web Server to finish starting up"
