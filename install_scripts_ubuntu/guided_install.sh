#!/bin/bash

HOMEPATH=$2
INSTALLPATH="$HOMEPATH/install_scripts_ubuntu"
DEPLOYPATH="$HOMEPATH/linux_x64_deploy"

APPCONFPATH="$INSTALLPATH/appconfig"
MYSQLCONF="mysql_app.config"
MYSQLSVC="$INSTALLPATH/mysql/eslcorewebapp.service"
CSVCONF="csv_products_sqlite_logs_app.config"
CSVDB="$INSTALLPATH/csv/dbase.csv"
CSVSVC="$INSTALLPATH/csv/eslcorewebapp.service"

cp $APPCONFPATH/$CSVCONF $DEPLOYPATH
cp $DEPLOYPATH/$CSVCONF $DEPLOYPATH/app.config
cp $DEPLOYPATH/$CSVCONF $DEPLOYPATH/EslCoreWebApplication.dll.config
cp $CSVSVC $INSTALLPATH
rm $DEPLOYPATH/$CSVCONF
mkdir -p $DEPLOYPATH/Output
cp $CSVDB $DEPLOYPATH/Output/

/bin/bash $INSTALLPATH/deployscript.sh $USER $HOMEPATH