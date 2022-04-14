#!/bin/bash

#[ -f "../../$1" ] && source "../../$1"

echo
echo "---------------------------------------"
echo "Firewall enable"
echo "---------------------------------------"
echo

sudo ufw allow 'OpenSSH'

sudo ufw --force enable
sudo ufw status
