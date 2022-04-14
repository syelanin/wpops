#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: vhost.sh example.com"
  exit 1
fi


DIR=$(pwd)
CONF=$DIR/conf
DATA=$DIR/vhost
LOG=$DATA/$1.log

source $DATA/$1.conf


# find conf -type f -iname '*.sh' -exec chmod +x {} \;

START=$(date)

echo VHOST $1 | tee $LOG
echo $START | tee -a $LOG
echo | tee -a $LOG

cd $CONF/nginx
./nginx.nossl.sh | tee -a $LOG
[[ "${ssl}" == 'true' ]] && ./nginx.certbot.sh | tee -a $LOG
[[ "${fastcgi_cache}" == 'true' ]] && ./nginx.fastcgi_cache.sh | tee -a $LOG
[[ "${ssl}" == 'true' && "${fastcgi_cache}" == 'true' ]] && ./nginx.ssl_cache.sh | tee -a $LOG
[[ "${ssl}" != 'true' && "${fastcgi_cache}" == 'true' ]] && ./nginx.nossl_cache.sh | tee -a $LOG
./nginx.reload.sh | tee -a $LOG

END=$(date)

echo | tee -a $LOG
echo "start: $START" | tee -a $LOG
echo "end:   $END" | tee -a $LOG
echo | tee -a $LOG
