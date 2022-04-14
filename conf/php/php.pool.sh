#!/bin/bash

#[ -f "../../$1" ] && source "../../$1"

echo
echo "---------------------------------------"
echo "PHP www.conf"
echo "---------------------------------------"
echo

sudo cp /etc/php/${php_version}/fpm/pool.d/www.conf www.orig.conf

sudo -E nodejs php.pool.js

sudo mv /etc/php/${php_version}/fpm/pool.d/www.conf /etc/php/${php_version}/fpm/pool.d/www.conf_
sudo cp www.conf /etc/php/${php_version}/fpm/pool.d/
