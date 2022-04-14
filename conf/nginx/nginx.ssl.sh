#!/bin/bash

#[ -f "../../$1" ] && source "../../$1"

echo
echo "---------------------------------------"
echo "Nginx SSL config"
echo "---------------------------------------"
echo

sudo -E nodejs nginx.ssl.js

dest=${domain}-ssl.conf

sudo cp -f ${dest} /etc/nginx/sites-available/${domain}
sudo ln -s -f /etc/nginx/sites-available/${domain} /etc/nginx/sites-enabled/${domain}
sudo cp -f nginx.conf /etc/nginx/
