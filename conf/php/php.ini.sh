#!/bin/bash

#[ -f "../../$1" ] && source "../../$1"

echo
echo "---------------------------------------"
echo "PHP php.ini"
echo "---------------------------------------"
echo

sudo cp /etc/php/${php_version}/fpm/php.ini php.orig.ini

sudo -E nodejs php.ini.js

sudo mv /etc/php/${php_version}/fpm/php.ini /etc/php/${php_version}/fpm/php.ini_
sudo cp php.ini /etc/php/${php_version}/fpm/
