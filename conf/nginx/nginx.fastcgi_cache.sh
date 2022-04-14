#!/bin/bash

#[ -f "../../$1" ] && source "../../$1"

echo
echo "---------------------------------------"
echo "Nginx Fastcgi cache install"
echo "---------------------------------------"
echo

sudo mkdir -p /var/cache/nginx/${domain}

echo "tmpfs /var/cache/nginx/${domain} tmpfs defaults,size=${fastcgi_cache_size} 0 0" | sudo tee -a /etc/fstab
echo

sudo mount -a
echo

sudo df -ah | grep tmpfs
