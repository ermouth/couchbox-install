#!/bin/sh

echo ""
echo "START 5-ubuntu-redis.sh"
echo ""


# config
BASEDIR=$(dirname "$0")
BASEDIRPATH=$(realpath $BASEDIR)
. $BASEDIRPATH/config.sh


# update & install deps
sudo apt-get update -y
sudo apt-get install build-essential tcl -y


# download redis
cd /tmp
curl -O http://download.redis.io/redis-stable.tar.gz
tar xzvf redis-stable.tar.gz


# install redis
cd redis-stable
make
# make test
sudo make install


echo "DONE 5-ubuntu-redis.sh"
exit 0
