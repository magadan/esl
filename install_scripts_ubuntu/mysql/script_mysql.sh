#!/bin/bash

if [ $USER != "root" ]; then
   sudo $0 $HOME
   exit 0
fi

#This script needs to be called by a root script with the HOME parameter, or just by a normal user because the script will then ask for root itself with HOME as the parameter.
INSTALLPATH="$1/install_scripts_ubuntu/mysql"
ROOTPW="esl"
SQLPRODUCTS="products_mysql.sql"
DBNAME="esl"
DBUSERNAME="user"
DBUSERDOMAIN="localhost"
DBUSERPW="eslpassword"

sudo apt install mysql-server -y
sudo mysql --user=root --password=$ROOTPW < $INSTALLPATH/$SQLPRODUCTS
sudo mysql --user=root --password=$ROOTPW <<QUERIES
CREATE USER '$DBUSERNAME'@'$DBUSERDOMAIN' IDENTIFIED BY '$DBUSERPW';
GRANT ALL PRIVILEGES ON $DBNAME.* TO '$DBUSERNAME'@'$DBUSERDOMAIN';
FLUSH PRIVILEGES;
QUERIES

#Add extra commands to be sent in between the QUERIES tags.
#DO NOT ADD SPACES IN FRONT OF THE CLOSING "QUERIES" TAG
#If you do, it assumes that line to be another query instead of the closing tag.
