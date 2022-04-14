#!/bin/bash

#[ -f "../../$1" ] && source "../../$1"

echo
echo "---------------------------------------"
echo "Nginx reload"
echo "---------------------------------------"
echo

sudo nginx -t

echo

sudo systemctl --no-pager -l reload nginx
