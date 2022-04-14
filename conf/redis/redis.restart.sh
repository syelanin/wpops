#!/bin/bash

#[ -f "../../$1" ] && source "../../$1"

echo
echo "---------------------------------------"
echo "Redis restart"
echo "---------------------------------------"
echo

sudo systemctl --no-pager -l restart redis
