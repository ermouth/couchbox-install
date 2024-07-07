#!/bin/sh

echo ""
echo "START 06-redis-configure.sh"
echo ""


# config
BASEDIR=$(dirname "$0")
BASEDIRPATH=$(realpath $BASEDIR)
. $BASEDIRPATH/config.sh

# vars
if [ -z ${REDIS_PASS+x} ]; then REDIS_PASS=couchbox; else echo "REDIS_PASS is set to '$REDIS_PASS'"; fi

# stop redis
sudo service redis stop

# update redis.conf
# sudo sed -i 's/pidfile \/var\/run\/redis_6379.pid/pidfile \/var\/run\/redis.pid/g' /etc/redis/redis.conf
sudo sed -i 's/supervised no/supervised systemd/g' /etc/redis/redis.conf
sudo sed -i "s/# requirepass foobared/requirepass $REDIS_PASS/g" /etc/redis/redis.conf
sudo sed -i "s/dir .\//dir \/var\/lib\/redis/g" /etc/redis/redis.conf

# start redis
sudo service redis start
# add to startup
sudo systemctl enable redis


echo "DONE 06-redis-configure.sh"
exit 0
