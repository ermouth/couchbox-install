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

sudo apt install redis-server

echo "DONE 05-redis.sh"
exit 0
