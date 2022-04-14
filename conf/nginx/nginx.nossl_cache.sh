#!/bin/bash

#[ -f "../../$1" ] && source "../../$1"

echo
echo "---------------------------------------"
echo "Nginx no-SSL cache config"
echo "---------------------------------------"
echo

sudo -E nodejs nginx.nossl_cache.js

dest=${domain}-nossl-cache.conf

sudo cp -f ${dest} /etc/nginx/sites-available/${domain}
sudo ln -s -f /etc/nginx/sites-available/${domain} /etc/nginx/sites-enabled/${domain}
sudo cp -f nginx.conf /etc/nginx/
