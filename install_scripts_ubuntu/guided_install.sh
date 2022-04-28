#!/bin/bash

if [ $USER != "root" ]; then
   sudo $0 $USER $HOME
   exit 0
fi

#Global variables, that you can change around if needed. Further down are local variables storing answers in the wizard
HOMEPATH=$2
INSTALLPATH="$HOMEPATH/install_scripts_ubuntu"
DEPLOYPATH="$HOMEPATH/linux_x64_deploy"

#Default variables, paths that are default in the files provided by Opticon
APPCONFPATH="$INSTALLPATH/appconfig"
MYSQLCONF="mysql_app.config"
MYSQLSVC="$INSTALLPATH/mysql/eslcorewebapp.service"
CSVCONF="csv_products_sqlite_logs_app.config"
CSVDB="$INSTALLPATH/csv/dbase.csv"
CSVSVC="$INSTALLPATH/csv/eslcorewebapp.service"

echo
echo "******************************************************"
echo "*   Copyright (c) 2021, Opticon Sensors Europe BV.   *"
echo "******************************************************"
echo
echo "Welcome to the dependency installer for ESL Web Server. Thank you for choosing our software! This will install some of the required and optional dependencies that ESL Web Server may need."

if [ ! -d $DEPLOYPATH/ ]; then
  echo
  echo "The application folder could not be found in the default location ('"$DEPLOYPATH"'), which is necessary for applying configuration settings based on choices you'll make during this installation. Please ensure that this folder is available in the expected path and try again."  
  exit 126
fi

echo
echo "I'll need to ask you some questions to personalize your setup. Answer with [y]es and [n]o. At any question you can press [s] to [s]top this installation tool."

#These variables are defaulted to not install anything at all
installlibgdiplus=false;
verafonts=false;
installmysql=false;
listenall=false;
installapache=false;

echo "--------------------------------------------------"
echo
echo "Let's start with the most important dependency; ESL Web Server requires the libgdiplus library in order to draw the images that will be displayed on the ESLs. Unfortunately, an overhaul of the old codebase has caused several different bugs to appear while the transition to a new codebase was made. Please read the manual for more information on this issue, and what types of bugs you may expect."
echo
echo "If you wish, I can install a pre-built library, made for Ubuntu. It was built on November 15 2021, and is based on version 6.2. This version has been tested for correct functionality. Since it is not installed through a package manager, uninstalling is a manual task. The files will reside in /usr/local/lib."
while true; do
    echo
    read -p "Do you want me to install libgdiplus? (You can press [s] to stop the installation)" yns
    case $yns in
        [Yy]* ) installlibgdiplus=true; break;;
        [Nn]* ) installlibgdiplus=false; break;;
        [Ss]* ) echo "Stopping installation"; exit 0;;
        * ) echo "Please answer [y]es or [n]o.";;
    esac
done

echo "--------------------------------------------------"
echo
echo "I will need to install fontconfig to allow ESL Web Server to manage the fonts on your system. In addition, I could install Vera Fonts, an open-source and free font used by the default templates. If you plan on changing your templates soon you can answer no. Please note that the default templates may look odd in the meantime as a different available font will be used instead"
while true; do
    echo
    read -p "Do you want me to install the Vera Fonts?" yns
    case $yns in
        [Yy]* ) verafonts=true; break;;
        [Nn]* ) verafonts=false; break;;
        [Ss]* ) echo "Stopping installation"; exit 0;;
        * ) echo "Please answer [y]es or [n]o.";;
    esac
done

echo "--------------------------------------------------"
echo
echo "MySQL is a relational database, that ESL Web Server can use to store products and/or to store the system tables like logs and link tables. This installer will provide you with a default database, a default product table in that database and a default user with rights on that table. If you choose no, a CSV product database will be used instead and the system tables will be stored in a SQLite table, and no additional programs will be installed."
while true; do
    echo
    read -p "Do you want me to install and preconfigure MySQL? Choose [n]o for CSV and SQLite." yns
    case $yns in
        [Yy]* ) installmysql=true; break;;
        [Nn]* ) installmysql=false; break;;
        [Ss]* ) echo "Stopping installation"; exit 0;;
        * ) echo "Please answer [y]es or [n]o.";;
    esac
done

