#!/bin/bash

#[ -f "../../$1" ] && source "../../$1"

echo
echo "---------------------------------------"
echo "Nginx no-SSL config"
echo "---------------------------------------"
echo

sudo mkdir -p /var/www/${domain}
echo "Welcome!" | sudo tee /var/www/${domain}/index.html

sudo -E nodejs nginx.nossl.js

dest=${domain}-nossl.conf

sudo cp -f ${dest} /etc/nginx/sites-available/${domain}
sudo ln -s -f /etc/nginx/sites-available/${domain} /etc/nginx/sites-enabled/${domain}
sudo cp -f nginx.conf /etc/nginx/
sudo rm -f /etc/nginx/sites-enabled/default
