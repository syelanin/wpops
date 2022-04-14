#!/bin/bash

#[ -f "../../$1" ] && source "../../$1"

echo
echo "---------------------------------------"
echo "PHP restart"
echo "---------------------------------------"
echo

sudo systemctl --no-pager -l restart php${php_version}-fpm
