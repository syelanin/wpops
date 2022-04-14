#!/bin/bash

#[ -f "../../$1" ] && source "../../$1"

echo
echo "---------------------------------------"
echo "PHP install"
echo "---------------------------------------"
echo

sudo add-apt-repository -y ppa:ondrej/php
sudo apt -y update

sudo apt install -y php${php_version} \
php${php_version}-fpm \
php${php_version}-common \
php${php_version}-cli \
php${php_version}-curl \
php${php_version}-gd \
php${php_version}-intl \
php${php_version}-imagick \
php${php_version}-imap \
php${php_version}-mbstring \
php${php_version}-mysql \
php${php_version}-mysqlnd \
php${php_version}-recode \
php${php_version}-tidy \
php${php_version}-xml \
php${php_version}-xmlrpc \
php${php_version}-zip \
php${php_version}-redis \
php${php_version}-mcrypt

echo
sudo systemctl enable php${php_version}-fpm
echo
sudo php${php_version} -v

echo
echo "---------------------------------------"
echo "PHP status"
echo "---------------------------------------"
echo

sudo systemctl --no-pager -l status php${php_version}-fpm
