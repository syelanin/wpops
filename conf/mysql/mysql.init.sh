#!/bin/bash

#[ -f "../../$1" ] && source "../../$1"

echo
echo "---------------------------------------"
echo "Mysql install"
echo "---------------------------------------"
echo

if echo $mysql_version | egrep "^5"; then

sudo apt -y update
sudo apt install -y mysql-server

else

# https://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/

# https://dev.mysql.com/downloads/repo/apt/
# Download. No thanks link

wget https://dev.mysql.com/get/mysql-apt-config_$mysql_version-1_all.deb -P ~
sudo DEBIAN_FRONTEND=noninteractive dpkg -i ~/mysql-apt-config*

#sudo dpkg-reconfigure mysql-apt-config

sudo apt -y update

sudo debconf-set-selections <<< "mysql-community-server mysql-community-server/root-pass password ${db_root_pass}"
sudo debconf-set-selections <<< "mysql-community-server mysql-community-server/re-root-pass password ${db_root_pass}"
sudo debconf-set-selections <<< "mysql-community-server mysql-server/default-auth-override select Use Legacy Authentication Method (Retain MySQL 5.x Compatibility)"

sudo DEBIAN_FRONTEND=noninteractive apt install -y mysql-server
sudo debconf-show mysql-community-server

echo
echo "---------------------------------------"
echo "Mysql auth settings"
echo "---------------------------------------"
echo

cat /etc/mysql/mysql.conf.d/default-auth-override.cnf

fi

echo
echo "---------------------------------------"
echo "Mysql status"
echo "---------------------------------------"
echo

sudo systemctl --no-pager -l status mysql

echo
echo "---------------------------------------"
echo "Mysql create DB"
echo "---------------------------------------"
echo

sudo -E nodejs mysql.conf.js

sudo mysql -u root -p${db_root_pass} < mysql.secure.sql
sudo mysql -u root -p${db_root_pass} < db.sql

echo
echo "---------------------------------------"
echo "Mysql firewall"
echo "---------------------------------------"
echo

sudo ufw allow mysql
