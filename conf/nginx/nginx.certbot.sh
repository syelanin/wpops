#!/bin/bash

#[ -f "../../$1" ] && source "../../$1"

echo
echo "---------------------------------------"
echo "LetsEncrypt SSL cert install"
echo "---------------------------------------"
echo

sudo certbot certonly --nginx --domain ${domain} --noninteractive --agree-tos --email ${certbot_email} --no-eff-email
echo
sudo certbot renew --dry-run