echo "--------------------------------------------------"
echo
echo "By default, ESL Web Server will listen to all incoming requests on ports 80 and 443, (the HTTP and HTTPS ports) with a self-signed certificate from Opticon to encrypt the HTTPS traffic. This setup means that connecting to the IP of this device will automatically show the user the ESL Web Server interface."
echo "Of course, if you want to host more applications on this device besides ESL Web Server, then you can use a remote proxy instead. In that case, ESL Web Server can be switched to listen to localhost requests on port 5000 (HTTP) and no certificate will be used."
while true; do
    echo
    read -p "Do you want ESL Web Server to listen to all requests and encrypt traffic with a self-signed certificate? Choose [n]o to configure ESL Web Server to listen to localhost ports 5000 without a self-signed certificate." yns
    case $yns in
        [Yy]* ) listenall=true; break;;
        [Nn]* ) listenall=false; break;;
        [Ss]* ) echo "Stopping installation"; exit 0;;
        * ) echo "Please answer [y]es or [n]o.";;
    esac
done

if [ "$listenall" = false ] ; then
    echo
    echo "OK, ESL Web Server will listen to localhost port 5000 instead."
    echo "If you like, I can install Apache for you and add a default reverse proxy configuration so requests on ports 80 and 443 are forwarded to ESL Web Server. This file can be used as a starting point for your own customized configuration."
    while true; do
        echo
        read -p "Do you want me to install and preconfigure Apache?" yns
        case $yns in
            [Yy]* ) installapache=true; break;;
            [Nn]* ) installapache=false; break;;
            [Ss]* ) echo "Stopping installation"; exit 0;;
            * ) echo "Please answer [y]es or [n]o.";;
        esac
    done
fi

#Now the variables set during the user interactions will be used to perform the installation of requested programs and accompanying settings.

#it's possible the widely used fontconfig package is not available (usually on server environments)
echo "Installing fontconfig..."
sudo apt install fontconfig -y

if [ "$verafonts" = true ] ; then
    echo "Installing Vera fonts..."
    /bin/bash $INSTALLPATH/verafonts_installer.sh
fi
if [ "$installmysql" = true ] ; then
    echo "Installing and configuring MySQL..."
    /bin/bash $INSTALLPATH/mysql/script_mysql.sh "$HOMEPATH"
    #Now we copy mysql_app.config to the DEPLOYPATH, but the resultant file will be owned by root with different modifiers than the files we want to replace.
    #For that reason, we copy mysql_app.config over the existing .config files so their owner and modifiers are not touched.
    #Using a mv command instead of cp would make the last rm command unnecessary, but changed ownership and modifiers could mess with read rights
    cp $APPCONFPATH/$MYSQLCONF $DEPLOYPATH
    cp $DEPLOYPATH/$MYSQLCONF $DEPLOYPATH/app.config
    cp $DEPLOYPATH/$MYSQLCONF $DEPLOYPATH/EslCoreWebApplication.dll.config
	cp $MYSQLSVC $INSTALLPATH
    rm $DEPLOYPATH/$MYSQLCONF
	
else
    echo "Configuring default CSV product database and SQLite for logs..."
    #See comment on TRUE for an explanation
    cp $APPCONFPATH/$CSVCONF $DEPLOYPATH
    cp $DEPLOYPATH/$CSVCONF $DEPLOYPATH/app.config
    cp $DEPLOYPATH/$CSVCONF $DEPLOYPATH/EslCoreWebApplication.dll.config
	cp $CSVSVC $INSTALLPATH
    rm $DEPLOYPATH/$CSVCONF
    # INSTALLPATH/csv/dbase.csv (CSVDB) must be copied to running DEPLOYPATH/Output, where Output is probably missing
	if [ ! -d $DEPLOYPATH/Output ]; then
        sudo mkdir -p $DEPLOYPATH/Output
	fi
	cp $CSVDB $DEPLOYPATH/Output/
fi

if [ "$listenall" = false ] ; then
    echo "Configuring ESL Web Server to only listen to localhost on port 5000, without a self-signed certificate..."
	rm -rf $DEPLOYPATH/ebs-50.pfx $DEPLOYPATH/certificate.json
	cp $APPCONFPATH/localhost_appsettings.json $DEPLOYPATH/appsettings.json
	if [ "$installapache" = true ] ; then
        echo "Installing and configuring Apache2..."
        /bin/bash $INSTALLPATH/apache2/script_apache.sh "$HOMEPATH"
	    #NOTE: The current Apache config will only listen on port 80.
	fi
fi

if [ "$installlibgdiplus" = true ] ; then
    echo "Installing graphics libraries..."
    /bin/bash $INSTALLPATH/libgdiplus/install_libgdiplus.sh $HOMEPATH
fi

echo "Done with installing! The deploy script will now run and start ESL Web Server."
/bin/bash $INSTALLPATH/deployscript.sh $USER $HOMEPATH