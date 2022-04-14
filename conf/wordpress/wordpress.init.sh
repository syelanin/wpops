#!/bin/bash

#[ -f "../../$1" ] && source "../../$1"

echo
echo "---------------------------------------"
echo "Wordpress install"
echo "---------------------------------------"
echo

wget https://wordpress.org/latest.zip -P ~
unzip -q ~/latest.zip -d ~

[ -d /var/www/${domain} ] && sudo rm -rf /var/www/${domain}
sudo mkdir -p /var/www/${domain}
sudo cp -a ~/wordpress/* /var/www/${domain}

echo
echo "---------------------------------------"
echo "Wordpress config"
echo "---------------------------------------"
echo

curl -s https://api.wordpress.org/secret-key/1.1/salt/ > salts.txt

sudo -E nodejs wp.vars.js

sudo cat wp.vars-db.conf > wp-config.php
sudo cat salts.txt >> wp-config.php
[ "$redis_cache" == "true" ] && sudo cat wp.cache.conf >> wp-config.php
sudo cat wp.const.conf >> wp-config.php

[ -f /var/www/${domain}/wp-config.php ] && sudo mv /var/www/${domain}/wp-config.php /var/www/${domain}/wp-config.php_
sudo cp wp-config.php /var/www/${domain}/

sudo chown -R www-data: /var/www/${domain}

echo
echo "---------------------------------------"
echo "Wordpress cleanup"
echo "---------------------------------------"
echo

rm -f salts.txt
sudo rm -rf ~/wordpress
sudo rm -rf ~/latest.zip
