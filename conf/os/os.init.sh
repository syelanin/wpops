#!/bin/bash

#[ -f "../../$1" ] && source "../../$1"

echo
echo "---------------------------------------"
echo "OS update"
echo "---------------------------------------"
echo

sudo apt -y update 
#sudo apt -y upgrade
#sudo apt -y autoremove

sudo apt install -y curl wget nano unzip nodejs

echo
echo "---------------------------------------"
echo "OS set swap"
echo "---------------------------------------"
echo

sudo fallocate -l ${swap_size} /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
sudo swapon --show
