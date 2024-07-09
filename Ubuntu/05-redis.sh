#!/bin/sh

echo ""
echo "START 05-redis.sh"
echo ""


# config
BASEDIR=$(dirname "$0")
BASEDIRPATH=$(realpath $BASEDIR)
. $BASEDIRPATH/config.sh


# update & install deps
sudo apt-get update -y
sudo apt-get install tcl -y

# fix permissions & add user redis
sudo mkdir /var/lib/redis
sudo adduser --system --group --no-create-home redis
sudo chown redis:redis /var/lib/redis
sudo chmod 770 /var/lib/redis


sudo apt install -y redis-server

echo "DONE 05-redis.sh"
exit 0
