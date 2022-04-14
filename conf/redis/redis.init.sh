#!/bin/bash

#[ -f "../../$1" ] && source "../../$1"

echo
echo "---------------------------------------"
echo "Redis install"
echo "---------------------------------------"
echo

sudo apt install -y redis redis-tools

echo
echo "---------------------------------------"
echo "Redis status"
echo "---------------------------------------"
echo

sudo systemctl --no-pager -l -l status redis

echo
echo "---------------------------------------"
echo "Redis config"
echo "---------------------------------------"
echo

sudo cp /etc/redis/redis.conf redis.orig.conf

sudo -E nodejs redis.conf.js

sudo cp -f redis.conf /etc/redis/

echo
echo "---------------------------------------"
echo "Redis irewall"
echo "---------------------------------------"
echo

sudo ufw allow 6379/tcp
