#!/bin/bash

#[ -f "../../$1" ] && source "../../$1"

echo
echo "---------------------------------------"
echo "Nginx install"
echo "---------------------------------------"
echo

sudo apt purge -y apache2
sudo apt -y autoremove
sudo add-apt-repository -y ppa:certbot/certbot
sudo apt -y update
sudo apt install -y fail2ban
sudo apt install -y python-certbot-nginx
sudo apt install -y nginx

echo
echo "---------------------------------------"
echo "Nginx status"
echo "---------------------------------------"
echo

sudo systemctl --no-pager -l status nginx

echo
echo "---------------------------------------"
echo "Nginx firewall"
echo "---------------------------------------"
echo

sudo ufw allow 'Nginx Full'
