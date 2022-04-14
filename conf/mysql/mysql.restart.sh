#!/bin/bash

#[ -f "../../$1" ] && source "../../$1"

echo
echo "---------------------------------------"
echo "Mysql restart"
echo "---------------------------------------"
echo

sudo systemctl --no-pager -l restart mysql
