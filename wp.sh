#!/bin/bash

if [ -z "$1" ]; then
  echo "Usage: wp.sh example.com"
  exit 1
fi


DIR=$(pwd)
CONF=$DIR/conf
DATA=$DIR/wp
LOG=$DATA/$1.log

source $DATA/$1.conf


# find conf -type f -iname '*.sh' -exec chmod +x {} \;

START=$(date)

echo WP $1 | tee $LOG
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
./nginx.nossl.sh | tee -a $LOG
[[ "${ssl}" == 'true' ]] && ./nginx.certbot.sh | tee -a $LOG
[[ "${fastcgi_cache}" == 'true' ]] && ./nginx.fastcgi_cache.sh | tee -a $LOG
[[ "${ssl}" == 'true' && "${fastcgi_cache}" == 'true' ]] && ./nginx.ssl_cache.sh | tee -a $LOG
[[ "${ssl}" != 'true' && "${fastcgi_cache}" == 'true' ]] && ./nginx.nossl_cache.sh | tee -a $LOG
./nginx.reload.sh | tee -a $LOG

[[ "${redis_cache}" == 'true' ]] && cd $CONF/redis
[[ "${redis_cache}" == 'true' ]] && ./redis.init.sh | tee -a $LOG
[[ "${redis_cache}" == 'true' ]] && ./redis.restart.sh | tee -a $LOG

cd $CONF/wordpress
./wordpress.init.sh | tee -a $LOG

cd $CONF/os
./firewall.init.sh | tee -a $LOG

END=$(date)

echo | tee -a $LOG
echo "start: $START" | tee -a $LOG
echo "end:   $END" | tee -a $LOG
echo | tee -a $LOG
