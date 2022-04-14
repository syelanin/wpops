#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: lemp.sh example.com"
  exit 1
fi


DIR=$(pwd)
CONF=$DIR/conf
DATA=$DIR/lemp
LOG=$DATA/$1.log

source $DATA/$1.conf


# find conf -type f -iname '*.sh' -exec chmod +x {} \;

START=$(date)

echo LEMP $1 | tee $LOG
echo $START | tee -a $LOG
echo | tee -a $LOG

cd $CONF/os
./os.init.sh | tee -a $LOG

[[ "${mysql}" == 'true' ]] && cd $CONF/mysql
[[ "${mysql}" == 'true' ]] && ./mysql.init.sh | tee -a $LOG
[[ "${mysql}" == 'true' ]] && ./mysql.restart.sh | tee -a $LOG

cd $CONF/php
./php.init.sh | tee -a $LOG
./php.ini.sh | tee -a $LOG
./php.pool.sh | tee -a $LOG
./php.restart.sh | tee -a $LOG

cd $CONF/nginx
./nginx.init.sh | tee -a $LOG

cd $CONF/os
./firewall.init.sh | tee -a $LOG

END=$(date)

echo | tee -a $LOG
echo "start: $START" | tee -a $LOG
echo "end:   $END" | tee -a $LOG
echo | tee -a $LOG
